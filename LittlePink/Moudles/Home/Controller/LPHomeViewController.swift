//
//  LPHomeViewController.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/13.
//  Copyright © 2023 wtt. All rights reserved.
//

import UIKit

class LPHomeViewController: UIViewController {
    var frame : CGRect = CGRectZero
    var titles : [String] = []
    var childVCs : [UIViewController] = []
    var layout : LPHorizontalMenuLayout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#99FFCC")//浅蓝绿
        initData()
        setupMenuVC()
    }
    
    private func setupMenuVC(){
        let menuVC = LPHorizontalMenuViewController(frame: frame, titles: titles, childVCs: childVCs,layout: layout!)
        menuVC.view.backgroundColor = UIColor(hexString: "#33CCFF") //浅蓝色
        menuVC.view.frame = frame
        addChild(menuVC)
        view.addSubview(menuVC.view)
    }
    
    private func initData(){
        initFrame()
        initTitles()
        initChildVCs()
        initLayout()
    }
    
    
    private func initFrame(){
        frame = CGRect(x: 0, y: STATUSBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - STATUSBAR_HEIGHT)
    }
    
    private func initTitles(){
//        titles = ["关注","发现","文创精选","听书","书单广场","三体","怎么获得子控件的宽度","浅蓝色","翠绿色","FIXME"]
        titles = ["关注","发注","附近"]

    }
    
    private func initChildVCs(){
        for _ in 0...(titles.count - 1){
            let childVC = UIViewController()
            childVC.view.backgroundColor = UIColor.randomColor
            childVCs.append(childVC)
        }
    }
    
    private func initLayout(){
        layout = LPHorizontalMenuLayout()
    }

}
