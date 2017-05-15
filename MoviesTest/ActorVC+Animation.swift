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
    
    func animateDetailPosition(velocity: CGFloat) {
        
        print("Detail Y Animate Start v: \(velocity)")
        
        let detailAnimation = POPDecayAnimation(propertyNamed: kPOPLayoutConstraintConstant)!
        detailAnimation.velocity = velocity
        detailAnimation.animationDidApplyBlock = { (animation:POPAnimation?) in
            
            let animationVelocity = animation!.value(forKey: "velocity") as! CGFloat
            let animationVelocityPoint = CGPoint(x: 0, y: animationVelocity)
            
            if self.constDetailBottom.constant > self.maxDetailBottomOffset {
                
                self.constDetailBottom.pop_removeAllAnimations()
                
                print("Detail Y Animate END - maxOffset")
                
                
                self.addEdgeBottomBounceAnimationToDetail(velocity: animationVelocityPoint, toY: self.maxDetailBottomOffset)
            }
            
            if self.constDetailBottom.constant < self.minDetailBottomOffset {
                
                self.constDetailBottom.constant = self.minDetailBottomOffset
                self.constDetailBottom.pop_removeAllAnimations()
                
                print("Detail Y Animate END - minOffset v:\(-animationVelocity)")
                
                self.detailVC.scrollList(withVelocity: -animationVelocity)
            }
            
            self.updateInitialDetailOffset()
        }
        
        self.constDetailBottom.pop_add(detailAnimation, forKey: "detailBottomAnimation")
    }
    
    
    
    func addEdgeBottomBounceAnimationToDetail(velocity: CGPoint, toY: CGFloat) {
        
        print("Y Bottom Bounce Animation START")
        
        let bottomAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)!
        bottomAnimation.velocity = velocity.y
        bottomAnimation.springBounciness = 0
        bottomAnimation.springSpeed = 3
        bottomAnimation.toValue = toY
        bottomAnimation.completionBlock = { (anim:POPAnimation?, completion:Bool) in
            print("Y Bottom Bounce Animation END")
        }
        
        self.constDetailBottom.pop_add(bottomAnimation, forKey: "detailBottomBounceAnimation")
    }
   
}
