//
//  ActorVC+Scroll.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 15.05.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

extension ActorVC {
    
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
    
    func onPanBegin() {
        
        self.pop_removeAllAnimations()
//        printStats()
        
        resetPreviousPoint()
    }
    
    func resetPreviousPoint() {
        previousPanPoint = CGPoint.zero
    }
    
    func onPanChange() {
        scrollBy(delta: verticalPanDelta)
    }
    
    func onPanEnd() {
        
        resetPreviousPoint()
        
        if topOffset > maxDetailTopOffset ||
            topOffset < minOverallOffset ||
            isEnoughPanVelocityToAnimate {
            animateOffset()
        }
    }
    
    func scrollBy(delta: CGFloat) {
        
        topOffset += delta
        
        updatePanAnimationItems()
        
//        printStats()
        
        updatePreviousPoint()
    }
    
    func updatePreviousPoint() {
        let panPoint = panRecognizer.translation(in: self.view)
        previousPanPoint = panPoint
    }

}
