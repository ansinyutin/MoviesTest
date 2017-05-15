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
        
        let offset:CGPoint = recognizer.translation(in: self.view)
        let offsetY = offset.y
        
        let velocity = recognizer.velocity(in: self.view)
        
        self.constDetailBottom.pop_removeAllAnimations()
        
        refreshPanDirection(offset: offset)
        
        let newOffsetY =  self.initDetailOffset + offset.y;
        let detailOffsetY = minDetailBottomOffset - newOffsetY
        let detailOffset = CGPoint(x:0, y:detailOffsetY)
        
        let isDetailCanHanlePan = self.detailVC.canHandlePan(offset: detailOffset)
        
        switch recognizer.state {
        case .began:
            
            print("BEGIN: \(offsetY)")
            
            self.onPanBegin(offset: offset)
            
        case .changed:
            
            self.onPanChange(offset: offset)
            
        case .cancelled:
            print("\nFailed\n")
        case .failed:
            print("\nFailed\n")
        case .ended:
            
            //            print("\nended\n")
            //            let newDetailBottomOffsetY =  self.initDetailOffset - offset.y
            //            let newDetailBottomOffset =  CGPoint(x: 0, y: newDetailBottomOffsetY)
            
            if isDetailOpened {
                self.detailVC.onPanEnd(offset: offset, velocity: velocity)
            } else {
                self.onPanEnd(offset: offset, velocity: velocity)
            }
            
            
        default: break
        }
        
    }
    
    func refreshPanDirection(offset:CGPoint) {
        
        if ( offset.y != lastOffset.y ) {
            lastDir = (offset.y > lastOffset.y ) ? .Down : .Up
            lastOffset = offset
        }
        
        //        print("REFRESH DIR: \(lastDir) off: \(offset.y)")
    }
    
    func onPanBegin(offset:CGPoint, recognizer:UIPanGestureRecognizer? = nil) {
        
        self.updateInitialDetailOffset()
        self.detailVC.refreshInitialOffset()
        
        if isDetailOpened {
            
            let outerOffset = CGPoint(x:0, y:minDetailBottomOffset - offset.y)
            
            self.detailVC.onPanBegin(offset: outerOffset)
            
            isDetailHandlingPan = true
        }
        
        isDetailHandlingPan = false
    }
    
    func onPanChange(offset: CGPoint, isSkipTopCheck: Bool = false) {
        
        
        let newOffsetY =  self.initDetailOffset + offset.y;
        
        let outerOffsetY = minDetailBottomOffset - newOffsetY
        let outerOffset = CGPoint(x:0, y:outerOffsetY)
        
        let isDetailOpened = self.constDetailBottom.constant <= minDetailBottomOffset
        let isDetailCanHanlePan = self.detailVC.canHandlePan(offset: outerOffset)
        
        if newOffsetY < minDetailBottomOffset {
            self.constDetailBottom.constant = minDetailBottomOffset
        } else if newOffsetY > maxDetailBottomOffset {
            self.constDetailBottom.constant = maxDetailBottomOffset
        }
        
        if ( !isSkipTopCheck && isDetailOpened && isDetailCanHanlePan ) || isDetailHandlingPan {
            
            self.constDetailBottom.constant = minDetailBottomOffset
            
            
            var outOffset:CGFloat = -outerOffset.y
            
//            if lastDir == .Up && outerOffset.y >= 0 ||
//               lastDir == .Down && outerOffset.y <= 0 {
//                outOffset = outerOffset.y
//            }
            
            let detailOffset = CGPoint(x: 0, y: outOffset)
            
            isDetailHandlingPan = true
            
            self.detailVC.onPanChange(offset: detailOffset)            
            
        } else {
            print(
                "ini: \(self.initDetailOffset)\t" +
                "offset: \(offset.y)\t" +
                "outer: \(outerOffset.y)\t" +
                "new: \(newOffsetY)\t" +
                "opened: \(isDetailOpened)\t" +
                "detCan: \(isDetailCanHanlePan)\t" +
                "skip: \(isSkipTopCheck)")
            
            self.constDetailBottom.constant = newOffsetY
            
            isDetailHandlingPan = false
        }
    }
    
    func onPanEnd(offset: CGPoint, velocity:CGPoint) {
        
        print("END: DETAIL OPENED: \(offset)")
        
        self.updateInitialDetailOffset()
        
        if ( self.constDetailBottom.constant == minDetailBottomOffset ) {
            
            self.detailVC.onPanEnd(offset: offset, velocity: velocity)
            
            isDetailHandlingPan = true
            
        } else {
            
            self.animateDetailPosition(velocity: velocity.y)
            
            isDetailHandlingPan = false
        }
    }
    
    func updateInitialDetailOffset() {
        
        self.initDetailOffset = self.constDetailBottom.constant
        
        print("REFRESH INI: \(self.initDetailOffset) DELINIT: \(self.detailVC.initialOffset)")
    }
    
    
    //MARK:- Detail Pan Delegate
    
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        
//        self.constDetailBottom.pop_removeAllAnimations()
//        self.updateInitialDetailOffset()
//        self.onPanChange(offset: CGPoint(x:0, y:0))
//    }
//    
    
    func onActorDetailPanAnimationEnd(velocity:CGPoint) {
        
        print("DETAIL DELEGATE: Pan Animation Ended v: \(velocity)")
        
        self.animateDetailPosition(velocity: -velocity.y)
    }
    
    func onActorDetailPanChange(offset: CGPoint, updateInitialDetailOffset: Bool = false) {
        
        print("DETAIL DELEGATE: Pan off: \(offset)")
//        self.updateInitialDetailOffset()
        
        if updateInitialDetailOffset {
            self.updateInitialDetailOffset()
        }
        
        isDetailHandlingPan = false
        
        let revertedOffset = CGPoint(x: 0, y: -offset.y)
        //        print("FROM DETAIL PAN: off: \(offset.y) initial:\(self.initDetailOffset)")
        self.onPanChange(offset: revertedOffset, isSkipTopCheck: true)
    }
    
    func onActorDetailPanEnd(offset: CGPoint, velocity:CGPoint) {
        
        print("DETAIL DELEGATE: Pan END off: \(offset) v: \(velocity)")
        
        isDetailHandlingPan = false
        
        let revertedOffset = CGPoint(x: 0, y: -offset.y)
        //        print("DETAIL PAN END: off: \(offset.y) initial:\(self.initDetailOffset)")
        
        self.onPanEnd(offset: revertedOffset, velocity: velocity)
    }


}
