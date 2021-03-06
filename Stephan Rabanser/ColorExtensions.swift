//
//  ColorExtensions.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 17/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func outlineColor() -> UIColor {
        return UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0) // gray
    }
    
    class func personalColor() -> UIColor {
        return UIColor(red: 65.0/255.0, green: 170.0/255.0, blue: 55.0/255.0, alpha: 1.0) // green
    }
    
    class func educationColor() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 30.0/255.0, alpha: 1.0) // red
    }
    
    class func developmentColor() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 120.0/255.0, blue: 255.0/255.0, alpha: 1.0) // blue
    }
    
    class func colorForType(type: TimelineEntryType) -> UIColor {
        switch type {
            case .Personal:
                return personalColor()
            case .Education:
                return educationColor()
            case .Development:
                return developmentColor()
            default:
                return blackColor()
        }
    }
    
}
