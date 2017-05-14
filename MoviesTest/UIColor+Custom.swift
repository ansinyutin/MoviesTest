//
//  UIColor+Custom.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 28.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var moviesWarmGrey: UIColor {
        return UIColor(red: 163.0 / 255.0, green: 161.0 / 255.0, blue: 161.0 / 255.0, alpha: 1.0)
    }
    
    class var moviesSeparator: UIColor {
        return UIColor(white: 230.0 / 255.0, alpha: 1.0)
    }
    
    class var moviesGreyishBrown: UIColor {
        return UIColor(white: 74.0 / 255.0, alpha: 1.0)
    }
    
    class var moviesBlack: UIColor {
        return UIColor(white: 30.0 / 255.0, alpha: 1.0)
    }
    
    class var moviesWhite10: UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 0.1)
    }
    
    class var moviesWhite: UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 1.0)
    }
    
    class var moviesPinkishGrey: UIColor {
        return UIColor(white: 200.0 / 255.0, alpha: 1.0)
    }
    
    class var moviesBlack5: UIColor {
        return UIColor(white: 0.0, alpha: 0.05)
    }
    
    class var moviesBlackTwo: UIColor { 
        return UIColor(white: 36.0 / 255.0, alpha: 1.0)
    }
    
    class var moviesWhiteTwo: UIColor {
        return UIColor(white: 245.0 / 255.0, alpha: 1.0)
    }
    
    public convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = rgba.index(after: rgba.startIndex)
            let hex     = rgba.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                if hex.characters.count == 6 {
                    red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF) / 255.0
                } else if hex.characters.count == 8 {
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                } else {
                    print("invalid rgb string, length should be 7 or 9", terminator: "")
                }
            } else {
                print("scan hex error", terminator: "")
            }
        } else {
            print("invalid rgb string, missing '#' as prefix", terminator: "")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

