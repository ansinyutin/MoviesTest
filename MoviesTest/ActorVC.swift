//
//  ActorVC.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 29.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit
import pop

struct ActorVCAnimation {

    static let mainTextYMax:CGFloat = -108
    static let mainTextYMid:CGFloat = -128
    static let mainBlockYMin:CGFloat = -158

    static let bottomBlockYMid:CGFloat = -62
    static let bottomBlockYMin:CGFloat = -102

    static let moviesYMax:CGFloat = -32
    static let fansYMax:CGFloat = -2
    static let ratingYMax:CGFloat = 22
    
    static let detailTop:CGFloat = 30
    
    static let photoTop:CGFloat = 43
    
    static let vcShowCATiming = CAMediaTimingFunction(controlPoints: 0, 0, 0.38, 1)
    static let vcShowDuration:Double = 0.5
    static let vcHideDuration:Double = 0.2
}

enum VerticalScrollDirection {
    case up, down
}

class ActorVC: UIViewController {
    
    var photoImageView = UIImageView(frame: .zero)
    
    var titleLabel = UILabel(frame: .zero)
    var subtitleLabel = UILabel(frame: .zero)
    
    var moviesTitleLabel = UILabel(frame: .zero)
    var moviesSubtitleLabel = UILabel(frame: .zero)
    
    var fansTitleLabel = UILabel(frame: .zero)
    var fansSubtitleLabel = UILabel(frame: .zero)
    
    var rateTitleLabel = UILabel(frame: .zero)
    var rateSubtitleLabel = UILabel(frame: .zero)
    var rateStarImageView = UIImageView(frame: .zero)
    
    var detailVC = ActorDetailsVC()
    
    var constMainBlockBottom = NSLayoutConstraint()
    var constMoviesBottom = NSLayoutConstraint()
    var constFansBottom = NSLayoutConstraint()
    var constRateBottom = NSLayoutConstraint()
    var constDetailTop = NSLayoutConstraint()
    var constPhotoTop = NSLayoutConstraint()
    
    
    var previousPanPoint = CGPoint.zero
    
    var initDetailOffset:CGFloat = 0
    
    var lastVerticalPanDirection:VerticalScrollDirection = .up
    
    var panRecognizer:UIPanGestureRecognizer!
    
    var minDetailTopOffset:CGFloat = 30
    lazy var maxDetailTopOffset:CGFloat = {
        self.view.frame.height - self.minDetailTopOffset
    }()
    
    lazy var minOverallOffset:CGFloat = {
        return -self.detailVC.maxOffset + self.minDetailTopOffset
    }()
    
    var topOffset:CGFloat = 0
    
    var openProgress:CGFloat {
        
        let maxDiff = maxDetailTopOffset - minDetailTopOffset
        let diff = constDetailTop.constant - minDetailTopOffset
        
        return 1 - diff/maxDiff
    }

    var isDetailOpened:Bool {
        return self.constDetailTop.constant == maxDetailTopOffset
    }
    
    var detailHeight:CGFloat {
        return self.view.frame.size.height - minDetailTopOffset
    }
    
    var isDetailHandlingPan = false
    
    var panAnimationEndOffset:CGFloat = 0
    
    
    override func loadView() {
        super.loadView()
        
        setup()
        setupEvents()
        
        view.backgroundColor = .clear
        topOffset = maxDetailTopOffset
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateVCShow()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        animateVCHide()
    }
    
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
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK:- Scroll
    
    func getVerticalPanDelta() -> CGFloat {
        
        let panPoint:CGPoint = panRecognizer.translation(in: self.view)
        return panPoint.y - previousPanPoint.y
    }
    
    
    func refreshVerticalPanDirection() {
        
        let panPoint:CGPoint = panRecognizer.translation(in: self.view)
        
        lastVerticalPanDirection = panPoint.y > previousPanPoint.y  ? .up : .down
    }
    
