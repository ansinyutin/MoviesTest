//
//  UScreen+Custom.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 02.02.18.
//  Copyright © 2018 Синютин Андрей. All rights reserved.
//

import UIKit

extension UIScreen {
    
    public class func isiPhone4or5() -> Bool {
        return UIScreen.main.bounds.size.height <= 568
    }
    
    public class func isiPhone6() -> Bool {
        return UIScreen.main.bounds.size.height == 667
    }
    
    public class func isiPhone6Plus() -> Bool {
        return UIScreen.main.bounds.size.height == 736
    }
}
