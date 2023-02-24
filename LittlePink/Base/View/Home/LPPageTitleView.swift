//
//  LPPageTitleView.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/20.
//  Copyright © 2023 wtt. All rights reserved.
//

import UIKit

protocol LPPageTitleViewDelegate : AnyObject{
    func titleButtonClick(titleView : LPPageTitleView,selectedIndex : Int)
}

public typealias didSelectTitleViewHandle = (Int) -> Void

class LPPageTitleView: UIView {
    weak var delegate : LPPageTitleViewDelegate?
    
    var scrollView : UIScrollView?
    var containerView : UIView?
    var layout : LPHorizontalMenuLayout
    
    var titles : [String] = []///---懒加载
    var textWidths : [CGFloat] = []
    var buttonWidths : [CGFloat] = []
    var lineWidths : [CGFloat] = []
    var titleButtons : [LPCustomTabBarButton] = []
    var selectedButton : UIButton?
    var clickTabButtonBlock : (() -> Void)?
    
    var textTotal : CGFloat = 0
    var contentWidth : CGFloat = 0
    var firstTitleButton : UIButton?
    var firstTextWidth : CGFloat = 0
    
    private var currentIndex : Int = 0
    var sliderLineX : CGFloat = 0
    
    private lazy var sliderLineView: UIView = {
        // FIXME : lrMargin
        let sliderLineView = UIView(frame: CGRect(x: 0, y:frame.size.height - layout.sliderLineHeight, width: 0, height: layout.sliderLineHeight))
        sliderLineView.backgroundColor = layout.sliderLineColor
        sliderLineView.isHidden = layout.isHiddenSlider
        return sliderLineView
    }()
    
    
    //设置init函数
    @objc public init(frame: CGRect, titles: [String],layout : LPHorizontalMenuLayout) {
        self.titles = titles
        self.layout = layout
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "#FFFF66") //浅黄色
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupScrollAndContainerView(){
        scrollView = UIScrollView()
        // TODO : frame  外界传进来的title view的大小
        scrollView?.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        scrollView?.backgroundColor = UIColor(hexString: "#CCCC00") //暗黄色
        scrollView?.isScrollEnabled = true
        scrollView?.bounces = false
//        scrollView?.delegate = self
//        scrollView!.contentInsetAdjustmentBehavior = .never
        addSubview(scrollView!)

        containerView = UIView()
        // TODO : frame  可以设置margin
        containerView?.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        containerView?.backgroundColor = UIColor(hexString: "#FFCCCC") //浅粉色
        scrollView!.addSubview(containerView!)
    }
    
    private func setupTitleButtons(){
        // FIXME : 进行判空
        guard titles.count != 0 else { return }
        //Button
        // FIXME : height?
        let size = CGSize(width: CGFloat(MAXFLOAT), height: 10)
        //layout.lrMargin
        var upX : CGFloat = layout.titleLeftMargin
        let buttonHeight = layout.titleBarHeight - layout.sliderLineHeight
        for text in titles {
            // FIXME : 根据文字的宽度计算button的宽度
            // FIXME : font : layout.font
            let textWidth = textRectSize(text: text as NSString, font: UIFont.systemFont(ofSize: 16), size: size).size.width
            let buttonWidth = textWidth + layout.titleMargin
            
            let buttonRect = CGRect(x: upX, y: 0, width: buttonWidth, height: buttonHeight)
            let button = LPCustomTabBarButton()
            button.frame = buttonRect
            button.tag = layout.titleButtonStartTag + textWidths.count
            button.setTitle(text, for: .normal)
            button.backgroundColor = UIColor.randomColor
            button.setTitleColor(layout.titleColor, for: .normal)
            button.setTitleColor(layout.titleSelectColor, for: .selected)
            button.titleLabel?.font = layout.titleFont
            button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
            containerView!.addSubview(button)
            titleButtons.append(button)
            textWidths.append(textWidth)
            buttonWidths.append(buttonWidth)
            lineWidths.append(textWidth)
            //button.glt_layoutSubviews?()  ???
            
            //+layout.titleMargin
            upX = button.frame.origin.x + buttonWidth
            textTotal += buttonWidth
        }
    }
    
    private func setupDefaultValue(){
        //设置默认选中按钮
        selectedButton = titleButtons[0]
        currentIndex = 0
//        let firstTitle = titles[0]
        firstTitleButton = titleButtons[0]
//        let firstLineWidth = lineWidths[0]
        firstTextWidth = textWidths[0]
    }
    
