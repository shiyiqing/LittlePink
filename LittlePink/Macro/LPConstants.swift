//
//  LPConstants.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/17.
//  Copyright © 2023 wtt. All rights reserved.
//

import Foundation
import UIKit

//状态栏高度
func STATUS_BAR_HEIGHT() -> CGFloat{
    let scene = UIApplication.shared.connectedScenes.first
    guard let windowScene = scene as? UIWindowScene else {return 0}
    guard let statusBarManager = windowScene.statusBarManager else {return 0}
    return statusBarManager.statusBarFrame.height
}

//底部安全区高度
func BOTTOM_HEIGHT() -> CGFloat{
    let scene = UIApplication.shared.connectedScenes.first
    guard let windowScene = scene as? UIWindowScene else { return 0 }
    guard let window = windowScene.windows.first else { return 0 }
    return window.safeAreaInsets.bottom
}

let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.size.height


let STATUSBAR_HEIGHT : CGFloat = STATUS_BAR_HEIGHT()
let NAVBAR_HEIGHT : CGFloat = 44.0
let NAVBAR_FULL_HEIGHT : CGFloat = STATUSBAR_HEIGHT + 44.0
let TABBAR_HEIGHT : CGFloat = 49.0
let TABBAR_FULL_HEIGHT : CGFloat = BOTTOM_HEIGHT() + 49.0