    func onPan(recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began:        self.onPanBegin()
        case .changed:      self.onPanChange()
        case .ended:        self.onPanEnd()
        case .cancelled:    print("\nFailed\n")
        case .failed:       print("\nFailed\n")
        default: break
        }
    }
    
    func resetPreviousPoint() {
        previousPanPoint = CGPoint.zero
        panAnimationEndOffset = topOffset
    }
    
    func updatePreviousPoint() {
        let panPoint = panRecognizer.translation(in: self.view)
        previousPanPoint = panPoint
    }
    
    
    func topOffsetAnimationFrame(animation: POPAnimation?) {
        
        if topOffset < minOverallOffset {
            
            print("min exceeded: \(minOverallOffset)")
            
            self.pop_removeAllAnimations()
            let velocity = animation!.value(forKey: "velocity") as! CGFloat
            addEdgeBottomBounceAnimationToDetail(velocity: velocity, toY: minOverallOffset)
            
            return
            
        } else if topOffset > maxDetailTopOffset {
            
            self.pop_removeAllAnimations()
            let velocity = animation!.value(forKey: "velocity") as! CGFloat
            addEdgeBottomBounceAnimationToDetail(velocity: velocity, toY: maxDetailTopOffset)
            
        } else {
            
            updateAnimatedItems()
        }
        
        printStats()
        
    }

    
    func getMainOffset() -> CGFloat {
        
        var top = topOffset
        
        if top < minDetailTopOffset {
            
            top = minDetailTopOffset
        }
        
        return top
    }
    
    func getExtraOffset() -> CGFloat {
        
        var offset:CGFloat = 0;
        
        if topOffset <= minDetailTopOffset {
            offset = topOffset - minDetailTopOffset
        }
        
        if topOffset >= maxDetailTopOffset {
            offset = 0
        }
        
        return offset
    }
    
    func updateAnimatedItems() {
        
        
//        self.detailVC.view.layer.opacity = 0.3
        
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
            constDetailTop.constant = getMainOffset()
        }
    }
    
    let actorFadeFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: 1),
        KeyFrame(time: 0.45, value: 0.2)
    ]
    
    func updateActorFade() {
        let opacity = Animation.getValue(frames: actorFadeFrames, time: openProgress)
        photoImageView.layer.opacity = Float(opacity)
    }
    
    let actorZoomFrames:[KeyFrame] = [
        KeyFrame(time: -1, value: 1.15),
        KeyFrame(time: 0, value: 1),
        KeyFrame(time: 1, value: 0.9)
    ]
    
    func updateActorZoom() {
        let scale = Animation.getValue(frames: actorZoomFrames, time: openProgress)
        photoImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        photoImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    func updateTextPanOffset() {
        updateMainTextPanOffset()
        updateBottomTextPanOffset()
    }
    
    let mainTextPanFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: -128),
        KeyFrame(time: 0.7, value: -198)
    ]
    
    func updateMainTextPanOffset() {
        let offset = Animation.getValue(frames: mainTextPanFrames, time: openProgress)
        
        constMainBlockBottom.constant = offset
    }
    
    let bottomTextPanFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: -62),
        KeyFrame(time: 0.7, value: -132)
    ]

    func updateBottomTextPanOffset() {
        let offset = Animation.getValue(frames: bottomTextPanFrames, time: openProgress)
        
        constFansBottom.constant = offset
        constRateBottom.constant = offset
        constMoviesBottom.constant = offset
    }
    
    
    
    
    func updateDetailInternals() {
        
        let extraOffset = getExtraOffset()
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
    
    func printStats() {
        let panPoint = panRecognizer.translation(in: self.view)
        let extraOffset = getExtraOffset()
        
        print(
            "offset: \(String(format: "%000.1f", topOffset))\t" +
            "main: \(String(format: "%.1f", getMainOffset()))\t" +
            "extra: \(String(format: "%.1f", extraOffset))\t" +
            "overall: \(String(format: "%.1f", minOverallOffset))\t" +
            "open: \(String(format: "%.2f", openProgress))\t" +
            "Dopen: \(String(format: "%.2f", getDetailOpenProgress()))\t" +
            "top: \(constDetailTop.constant)\t")
//            "pan prev: \(previousPanPoint.y) \(panPoint.y)")
    }
    
    func scrollBy(delta: CGFloat) {
        
        topOffset += delta
        
        updateAnimatedItems()
        
        printStats()
        
        updatePreviousPoint()
    }

    func onPanBegin() {
        
        self.pop_removeAllAnimations()
        printStats()
        
        resetPreviousPoint()
    }
    
    
    
    func onPanChange() {
        
        let verticalDelta = getVerticalPanDelta()
        scrollBy(delta: verticalDelta)
    }
    
    func onPanEnd() {
        
        resetPreviousPoint()
        
        if topOffset > maxDetailTopOffset ||
            topOffset < minOverallOffset ||
            isEnoughPanVelocityToAnimate() {
            animateOffset()
        }
    }
    
    var minVelocityToAnimate:CGFloat = 200
    
    func isEnoughPanVelocityToAnimate() -> Bool {
        let velocity = panRecognizer.velocity(in: self.view).y
        return fabs(velocity) >= minVelocityToAnimate
    }
    
    func topOffsetAnimatablePropertyInitializer(prop: POPMutableAnimatableProperty?) {
        
        prop?.readBlock = { objc, values in
            values?[0] = (objc as! ActorVC).topOffset
        }
        
        prop?.writeBlock = { obj, values in
            (obj as! ActorVC).topOffset = values![0]
        }
    }
   
    func updateInitialDetailOffset() {
        
        self.initDetailOffset = self.constDetailTop.constant
        
        print("REFRESH INI: \(self.initDetailOffset) DELINIT: \(self.detailVC.initialOffset)")
    }
    
    //MARK:- Animation
    
    func animateOffset() {
        
        let velocity = panRecognizer.velocity(in: self.view)
        print("END velocity: \(velocity)")
        
        let anim = POPDecayAnimation()
        anim.property = POPAnimatableProperty.property(withName: "topOffset", initializer: topOffsetAnimatablePropertyInitializer) as! POPAnimatableProperty
        anim.velocity = velocity.y
        anim.animationDidApplyBlock = { [weak self] (animation:POPAnimation?) in
            self?.topOffsetAnimationFrame(animation:animation)
        }
        
        self.pop_add(anim, forKey: "test")
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
            self?.updateAnimatedItems()
        }
        bottomAnimation.completionBlock = { (anim:POPAnimation?, completion:Bool) in
            print("Y Bottom Bounce Animation END")
        }
        
        self.pop_add(bottomAnimation, forKey: "detailBottomBounceAnimation")
    }
    
    deinit {
        self.pop_removeAllAnimations()
    }
  
}
