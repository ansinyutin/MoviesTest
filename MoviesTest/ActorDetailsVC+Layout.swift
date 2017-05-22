//
//  ActorDetailsVC+Layout.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 19.05.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

extension ActorDetailsVC {
    
    func addCustomConstraints() {
        
        let metrics:[String:Any] = [
            "headerHeight": Metrics.headerHeight
        ]
        
        let views: [String:UIView] = [
            "list":list,
            "header": header
        ]
        
        //Horizontal layout
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[header]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[list]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        //Vertical layout
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[header]-0-[list]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        self.constHeaderHeight = NSLayoutConstraint(item: header,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: Metrics.headerHeight)
        
        view.addConstraint(self.constHeaderHeight)
    }
}
