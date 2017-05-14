//
//  TextField.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 28.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

class TextField: UITextField {
    var insets = UIEdgeInsets()
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var croppedRect = bounds
        
        croppedRect.origin.x    += self.insets.left
        croppedRect.origin.y    += self.insets.top
        croppedRect.size.width  -= self.insets.left + self.insets.right
        croppedRect.size.height -= self.insets.top + self.insets.bottom
        
        return croppedRect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
}
