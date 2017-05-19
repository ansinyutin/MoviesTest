//
//  ActorVC+Setup.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 15.05.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

extension ActorVC {
    
    func setup() {
        
        self.view.backgroundColor = .black
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.layer.cornerRadius = 10
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.drawsAsynchronously = true
        photoImageView.layer.shouldRasterize = true
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        if let win = UIApplication.shared.keyWindow {
            photoImageView.layer.rasterizationScale = win.screen.scale
        }
        
        self.view.addSubview(photoImageView)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = UIFont.extraboldFontOfSize(27)
        self.view.addSubview(titleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        subtitleLabel.font = UIFont.semiboldFontOfSize(10)
        self.view.addSubview(subtitleLabel)
        
        
        moviesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        moviesTitleLabel.textColor = .white
        moviesTitleLabel.font = UIFont.boldFontOfSize(12)
        self.view.addSubview(moviesTitleLabel)
        
        moviesSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        moviesSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.3)
        moviesSubtitleLabel.font = UIFont.semiboldFontOfSize(12)
        moviesSubtitleLabel.numberOfLines = 0
        self.view.addSubview(moviesSubtitleLabel)
        
        
        fansTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        fansTitleLabel.textColor = .white
        fansTitleLabel.font = UIFont.boldFontOfSize(12)
        self.view.addSubview(fansTitleLabel)
        
        fansSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        fansSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.3)
        fansSubtitleLabel.font = UIFont.semiboldFontOfSize(12)
        fansSubtitleLabel.numberOfLines = 0
        self.view.addSubview(fansSubtitleLabel)
        
        
        rateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        rateTitleLabel.textColor = .white
        rateTitleLabel.font = UIFont.boldFontOfSize(12)
        self.view.addSubview(rateTitleLabel)
        
        rateSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        rateSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.3)
        rateSubtitleLabel.font = UIFont.semiboldFontOfSize(12)
        rateSubtitleLabel.numberOfLines = 0
        self.view.addSubview(rateSubtitleLabel)
        
        rateStarImageView.translatesAutoresizingMaskIntoConstraints = false
        rateStarImageView.image = UIImage(named: "star")
        rateStarImageView.contentMode = .scaleAspectFit
        self.view.addSubview(rateStarImageView)
        
        
        
//        detailVC.panDelegate = self
        detailVC.view.translatesAutoresizingMaskIntoConstraints = false
        detailVC.view.backgroundColor = .white
        self.addChildViewController(detailVC)
        self.view.addSubview(detailVC.view)
        detailVC.didMove(toParentViewController: self)
        
        detailVC.list.isScrollEnabled = false
        
        addCustomConstraints()
    }
    
    func setupWithActor(name: String, professions: [String], moviesWatched: Int, allMovies: Int, fans: Int, rate: Float) {
        
        photoImageView.image = UIImage(named: "actor_big")
        
        
        titleLabel.text = name
        titleLabel.addTextSpacing(-0.3)
        
        subtitleLabel.text = professions.joined(separator: ", ").uppercased()
        subtitleLabel.addTextSpacing(1)
        
        let moviesTitleStr = NSMutableAttributedString(string: "\(moviesWatched)")
        let allMoviesStr     = NSAttributedString(string: "\(allMovies)")
        
        let ofAttribute = [ NSFontAttributeName: UIFont.playfairItalicFontOfSize(12)]
        let ofString = NSAttributedString(string: " of ", attributes: ofAttribute)
        
        moviesTitleStr.append(ofString)
        moviesTitleStr.append(allMoviesStr)
        
        moviesTitleLabel.attributedText = moviesTitleStr
        moviesSubtitleLabel.text = "Movies watched"
        
        fansTitleLabel.text = "\(fans)"
        fansSubtitleLabel.text = "Fans on Must"
        
        rateTitleLabel.text = "\(rate)"
        rateSubtitleLabel.text = "Average movies rating"
    }
    
    //MARK:- Events
    
    func setupEvents() {
        
        self.panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan))
//        self.panRecognizer = ImmediatePanGestureRecognizer(target: self, action: #selector(onPan))
        self.view.addGestureRecognizer(self.panRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func onTap(recognizer:UITapGestureRecognizer) {
        self.animateVCShow()
    }
}
