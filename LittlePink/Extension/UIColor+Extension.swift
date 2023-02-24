//
//  UIColor+Extension.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/15.
//  Copyright © 2023 wtt. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    ///r,g,b
    convenience init(r : UInt32 ,g : UInt32,b : UInt32 ,a : CGFloat = 1.0) {
        self.init(
                    red: CGFloat(r) / 255.0,
                    green: CGFloat(g) / 255.0,
                    blue: CGFloat(b) / 255.0,
                    alpha: a)
    }
    ///rgb
    convenience init(rgb : UInt ,a : CGFloat = 1.0) {
        self.init(
                    red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                    green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0 ,
                    blue: CGFloat((rgb & 0x0000FF)) / 255.0 ,
                    alpha: a)
    }
    ///hex
    convenience init(hexString : String ,a : CGFloat = 1.0) {
        var hex = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hex.hasPrefix("#"){
            hex.removeFirst()
        }
        
        if hex.count != 6 {
            //黑色
            self.init(
                        red: CGFloat(0) / 255.0,
                        green: CGFloat(0) / 255.0,
                        blue: CGFloat(0) / 255.0,
                        alpha: a)
            return
        }
        
        var rgbValue : UInt64 = 0

        Scanner(string: hex).scanHexInt64(&rgbValue)
        self.init(
                    red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                    green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0 ,
                    blue: CGFloat((rgbValue & 0x0000FF)) / 255.0 ,
                    alpha: a)
    }
    
    ///random
    static var randomColor: UIColor {
        get {
            return UIColor(red: CGFloat(arc4random() % 256) / 255.0, green: CGFloat(arc4random() % 256) / 255.0, blue: CGFloat(arc4random() % 256) / 255.0, alpha: 1.0)
        }
    }
}
    
