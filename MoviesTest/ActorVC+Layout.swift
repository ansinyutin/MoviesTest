//
//  ActorVC+Layout.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 15.05.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

extension ActorVC {
        
    func addCustomConstraints() {
        
        let metrics:[String:Any] = [
            "textPadding": 30,
            "moviesWidth": 260,
            "fansWidth": 260,
            "rateWidth": 260,
            "detailHeight": self.view.frame.size.height - 20,
            ]
        
        let views: [String:UIView] = [
            "title":titleLabel,
            "subtitle":subtitleLabel,
            
            "moviesTitle":moviesTitleLabel,
            "moviesSubtitle":moviesSubtitleLabel,
            
            "fansTitle":fansTitleLabel,
            "fansSubtitle":fansSubtitleLabel,
            
            "rateTitle":rateTitleLabel,
            "rateSubtitle":rateSubtitleLabel,
            "rateStar":rateStarImageView,
            
            
            "photo":photoImageView,
            
            "detail":detailVC.view
        ]
        
        //Horizontal layout
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[photo]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[detail]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(textPadding)-[title]-(textPadding)-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(textPadding)-[subtitle]-(textPadding)-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(textPadding)-[moviesTitle(80)]-8-[fansTitle(60)]-13-[rateTitle]-2-[rateStar]-(>=0)-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: moviesSubtitleLabel,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: moviesTitleLabel,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: moviesSubtitleLabel,
                                                   attribute: .trailing,
                                                   relatedBy: .equal,
                                                   toItem: moviesTitleLabel,
                                                   attribute: .trailing,
                                                   multiplier: 1.0,
                                                   constant: 0))
        
        
        self.view.addConstraint(NSLayoutConstraint(item: fansSubtitleLabel,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: fansTitleLabel,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: fansSubtitleLabel,
                                                   attribute: .trailing,
                                                   relatedBy: .equal,
                                                   toItem: fansTitleLabel,
                                                   attribute: .trailing,
                                                   multiplier: 1.0,
                                                   constant: 0))
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[rateSubtitle(80)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: rateSubtitleLabel,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: rateTitleLabel,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 0))
        
        
        
        //Vertical layout
        
        
        //TODO delete
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[detail(detailHeight)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-43-[photo]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[title]-0-[subtitle]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[moviesTitle]-0-[moviesSubtitle]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[fansTitle]-0-[fansSubtitle]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[rateTitle]-0-[rateSubtitle]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: rateStarImageView,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: rateTitleLabel,
                                                   attribute: .centerY,
                                                   multiplier: 1.0,
                                                   constant: 0))
        
        self.constMainBlockBottom = NSLayoutConstraint(item: subtitleLabel,
                                                       attribute: .bottom,
                                                       relatedBy: .equal,
                                                       toItem: subtitleLabel.superview,
                                                       attribute: .bottom,
                                                       multiplier: 1.0,
                                                       constant: ActorVCAnimation.mainBlockYFrom)
        self.view.addConstraint(self.constMainBlockBottom)
        
        
        
        self.constMoviesBottom = NSLayoutConstraint(item: moviesSubtitleLabel,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: moviesSubtitleLabel.superview,
                                                    attribute: .bottom,
                                                    multiplier: 1.0,
                                                    constant: ActorVCAnimation.bottomBlockYFrom)
        self.view.addConstraint(self.constMoviesBottom)
        
        
        self.constFansBottom = NSLayoutConstraint(item: fansSubtitleLabel,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: fansSubtitleLabel.superview,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: ActorVCAnimation.bottomBlockYFrom)
        self.view.addConstraint(self.constFansBottom)
        
        
        self.constRateBottom = NSLayoutConstraint(item: rateSubtitleLabel,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: rateSubtitleLabel.superview,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: ActorVCAnimation.bottomBlockYFrom)
        self.view.addConstraint(self.constRateBottom)
        
        
        self.constDetailBottom = NSLayoutConstraint(item: detailVC.view,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: self.view,
                                                    attribute: .bottom,
                                                    multiplier: 1.0,
                                                    constant: ActorVCAnimation.detailYFrom)
        //                                                    constant: -(view.frame.size.height + ActorVCAnimation.detailYFrom))
        self.view.addConstraint(self.constDetailBottom)
        
        
    }

    
}
