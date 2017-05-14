//
//  DeleteMe2.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 31.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit


class UnavailableZoneAlertButton: UIButton {
    
    struct Measurements {
        
        static let titleTop: CGFloat = 0.0
        static let titleLeft: CGFloat = 60.0
        static let titleRight: CGFloat = 15.0
        
        static let imageLeft: CGFloat = 15.0
        static let imageTop: CGFloat = 15.0
        
        static let imageSize: CGFloat = 30.0
        
        static let titleFontSize: CGFloat = 18.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        self.imageView?.contentMode = .center
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.backgroundColor = .black
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        
        return CGRect(x: Measurements.titleLeft,
                      y: Measurements.titleTop,
                      width: contentRect.width - Measurements.titleLeft - Measurements.titleRight,
                      height: contentRect.size.height)
    }
    
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        return CGRect(x: Measurements.imageLeft,
                      y: Measurements.imageTop,
                      width: Measurements.imageSize,
                      height: Measurements.imageSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class UnavailableZoneAlertView: UIView {
    
    var alertView: UIView!
    
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var pickUpIconView: UIImageView!
    
    var separatorView: UIView!
    
    var carIconView: UIImageView!
    var descriptionLabel: UILabel!
    var facebookButton:UnavailableZoneAlertButton!
    var twitterButton:UnavailableZoneAlertButton!
    
    var pickupLocation:String?
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        setupShadow()
    }
    
    func setupShadow() {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
    }
    
    init(pickupLocation: String?) {
        
        super.init(frame: UIScreen.main.bounds)
        
        alertView = UIView(frame: .zero)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.backgroundColor = .white
        self.addSubview(alertView)
        
        
        separatorView = UIView(frame: .zero)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
//        separatorView.backgroundColor = UIColor.fastenLightGraySeparator
        separatorView.backgroundColor = .red
        
        alertView.addSubview(separatorView)
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        
        titleLabel.text = "asdf asdf asdf asdf asd"
        titleLabel.font = UIFont.boldFontOfSize(19)
//        titleLabel.text = pickupLocation?.address ?? ""
//        titleLabel.font = UIFont.fastenBoldFontOfSize(19)
        
        alertView.addSubview(titleLabel)
        
        subtitleLabel = UILabel(frame: .zero)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.text = "asdf asdf asdf asdf asd"
        subtitleLabel.textColor = UIColor.gray
        subtitleLabel.font = UIFont.regularFontOfSize(9)
//        subtitleLabel.text = pickupLocation?.subtitle.uppercased() ?? ""
//        subtitleLabel.textColor = UIColor.fastenRinGreyishColor
//        subtitleLabel.font = UIFont.fastenRegularFontOfSize(9)
        
        alertView.addSubview(subtitleLabel)
        
        pickUpIconView = UIImageView(frame: .zero)
        pickUpIconView.translatesAutoresizingMaskIntoConstraints = false
        pickUpIconView.image = UIImage(named: "pickupIcon")
        pickUpIconView.contentMode = .scaleAspectFit
        alertView.addSubview(pickUpIconView)
        pickUpIconView.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        
        carIconView = UIImageView(frame: .zero)
        carIconView.translatesAutoresizingMaskIntoConstraints = false
        carIconView.image = UIImage(named: "carIcon")
        alertView.addSubview(carIconView)
        
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
//        descriptionLabel.font = UIFont.fastenRegularFontOfSize(14)
        descriptionLabel.font = UIFont.regularFontOfSize(14)
        
        descriptionLabel.text = "A service that only takes 99¢ per ride (not 25%) so drivers are taken care of is not yet in your area. Help us give more drivers a fair option. Spread the word."
        alertView.addSubview(descriptionLabel)
        
        facebookButton = UnavailableZoneAlertButton(frame: .zero)
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        
        facebookButton.backgroundColor = UIColor.blue
        facebookButton.titleLabel?.font = UIFont.regularFontOfSize(12)
//        facebookButton.backgroundColor = UIColor.fastenFacebookBlueColor
//        facebookButton.titleLabel?.font = UIFont.fastenRegularFontOfSize(12)
        
        facebookButton.setTitleColor(.white, for: .normal)
        facebookButton.setTitle("Call us out on Facebook", for: .normal)
        facebookButton.setImage(UIImage(named: "unavailable_zone_facebook"), for: .normal)
        alertView.addSubview(facebookButton)
        
        twitterButton = UnavailableZoneAlertButton(frame: .zero)
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        
//        twitterButton.backgroundColor = UIColor.fastenTwitterBlueColor
//        twitterButton.titleLabel?.font = UIFont.fastenRegularFontOfSize(12)
        twitterButton.backgroundColor = UIColor.green
        twitterButton.titleLabel?.font = UIFont.regularFontOfSize(12)
        
        twitterButton.setTitleColor(.white, for: .normal)
        twitterButton.setTitle("Call us out on Twitter", for: .normal)
        twitterButton.setImage(UIImage(named: "unavailable_zone_twitter"), for: .normal)
        alertView.addSubview(twitterButton)
        
        
        addCustomConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomConstraints() {
        let metrics: [String:Any] = [
            
            "alertMargin": 14,
            
            "pickUpLeft": 15,
            "pickUpRight": 15,
            
            "titleTop": 20,
            "titleRight": 15,
            "subtitleRight": 20,
            "subtitleBottom": 13,
            
            "carLeft": 12,
            
            "descTop": 25,
            "descLeft": 20,
            "descRight": 15,
            "descBottom": 25,
            "bbarButtonHeight": 60
        ]
        
        let views: [String:UIView] = [
            
            "alertView": alertView,
            
            "titleLabel": titleLabel,
            "subtitleLabel": subtitleLabel,
            "pickUpIconView": pickUpIconView,
            "separatorView": separatorView,
            "carIconView": carIconView,
            "descriptionLabel": descriptionLabel,
            "facebookButton": facebookButton,
            "twitterButton": twitterButton,
            ]
        
        //Horizontal layout
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-alertMargin-[alertView]-alertMargin-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-pickUpLeft-[pickUpIconView]-pickUpRight-[titleLabel]-titleRight-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.addConstraint(NSLayoutConstraint(item: subtitleLabel,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: titleLabel,
                                              attribute: .leading,
                                              multiplier: 1.0,
                                              constant: 0))
        self.addConstraint(NSLayoutConstraint(item: subtitleLabel,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: titleLabel,
                                              attribute: .trailing,
                                              multiplier: 1.0,
                                              constant: 0))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-carLeft-[carIconView]-descLeft-[descriptionLabel]-descRight-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[facebookButton]-0-[twitterButton]|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.addConstraint(NSLayoutConstraint(item: facebookButton,
                                              attribute: .width,
                                              relatedBy: .equal,
                                              toItem: twitterButton,
                                              attribute: .width,
                                              multiplier: 1.0,
                                              constant: 0))
        
        
        //Vertical layout
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[alertView]-alertMargin-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        
        self.addConstraint(NSLayoutConstraint(item: pickUpIconView,
                                              attribute: .centerY,
                                              relatedBy: .equal,
                                              toItem: titleLabel,
                                              attribute: .centerY,
                                              multiplier: 1.0,
                                              constant: 0))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-titleTop-[titleLabel]-0-[subtitleLabel]-subtitleBottom-[separatorView(1)]-descTop-[descriptionLabel]-descBottom-[facebookButton(bbarButtonHeight)]|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[twitterButton(bbarButtonHeight)]|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        self.addConstraint(NSLayoutConstraint(item: carIconView,
                                              attribute: .centerY,
                                              relatedBy: .equal,
                                              toItem: descriptionLabel,
                                              attribute: .centerY,
                                              multiplier: 1.0,
                                              constant: 0))
    }
    
    //MARK: - Touches
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let touchPoint = touches.first?.location(in: self)
        
        if touchPoint != nil {
            if alertView.frame.contains(touchPoint!) == false {
                hide()
            }
        }
    }
    
    //MARK: - Public
    
    func onTapFacebookButton() {
        
    }
    
    func onTapTwitterButton() {
        
    }
    
    func show() {
        
        //        hideControllerVO()
        //        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification,textLabel); // Voice over
        
        let duration: CFTimeInterval = 0.2
        
        //        self.alpha = 0
        //        alertView.layer.opacity = 0
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        
        
        
        
        //        UIView.animate(withDuration: duration) {
        //            self.alpha = 1
        //        }
        
        var animations: [CABasicAnimation] = []
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0
        opacityAnimation.toValue = 1
        opacityAnimation.duration = duration
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        animations.append(opacityAnimation)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.3
        scaleAnimation.toValue = 1.0
        scaleAnimation.duration = duration
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        animations.append(scaleAnimation)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = animations
        animationGroup.duration = duration
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = true
        
        alertView.layer.add(animationGroup, forKey: "alertShowAnimation")
        
        alertView.layer.opacity = 1
    }
    
    func hide() {
        //        showControllerVO()
        let duration: CFTimeInterval = 0.2
        
        //        UIView.animate(withDuration: 0.15) {
        //            self.alpha = 0
        //        }
        
        var animations: [CABasicAnimation] = []
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = duration
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        animations.append(opacityAnimation)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 0.8
        scaleAnimation.duration = duration
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        animations.append(scaleAnimation)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = animations
        animationGroup.duration = duration
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = true
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.removeFromSuperview()
        }
        alertView.layer.add(animationGroup, forKey: "alertHideAnimation")
        CATransaction.commit()
        
        alertView.layer.opacity = 0
    }
    
}