    private func setupSliderLineView(){
        containerView!.addSubview(sliderLineView)
        
        let sliderLineWidth : CGFloat = sliderLineWidth(matchTitleTextWidth: firstTextWidth)
        
        let sliderLineX : CGFloat = firstTitleButton!.view_centerX - sliderLineWidth * 0.5
        
        if layout.sliderLineCornerRadius != 0.0 {
            sliderLineView.layer.cornerRadius = layout.sliderLineCornerRadius
            sliderLineView.layer.masksToBounds = true
            sliderLineView.clipsToBounds = true
        }
    
        sliderLineView.backgroundColor = UIColor.orange
//         sliderLineView = UIView(frame: CGRect(x: 0, y:frame.size.height - LPTabSliderLineHeight, width: 0, height: LPTabSliderLineHeight))
        sliderLineView.frame = CGRect(x:sliderLineX, y: frame.size.height - layout.sliderLineHeight, width: layout.sliderLineWidth, height: layout.sliderLineHeight)
    }
    
    private func refreshScrollAndContainerView(){
        contentWidth = textTotal + 2*layout.titleLeftMargin
        var containerViewX : CGFloat = 0.0
        //contentWidth 如果小于 scroll view设置frame的width
        if contentWidth < (scrollView?.frame.size.width)! {
            containerViewX = (scrollView!.view_width - contentWidth) * 0.5
        }
        scrollView?.contentSize = CGSize(width:contentWidth, height:frame.size.height)
        containerView?.frame = CGRect(x:containerViewX, y:0, width:contentWidth, height:frame.size.height)
    }
    
    private func setupSubViews(){
        //子控件的x y 是相对自己父控件的 所以不能和父控件的frame相同 x y 一般从0 0 开始 除非有margin
        setupScrollAndContainerView()
        setupTitleButtons()
        setupDefaultValue()
        setupSliderLineView()
        refreshScrollAndContainerView()
    }
    
    private func sliderLineWidth (matchTitleTextWidth : CGFloat) -> CGFloat {
        if layout.sliderLineWidth == sliderDefaultWidth {
            //默认处理 -
            return matchTitleTextWidth
        }else{
            //用户自定义固定值
            return layout.sliderLineWidth
        }
    }
    
    @objc private func buttonClick(button : UIButton){
        toSelectedButton(button: button)
        currentIndex = button.tag - layout.titleButtonStartTag
        //代理方法
        delegate?.titleButtonClick(titleView : self,selectedIndex : currentIndex)
    }
    
    private func toSelectedButton(button : UIButton){
        selectedButton?.isSelected = false
        button.isSelected = true
        selectedButton = button
        //被选中的按钮移动到屏幕中间
        setupTitleScrollToCenter(nextButton: button)
        //滑动条移动
        setupSliderScrollToCenter(nextButton: button)
    }
    
    //MARK: 让title的ScrollView滚动到中心点位置
    private func setupTitleScrollToCenter(nextButton: UIButton)  {
        if contentWidth < scrollView!.view_width {
            //do nothing
        }else{
            let btnCenterX = nextButton.center.x
            var scrollX = btnCenterX - (scrollView?.bounds.width)! * 0.5
            if scrollX < 0 {
                scrollX = 0
            }
            if scrollX > (scrollView?.contentSize.width)! - (scrollView?.bounds.width)! {
                scrollX = (scrollView?.contentSize.width)! - (scrollView?.bounds.width)!
            }
            scrollView?.setContentOffset(CGPoint(x: scrollX, y: 0), animated: true)
        }
    }
    
    //MARK: 滑动条移动
    //nextbutton
    private func setupSliderScrollToCenter(nextButton: UIButton)  {
        let sliderLineWidth : CGFloat = sliderLineWidth(matchTitleTextWidth: textWidths[nextButton.tag - layout.titleButtonStartTag])
        let sliderLineX = nextButton.center.x - sliderLineWidth * 0.5

        sliderLineView.frame.size.width = sliderLineWidth
        sliderLineView.frame.origin.x = sliderLineX
    }
    
    
    private func textRectSize(text : NSString,font : UIFont,size : CGSize) -> CGRect{
        let attributes = [NSAttributedString.Key.font : font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect : CGRect = text.boundingRect(with: size,options: option,attributes: attributes, context: nil)
        return rect
    }
    
}

extension LPPageTitleView{
    public func selectedTitleIndex(index : Int ){
        currentIndex = index
        // FIXME : 判断如果currentindex不合规
        guard currentIndex < titleButtons.count else { return  }
        toSelectedButton(button: titleButtons[currentIndex])
    }
}

