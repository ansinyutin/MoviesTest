//
//  ActorVC+Animation.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 30.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit
import pop

extension ActorVC {
    
    //MARK:- ShowVC animation
    
    func animateVCShow() {
        
        let photoY = getShowVCConstAnimation(from: self.view.frame.size.height, to: ActorVCAnimation.photoTop)
        let detailY = getShowVCConstAnimation(from: self.view.frame.size.height, to: maxDetailTopOffset)
        
        let mainTextY = getShowVCConstAnimation(from: ActorVCAnimation.mainTextYMax, to: ActorVCAnimation.mainTextYMid)
        
        let moviesY = getShowVCConstAnimation(from: ActorVCAnimation.moviesYMax, to: ActorVCAnimation.bottomBlockYMid)
        let fansY = getShowVCConstAnimation(from: ActorVCAnimation.fansYMax, to: ActorVCAnimation.bottomBlockYMid)
        let ratingY = getShowVCConstAnimation(from: ActorVCAnimation.ratingYMax, to: ActorVCAnimation.bottomBlockYMid)
        
        let textAlpha = getShowVCAlphaAnimation(from: 0, to: 1)
        
        let bgColor = getVCAnimation(from: UIColor.clear, to: UIColor.black, property: kPOPViewBackgroundColor, duration: ActorVCAnimation.vcShowDuration)
        
        self.view.pop_add(bgColor, forKey: "actor.vcshow.photo.bgcolor")
        
        
        self.constPhotoTop.pop_add(photoY, forKey: "actor.vcshow.photo.y")
        self.constDetailTop.pop_add(detailY, forKey: "actor.vcshow.detail.y")
        
        self.constMainBlockBottom.pop_add(mainTextY, forKey: "actor.vcshow.maintext.y")
        
        self.constMoviesBottom.pop_add(moviesY, forKey: "actor.vcshow.movies.y")
        self.constFansBottom.pop_add(fansY, forKey: "actor.vcshow.fans.y")
        self.constRateBottom.pop_add(ratingY, forKey: "actor.vcshow.rating.y")
        
        
        self.titleLabel.pop_add(textAlpha, forKey: "actor.vcshow.maintext_title.alpha")
        self.subtitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.maintext_subtitle.alpha")
        
        self.moviesTitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.movies_title.alpha")
        self.moviesSubtitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.movies_subtitle.alpha")
        self.fansTitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.fans_title.alpha")
        self.fansSubtitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.fans_subtitle.alpha")
        self.rateTitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.rating_title.alpha")
        self.rateSubtitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.rating_subtitle.alpha")
    }
    
    func animateVCHide() {
        
        let photoY = getHideVCConstAnimation(from: ActorVCAnimation.photoTop, to: self.view.frame.size.height)
        let detailY = getHideVCConstAnimation(from: maxDetailTopOffset, to: self.view.frame.size.height)
        
        let mainTextY = getHideVCConstAnimation(from: ActorVCAnimation.mainTextYMid, to: ActorVCAnimation.mainTextYMax)
        
        let moviesY = getHideVCConstAnimation(from: ActorVCAnimation.bottomBlockYMid, to: ActorVCAnimation.moviesYMax)
        let fansY = getHideVCConstAnimation(from: ActorVCAnimation.bottomBlockYMid, to: ActorVCAnimation.fansYMax)
        let ratingY = getHideVCConstAnimation(from: ActorVCAnimation.bottomBlockYMid, to: ActorVCAnimation.ratingYMax)
        
        let textAlpha = getVCAnimation(from: 1, to: 0, property: kPOPViewAlpha, duration: 0.1)
        
        let bgColor = getVCAnimation(from: UIColor.black, to: UIColor.clear, property: kPOPViewBackgroundColor, duration: 0.1)
        
        self.view.pop_add(bgColor, forKey: "actor.vcshow.photo.bgcolor")
        
        self.constPhotoTop.pop_add(photoY, forKey: "actor.vcshow.photo.y")
        self.constDetailTop.pop_add(detailY, forKey: "actor.vcshow.detail.y")
        
        self.constMainBlockBottom.pop_add(mainTextY, forKey: "actor.vcshow.maintext.y")
        
        self.constMoviesBottom.pop_add(moviesY, forKey: "actor.vcshow.movies.y")
        self.constFansBottom.pop_add(fansY, forKey: "actor.vcshow.fans.y")
        self.constRateBottom.pop_add(ratingY, forKey: "actor.vcshow.rating.y")
        
        
        self.titleLabel.pop_add(textAlpha, forKey: "actor.vcshow.maintext_title.alpha")
        self.subtitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.maintext_subtitle.alpha")
        
        self.moviesTitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.movies_title.alpha")
        self.moviesSubtitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.movies_subtitle.alpha")
        self.fansTitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.fans_title.alpha")
        self.fansSubtitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.fans_subtitle.alpha")
        self.rateTitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.rating_title.alpha")
        self.rateStarImageView.pop_add(textAlpha, forKey: "actor.vcshow.rating_star.alpha")
        self.rateSubtitleLabel.pop_add(textAlpha, forKey: "actor.vcshow.rating_subtitle.alpha")
    }
    
    
    func getShowVCAlphaAnimation(from:CGFloat, to: CGFloat) -> POPBasicAnimation {
        return getShowVCAnimation(from: from, to: to, property: kPOPViewAlpha)
    }
    func getShowVCConstAnimation(from:CGFloat, to: CGFloat) -> POPBasicAnimation {
        return getShowVCAnimation(from: from, to: to, property: kPOPLayoutConstraintConstant)
    }
    
    func getShowVCAnimation(from:CGFloat, to: CGFloat, property:String) -> POPBasicAnimation {
        return getVCAnimation(from: from, to: to, property: property, duration: ActorVCAnimation.vcShowDuration)
    }
    
