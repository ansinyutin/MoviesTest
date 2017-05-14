//
//  UIFont+Custom.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 28.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

extension UIFont {
    
    public class func playfairItalicFontOfSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PlayfairDisplay-Italic", size: fontSize)!
    }
    
    public class func regularFontOfSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNova-Regular", size: fontSize)!
    }
    
    public class func extraboldFontOfSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNova-Extrabld", size: fontSize)!
    }
    
    public class func boldFontOfSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNova-Bold", size: fontSize)!
    }
    
    public class func semiboldFontOfSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNova-Semibold", size: fontSize)!
    }
    
    public class func lightFontOfSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNova-Light", size: fontSize)!
    }
    
    public class func thinFontOfSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNovaT-Thin", size: fontSize)!
    }
}
