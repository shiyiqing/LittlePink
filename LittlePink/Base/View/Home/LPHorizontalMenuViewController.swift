//
//  LPHorizontalMenuViewController.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/20.
//  Copyright © 2023 wtt. All rights reserved.
//

import UIKit
// FIXME : 先用vc 添加 验证 如果正确 别的vc 可以直接添加 view

class LPHorizontalMenuViewController: UIViewController, LPPageTitleViewDelegate{
    func titleButtonClick(titleView: LPPageTitleView, selectedIndex: Int) {
        //切换到新的vc old  -> new
        guard selectedIndex < childVCs.count else {return }
//        let currentVC = childVCs[selectedIndex]
        let X = frame.size.width * CGFloat(selectedIndex) //frame.size.width
        scrollView?.contentOffset.x = X
        self.selectedIndex = selectedIndex
    }
    

    private var scrollView : UIScrollView?
    private var titleView : LPPageTitleView?
    
    private var layout: LPHorizontalMenuLayout
    
    var frame : CGRect = CGRectZero
    var titles : [String] = []
    var childVCs : [UIViewController] = []
    
    var selectedIndex :Int = 0
    
    private var offsetX : CGFloat = 0.0
    
    init(frame : CGRect, titles : [String],childVCs : [UIViewController],layout : LPHorizontalMenuLayout){
        self.frame = frame
        self.titles = titles
        self.childVCs = childVCs
        self.layout = layout
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainerView()
        setupTitleView()
        setupChildVCs()
        setupLayout()
    }
    
    private func setupLayout(){
        
    }
    
    private func setupChildVCs(){
        for i in 0...(titles.count - 1){
            let childVC = childVCs[i]
            //设置viewController的frame
            let X = (scrollView?.frame.size.width)! * CGFloat(i)
            let Y = (titleView?.frame.size.height)!
            let W = scrollView?.frame.size.width
            let H = (scrollView?.frame.size.height)! - layout.titleBarHeight
            childVC.view.frame = CGRect(x: X, y: Y, width: W!, height: H)
            addChild(childVC)
            scrollView!.addSubview(childVC.view)
        }
    }
    
    private func setupContainerView(){
        scrollView = UIScrollView()
        // TODO : frame 在导航栏下面 要判断导航栏的高度 y = navH
        scrollView?.frame = CGRect(x:0, y:0, width:frame.size.width, height:frame.size.height)
        scrollView?.isScrollEnabled = true
        scrollView?.bounces = false
        scrollView?.isPagingEnabled = true
        scrollView?.delegate = self
//        scrollView!.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(scrollView!)
    }
    
    //怎么获得子控件的宽度
    private func setupTitleView(){
        let frame = CGRect(x:0, y:0, width:(scrollView?.frame.size.width)!, height:layout.titleBarHeight)
        titleView = LPPageTitleView(frame: frame, titles: titles,layout: layout)
        // TODO : frame
        view.addSubview(titleView!)
        titleView?.delegate = self
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //根据子控件的frame设置contentsize
        scrollView?.contentSize = CGSize(width:(scrollView?.frame.size.width)! * CGFloat(childVCs.count), height:(scrollView?.frame.size.height)!)
        
    }
}

extension LPHorizontalMenuViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDidScrollContentOffsetX(scrollContentOffsetX: scrollView.contentOffset.x)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        offsetX = scrollView.contentOffset.x
    }
    
    private func scrollViewDidScrollContentOffsetX(scrollContentOffsetX : CGFloat){
        
        //根据左右滑动方向的不同取不同值
        var indexVC : CGFloat = scrollContentOffsetX / (scrollView?.frame.size.width)!
        if scrollContentOffsetX < offsetX{// scrollContentOffsetX  <- offsetX 左滑 向上取整
            indexVC = ceil(indexVC)
        }else if scrollContentOffsetX > offsetX{//右滑 向下取整
            indexVC = floor(indexVC)
        }
        titleView?.selectedTitleIndex(index: Int(indexVC))
    }
}
  

