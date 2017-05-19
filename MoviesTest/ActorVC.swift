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
    static let mainBlockYFrom:CGFloat = -128
    static let mainBlockYTo:CGFloat = -128
    
    static let bottomBlockYFrom:CGFloat = -62
    static let bottomBlockYTo:CGFloat = -62
    
    static let detailYFrom:CGFloat = -30
    static let detailYTo:CGFloat = -30
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

    var isDetailOpened:Bool {
        return self.constDetailTop.constant == maxDetailTopOffset
    }
    
    var detailHeight:CGFloat {
        return self.view.frame.size.height - minDetailTopOffset
    }
    
    var isDetailHandlingPan = false
    
    var panAnimationEndOffset:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        setup()
        setupEvents()
        
        topOffset = maxDetailTopOffset
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
        
        if topOffset > minDetailTopOffset {
            constDetailTop.constant = topOffset
        } else {
            constDetailTop.constant = getMainOffset()
        }
        updateDetailInternals()
        
        printStats()
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
            "open: \(String(format: "%.1f", getDetailOpenProgress()))\t" +
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
