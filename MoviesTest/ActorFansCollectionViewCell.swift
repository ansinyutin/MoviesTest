//
//  ActorFansCollectionViewCell.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 30.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

class ActorFansCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView(frame: .zero)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setupWith(image: UIImage) {
        self.imageView.image = image
    }
    
    func setup() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = self.bounds.size.width / 2
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.drawsAsynchronously = true
        imageView.layer.shouldRasterize = true
        
        if let win = UIApplication.shared.keyWindow {
            imageView.layer.rasterizationScale = win.screen.scale
        }

        
        
        self.contentView.addSubview(imageView)
        
        addCustomConstraints()
    }
    
    func addCustomConstraints() {
        
        let metrics: [String:Any] = [:]
        
        let views: [String:UIView] = [
            "mainView":self.contentView,
            "image":imageView,
            ]
        
        //Horizontal layout
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[image]-0-|",
                                                                       options: [],
                                                                       metrics: metrics,
                                                                       views: views))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[image]-(>=0)-|",
                                                                       options: [],
                                                                       metrics: metrics,
                                                                       views: views))
    }
}