    func getHideVCAlphaAnimation(from:CGFloat, to: CGFloat) -> POPBasicAnimation {
        return getShowVCAnimation(from: from, to: to, property: kPOPViewAlpha)
    }
    func getHideVCConstAnimation(from:CGFloat, to: CGFloat) -> POPBasicAnimation {
        return getShowVCAnimation(from: from, to: to, property: kPOPLayoutConstraintConstant)
    }
    func getHideVCAnimation(from:CGFloat, to: CGFloat, property:String) -> POPBasicAnimation {
        return getVCAnimation(from: from, to: to, property: property, duration: ActorVCAnimation.vcHideDuration)
    }
    
    func getVCAnimation(from:Any, to: Any, property:String, duration:Double) -> POPBasicAnimation {
        
        let animation = POPBasicAnimation(propertyNamed: property)!
        animation.duration = duration
        animation.fromValue = from
        animation.toValue = to
        animation.timingFunction = ActorVCAnimation.vcShowCATiming
        
        return animation
    }
    
    
    //MARK:- Scroll animation
    
    func topOffsetAnimationFrame(animation: POPAnimation?) {
        
        if topOffset < minOverallOffset {
            
            self.pop_removeAllAnimations()
            let velocity = animation!.value(forKey: "velocity") as! CGFloat
            addEdgeBottomBounceAnimationToDetail(velocity: velocity, toY: minOverallOffset)
            
        } else if topOffset > maxDetailTopOffset {
            
            self.pop_removeAllAnimations()
            let velocity = animation!.value(forKey: "velocity") as! CGFloat
            addEdgeBottomBounceAnimationToDetail(velocity: velocity, toY: maxDetailTopOffset)
            
        } else {
            updatePanAnimationItems()
        }
        
        printStats()
    }
    
    func updatePanAnimationItems() {
        
        updateDetailTopOffset()
        updateActorFade()
        updateActorZoom()
        updateTextPanOffset()
        updateDetailInternals()
        
        printStats()
    }
    
    func updateDetailTopOffset() {
        
        if topOffset > minDetailTopOffset {
            constDetailTop.constant = topOffset
        } else {
            constDetailTop.constant = mainOffset
        }
    }
    
    func updateActorFade() {
        let opacity = Animation.getValue(frames: ActorVCFrames.actorFadeFrames, time: openProgress)
        photoImageView.layer.opacity = Float(opacity)
    }
    
    
    func updateActorZoom() {
        let scale = Animation.getValue(frames: ActorVCFrames.actorZoomFrames, time: openProgress)
        photoImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        photoImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    func updateTextPanOffset() {
        updateMainTextPanOffset()
        updateBottomTextPanOffset()
    }
    
    func updateMainTextPanOffset() {
        let offset = Animation.getValue(frames: ActorVCFrames.mainTextPanFrames, time: openProgress)
        constMainBlockBottom.constant = offset
    }
    
    func updateBottomTextPanOffset() {
        let offset = Animation.getValue(frames: ActorVCFrames.bottomTextPanFrames, time: openProgress)
        
        constFansBottom.constant = offset
        constRateBottom.constant = offset
        constMoviesBottom.constant = offset
    }
    
    func updateDetailInternals() {
        
        let detailOpenProgress = getDetailOpenProgress()
        self.detailVC.update(withTopOffset: -extraOffset, openProgress: detailOpenProgress)
    }
    
    func getDetailOpenProgress() -> CGFloat {
        
        let maxDiff:CGFloat = 110
        let maxOffset = maxDetailTopOffset
        let minOffset = maxDetailTopOffset - maxDiff
        
        let curOffset = self.constDetailTop.constant
        
        var progress:CGFloat = 0
        
        if curOffset > maxOffset {
            progress = 0.0
        } else if curOffset < minOffset {
            progress = 1.0
        } else {
            let diff = maxDetailTopOffset - self.constDetailTop.constant
            progress = diff/maxDiff
        }
        
        return progress
    }
    
    func topOffsetAnimatablePropertyInitializer(prop: POPMutableAnimatableProperty?) {
        
        prop?.readBlock = { objc, values in
            values?[0] = (objc as! ActorVC).topOffset
        }
        
        prop?.writeBlock = { obj, values in
            (obj as! ActorVC).topOffset = values![0]
        }
    }
    
    func animateOffset() {
        
        let velocity = panRecognizer.velocity(in: self.view)
        
        let anim = POPDecayAnimation()
        anim.property = POPAnimatableProperty.property(withName: "topOffset", initializer: topOffsetAnimatablePropertyInitializer) as! POPAnimatableProperty
        anim.velocity = velocity.y
        anim.animationDidApplyBlock = { [weak self] (animation:POPAnimation?) in
            self?.topOffsetAnimationFrame(animation:animation)
        }
        
        self.pop_add(anim, forKey: "topOffsetDecayAnimation")
    }
    
    func addEdgeBottomBounceAnimationToDetail(velocity: CGFloat, toY: CGFloat) {
        
        print("Y Bottom Bounce Animation START")
        
        let bottomAnimation = POPSpringAnimation()
        bottomAnimation.property = POPAnimatableProperty.property(withName: "topOffset", initializer: topOffsetAnimatablePropertyInitializer) as! POPAnimatableProperty
        bottomAnimation.velocity = velocity
        bottomAnimation.springBounciness = 0
        bottomAnimation.springSpeed = 3
        bottomAnimation.toValue = toY
        bottomAnimation.animationDidApplyBlock = { [weak self] (animation:POPAnimation?) in
            self?.updatePanAnimationItems()
        }
        
        self.pop_add(bottomAnimation, forKey: "topOffsetBounceAnimation")
    }

   
}
