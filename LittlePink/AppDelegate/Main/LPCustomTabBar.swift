//
//  LPCustomTabBar.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/14.
//  Copyright © 2023 wtt. All rights reserved.
//

import UIKit

protocol LPCustomTabBarDelegate : AnyObject{
    func customTabBarButtonClick(myTabBar : LPCustomTabBar,selectedIndex : Int)
}

class LPCustomTabBar: UIView {
    weak var delegate : LPCustomTabBarDelegate?
    
    var buttonArray = [UIButton]()///---懒加载
    var selectedButton : UIButton?
    var clickTabButtonBlock : (() -> Void)?
    private var currentIndex : Int = 0
//    let colorArr = [UIColor.red,UIColor.green,UIColor.blue,UIColor.orange,UIColor.purple]
    
    //MARK : 设置子控件frame
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ///1. 设置中间按钮的frame
        setupCenterButtonFrame()
        ///2. 设置选项卡按钮的frame
    }
    
    private func setupCenterButtonFrame(){
        let count = buttonArray.count
        let buttonWidth = self.frame.size.width / CGFloat(count)
        let buttonHeight = self.frame.size.height
        var i = 0
        while i < count {
            let button = self.buttonArray[i]
            button.frame = CGRect(x: CGFloat(i) * buttonWidth, y: 0, width: buttonWidth, height: buttonHeight)
            print("button \(i) frame \(button.frame)")
            i+=1
        }
    }
    
    private func setupOtherButtonFrame(){
        
    }
}


extension LPCustomTabBar{
    func addTabBarButton(tabBarItemArray : NSArray){
        for tabBarItem in tabBarItemArray {
            let item = tabBarItem as! UITabBarItem
            let button = UIButton()
            button.tag = buttonArray.count
//            button.backgroundColor = colorArr[Int(arc4random_uniform(4))]
            button.setTitle(item.title, for: .normal)
            button.setImage(item.image, for: .normal)
            button.setImage(item.selectedImage, for: .highlighted)
            button.setTitleColor(.darkGray, for: .normal)
            button.setTitleColor(.systemPink, for: .selected)
            button.titleLabel?.font = .systemFont(ofSize: 20)
            self.addSubview(button)
            buttonArray.append(button)
            
            button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchDown)
        }
        //设置默认选中的按钮
        buttonClick(button: buttonArray[0])
    }
    
    @objc private func buttonClick(button : UIButton){
        selectedButton?.isSelected = false
        button.isSelected = true
        selectedButton = button
        
        //代理方法
        delegate?.customTabBarButtonClick(myTabBar: self, selectedIndex: button.tag)
    }
}
