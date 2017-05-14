//
//  ActorCell.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 28.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

class ActorCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    let titleLabel = UILabel(frame: .zero)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupWith(image: UIImage, title: String) {
        self.titleLabel.text = title
        self.imageView.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    func setup() {
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.moviesBlack
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.semiboldFontOfSize(12)
        
        
        contentView.addSubview(titleLabel)
        
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = self.frame.size.width / 2
        imageView.layer.masksToBounds = true
        imageView.layer.drawsAsynchronously = true
        imageView.layer.shouldRasterize = true
        
        if let win = UIApplication.shared.keyWindow {
            imageView.layer.rasterizationScale = win.screen.scale
        }
        
        
        
        contentView.addSubview(imageView)
        self.backgroundColor = UIColor.clear
        
        addCustomConstraints()
        
    }
    
    func addCustomConstraints() {
        
        let metrics: [String:Any] = [:]
        
        let views: [String:UIView] = [
            "mainView":self.contentView,
            "image":imageView,
            "title":titleLabel
        ]
        
        //Horizontal layout
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[image]-0-|",
                                                                       options: [],
                                                                       metrics: metrics,
                                                                       views: views))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-20-[title]-20-|",
                                                                       options: [],
                                                                       metrics: metrics,
                                                                       views: views))
        
        //Vertical layout
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[image]-15-[title]-(>=0)-|",
                                                                       options: [],
                                                                       metrics: metrics,
                                                                       views: views))
        
    }
    
    
}
