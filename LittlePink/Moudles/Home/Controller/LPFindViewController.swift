//
//  LPFindViewController.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/27.
//  Copyright © 2023 wtt. All rights reserved.
//

import UIKit
import SnapKit


//加个LPHorizontalMenuViewController
//childvc都是一个 只是数据不同
class LPFindViewController: LPBaseViewController{
  
    var frame : CGRect = CGRectZero
    var titles : [String] = []
    var childVCs : [UIViewController] = []
    var layout : LPHorizontalMenuLayout?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemPink
        initData()
        setupMenuVC()
    }
    
    private func initData(){
        //44 pagetitleview的高度
        //为什么x y 是 0 0
        frame = CGRect(x: 0, y:0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVBAR_FULL_HEIGHT - TABBAR_HEIGHT - 44)
        
//        titles = ["推荐","购物","杭州","穿搭","婚礼","情感","美食","职场","明星","汽车"]
        titles = ["推荐","购物","杭州","穿搭","婚礼","情感","美食"]
        
        for _ in 0 ..< titles.count {
            let childVC = LPSubFindViewController()
            childVCs.append(childVC)
        }

        layout = LPHorizontalMenuLayout()
        layout?.titleBarHeight = 22
        layout?.titleLeftMargin = 0.0
    }
    
    private func setupMenuVC(){
        let menuVC = LPHorizontalMenuViewController(frame: frame, titles: titles, childVCs: childVCs,layout: layout!)
        menuVC.view.frame = frame
        addChild(menuVC)
        view.addSubview(menuVC.view)
    }

}


