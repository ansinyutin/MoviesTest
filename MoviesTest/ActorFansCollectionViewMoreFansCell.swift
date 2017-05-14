//
//  ActorFansCollectionViewMoreFansCell.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 30.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

class ActorFansCollectionViewMoreFansCell: UICollectionViewCell {
    
    let titleLabel = UILabel(frame: .zero)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setupWith(moreFansCount: Int) {
        self.titleLabel.text = "+\(moreFansCount)"
    }
    
    func setup() {
        
        
        self.contentView.layer.cornerRadius = self.bounds.size.width / 2
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.07)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldFontOfSize(10)
        titleLabel.textColor = UIColor.black.withAlphaComponent(0.3)
        self.contentView.addSubview(titleLabel)
        
        addCustomConstraints()
    }
    
    func addCustomConstraints() {
        
//        let metrics: [String:Any] = [:]
//        
//        let views: [String:UIView] = [
//            "mainView":self.contentView,
//            "title":titleLabel,
//        ]
        
        //Horizontal layout
        
        self.contentView.addConstraint(NSLayoutConstraint(item: titleLabel,
                                                           attribute: .centerX,
                                                           relatedBy: .equal,
                                                           toItem: self.contentView,
                                                           attribute: .centerX,
                                                           multiplier: 1.0,
                                                           constant: 0))
        
        //Vertical layout
        self.contentView.addConstraint(NSLayoutConstraint(item: titleLabel,
                                                           attribute: .centerY,
                                                           relatedBy: .equal,
                                                           toItem: self.contentView,
                                                           attribute: .centerY,
                                                           multiplier: 1.0,
                                                           constant: 0))
    }
}
