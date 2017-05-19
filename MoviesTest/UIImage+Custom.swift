//
//  UIImage+Custom.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 16.05.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

extension UIImage{
    
    class func roundedRectImageFromImage(image:UIImage,imageSize:CGSize,cornerRadius:CGFloat)->UIImage {
        
        UIGraphicsBeginImageContextWithOptions(imageSize,false,0.0)
        
        let bounds = CGRect(origin: CGPoint.zero, size: imageSize)
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).addClip()
        image.draw(in: bounds)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return finalImage!
    }
    
}
