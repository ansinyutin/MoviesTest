//
//  MovieCell.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 27.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    let imageView = UIImageView(frame: .zero)
    let titleLabel = UILabel(frame: .zero)
    let subtitleLabel = UILabel(frame: .zero)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setupWith(image: UIImage, title: String, subtitle: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.imageView.image = image
    }
    
    func setup() {
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.moviesBlack
        titleLabel.font = UIFont.semiboldFontOfSize(12)
        
        self.contentView.addSubview(titleLabel)
        
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = UIColor.moviesBlack.withAlphaComponent(0.3)
        subtitleLabel.font = UIFont.semiboldFontOfSize(12)
        
        self.contentView.addSubview(subtitleLabel)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
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
            "title":titleLabel,
            "subtitle":subtitleLabel
        ]
        
        //Horizontal layout
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[image]-0-|",
                                                                       options: [],
                                                                       metrics: metrics,
                                                                       views: views))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[title]-0-|",
                                                                       options: [],
                                                                       metrics: metrics,
                                                                       views: views))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[subtitle]-0-|",
                                                                       options: [],
                                                                       metrics: metrics,
                                                                       views: views))
        
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[image]-9-[title]-0-[subtitle]-(>=0)-|",
                                                                       options: [],
                                                                       metrics: metrics,
                                                                       views: views))        
    }
    
    
}
