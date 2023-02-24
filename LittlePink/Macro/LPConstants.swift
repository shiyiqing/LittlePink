//
//  LPConstants.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/17.
//  Copyright © 2023 wtt. All rights reserved.
//

import Foundation
import UIKit


//MARK: SCREEN
let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.size.height

//MARK: NAV
//状态栏高度
var STATUSBAR_HEIGHT : CGFloat{
    get{
        let scene = UIApplication.shared.connectedScenes.first
        guard let windowScene = scene as? UIWindowScene else {return 0}
        guard let statusBarManager = windowScene.statusBarManager else {return 0}
        return statusBarManager.statusBarFrame.height
    }
}
let NAV_BAR_HEIGHT : CGFloat = STATUSBAR_HEIGHT + 44



