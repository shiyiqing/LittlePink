//
//  LPCommonColorMacro.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/15.
//  Copyright © 2023 wtt. All rights reserved.
//

import Foundation
import UIKit

///RGB颜色转换16进制 -> 10进制
func HEX_COLOR(hexValue : UInt32) -> UIColor { return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((hexValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(hexValue & 0xFF))/255.0, alpha: 1.0)}
func HEX_COLORA(hexValue : UInt32 ,A : CGFloat) -> UIColor {return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((hexValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(hexValue & 0xFF))/255.0, alpha:A) }

func RGB_COLOR(R : UInt32,G : UInt32,B : UInt32) -> UIColor { return UIColor(r: R, g: G, b: B) }
func RGBA_COLOR(R : UInt32,G : UInt32,B : UInt32,A : CGFloat) -> UIColor { return UIColor(r: R, g: G, b: B,a: A)}

///字体颜色
let LPNormalTextColor = HEX_COLOR(hexValue: 0x352d2b) ///<默认正常的黑色
let LPGrayTextColor = HEX_COLOR(hexValue: 0x5d5755) ///<稍微浅一点的灰色
let LPLightGrayTextColor = HEX_COLOR(hexValue: 0xaeabaa) ///<最浅的浅灰色
let LPBrownColor = HEX_COLOR(hexValue: 0xcdb290) ///<棕色字体或背景
let LPRedColor = HEX_COLOR(hexValue: 0xff4f38) ///<默认红色字体
let LPLineColor = HEX_COLOR(hexValue: 0xf3f3f3) ///<分割线颜色
let LPYellowColor = HEX_COLOR(hexValue: 0xC3AA8A) ///<淡黄色颜色

///品牌色 主题色?
let color_gb_brand = HEX_COLOR(hexValue: 0xD9A665) ///<按钮、链接等
let color_gb_brand_a6 = HEX_COLORA(hexValue: 0xD9A665, A: 0.6) ///<按钮、链接等
let color_gb_brand_a4 = HEX_COLORA(hexValue: 0xD9A665, A: 0.4) ///<按钮、链接等
let color_gb_brand_a2 = HEX_COLORA(hexValue: 0xD9A665, A: 0.2) ///<按钮、链接等
let color_gb_brand_a1 = HEX_COLORA(hexValue: 0xD9A665, A: 0.1) ///<按钮、链接等

///辅助色系
let color_gb_red =  HEX_COLOR(hexValue: 0xFF4F38) ///<报错
let color_gb_red_a6 =  HEX_COLORA(hexValue: 0xFF4F38, A: 0.6) ///<等
let color_gb_red_a4 =  HEX_COLORA(hexValue: 0xFF4F38, A: 0.4) ///<等
let color_gb_red_a2 =  HEX_COLORA(hexValue: 0xFF4F38, A: 0.2) ///<等
let color_gb_red_a1 =  HEX_COLORA(hexValue: 0xFF4F38, A: 0.1) ///<等

///文字
let color_text_black = HEX_COLOR(hexValue: 0x352D2B) ///<标题及正文
let color_text_secondary_gray = HEX_COLOR(hexValue: 0x5D5755) ///<次要信息
let color_text_tertiary_gray = HEX_COLOR(hexValue: 0x868180) ///<次要信息
let color_text_light_gray = HEX_COLOR(hexValue: 0xAEABAA) ///<次要信息
let color_text_disable_gray = HEX_COLOR(hexValue: 0xD7D5D5) ///<置灰
let color_text_white = HEX_COLOR(hexValue: 0xFFFFFF) ///<信息

///分割线及背景
let color_devider_gray = HEX_COLOR(hexValue: 0xF3F3F3) ///<分割线
let color_devider_bg_gray = HEX_COLOR(hexValue: 0xF7F7F6) ///<背景色
let color_devider_bg_white = HEX_COLOR(hexValue: 0xFFFFFF) ///<背景色

///蒙层
let color_toast_a6 =  HEX_COLORA(hexValue: 0x000000, A: 0.6) ///<toast
let color_mask_a4 =  HEX_COLORA(hexValue: 0x000000, A: 0.4) ///<蒙层
