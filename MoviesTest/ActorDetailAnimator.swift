//
//  ActorDetailAnimator.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 03.02.18.
//  Copyright © 2018 Синютин Андрей. All rights reserved.
//

import Foundation
import UIKit

class ActorDetailAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var presenting = true
    var originFrame = CGRect.zero
    
    var dismissCompletion: (()->Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        if let context = transitionContext,
            let _ = context.viewController(forKey: .to) as? ActorVC {
            return ActorVCAnimation.vcShowDuration
        }
        
        return ActorVCAnimation.vcHideDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        
        
        
        if let toVC = transitionContext.viewController(forKey: .to) as? ActorVC {
            
            containerView.addSubview(toView)
            containerView.bringSubview(toFront: toView)
            
            toVC.animateVCShow(onComplete: {
                transitionContext.completeTransition(true)
            })
        }
        
        if let fromVC = transitionContext.viewController(forKey: .from) as? ActorVC {
            
            containerView.addSubview(toView)
            containerView.addSubview(fromView)
            containerView.bringSubview(toFront: fromView)
            
            fromVC.animateVCHide(onComplete: {
                transitionContext.completeTransition(true)
            })
        }
    }
    
}
