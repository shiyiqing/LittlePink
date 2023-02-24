//
//  UIView + Extension.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/24.
//  Copyright © 2023 wtt. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    ///x
    public var view_x : CGFloat{
        get{
            return frame.origin.x
        }
        set{
            var tempFrame = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    ///y
    public var view_y : CGFloat{
        get{
            return frame.origin.y
        }
        set{
            var tempFrame = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    ///width
    public var view_width : CGFloat{
        get{
            return frame.size.width
        }
        set{
            var tempFrame = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    ///height
    public var view_height : CGFloat{
        get{
            return frame.size.height
        }
        set{
            var tempFrame = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    ///size
    public var view_size : CGSize{
        get{
            return frame.size
        }
        set{
            var tempFrame = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    ///centerX
    public var view_centerX : CGFloat{
        get{
            return center.x
        }
        set{
            var tempCenter = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    ///centerY
    public var view_centerY : CGFloat{
        get{
            return center.y
        }
        set{
            var tempCenter = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
}
