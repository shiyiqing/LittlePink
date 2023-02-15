//
//  LPMainTabBarController.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/13.
//  Copyright © 2023 wtt. All rights reserved.
//

import UIKit

class LPMainTabBarController: UITabBarController,LPCustomTabBarDelegate {
    func customTabBarButtonClick(myTabBar: LPCustomTabBar, selectedIndex: Int) {
        self.selectedIndex = selectedIndex
    }
    
    private var tabBarItemArray = [UITabBarItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        initMainTabBarController()
        addMyTabBar()
        setupTabBarAppearance()
    }
    
    private func addMyTabBar(){
        let myTabBar  = LPCustomTabBar()
        myTabBar.frame = self.tabBar.bounds
        self.tabBar.addSubview(myTabBar)//-----------------
        myTabBar.addTabBarButton(tabBarItemArray: tabBarItemArray as NSArray)//-----------------
        //设置代理
        myTabBar.delegate = self
    }
    
    
    
    private  func setupTabBarAppearance(){
        UITabBar.appearance().backgroundColor = .white
    }
    
    private func addChildViewController(childViewController : UIViewController,
                                                           title : String?,
                                                           image : UIImage?,
                                                   selectedImage : UIImage?){
        let tabBarItem = UITabBarItem(title:title, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        childViewController.tabBarItem = tabBarItem
        tabBarItemArray.append(tabBarItem)
        addChild(LPBaseNavigationController(rootViewController: childViewController))
    }
    
    private func initMainTabBarController(){
        ///首页
        let homeVC = LPHomeViewController()
        addChildViewController(childViewController: homeVC, title: "首页", image:nil, selectedImage:nil)

        ///视频
        let videoVC = LPVideoViewController()
        addChildViewController(childViewController: videoVC, title: "视频", image: nil, selectedImage:nil)
        
        ///发布
        let postNoteVC = LPPostNoteViewController()
        addChildViewController(childViewController: postNoteVC, title: "发布", image: nil, selectedImage:nil)
        
        ///消息
        let messageVC = LPMessageViewController()
        addChildViewController(childViewController: messageVC, title: "消息", image: nil, selectedImage:nil)
        
        ///我
        let mineVC = LPMineViewController()
       addChildViewController(childViewController: mineVC, title: "我", image: nil, selectedImage:nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeNativeTabBar()
    }
    
    private func removeNativeTabBar(){
        let aClass : AnyClass = NSClassFromString("UITabBarButton")!
        let views = self.tabBar.subviews ///---------
        print(views)
        for view in views {
            if view .isKind(of: aClass){
                view.removeFromSuperview()
            }
        }
    }
}

