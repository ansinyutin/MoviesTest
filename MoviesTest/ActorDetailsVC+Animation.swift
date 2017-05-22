//
//  ActorDetailsVC+Animation.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 19.05.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

extension ActorDetailsVC {
    
    func updateAnimatableViews() {
        
        if prevTopOffset >= 0 || topOffset >= 0 {
            updateListOffset()
            shrinkHeader()
        }
        
        if topOffset == 0 {
            updateOpenProgress()
        }
    }
    
    func updateListOffset() {
        self.list.contentOffset = CGPoint(x: 0, y: listOffset)
    }
    
    //MARK:- Header shrink
    
    func shrinkHeader() {
        shrinkHeaderHeight()
        shrinkHeaderArrow()
        shrinkHeaderTitle()
        shrinkHeaderBBorder()
    }
    
    func shrinkHeaderHeight() {
        let headerHeight = Animation.getValue(frames: Frames.headerHeightShrink, time: fabs(topOffset))
        self.constHeaderHeight.constant = headerHeight
    }
    
    func shrinkHeaderArrow() {
        shrinkHeaderArrowOpacity()
        shrinkHeaderArrowPosition()
    }
    
    func shrinkHeaderArrowOpacity() {
        let opacity = Animation.getValue(frames: Frames.headerArrowOpacityShrink, time: fabs(topOffset))
        self.header.arrowImageView.layer.opacity = Float(opacity)
    }
    
    func shrinkHeaderArrowPosition() {
        let offset = Animation.getValue(frames: Frames.headerArrowPositionShrink, time: fabs(topOffset))
        self.header.constArrowTop.constant = offset
    }
    
    func shrinkHeaderTitle() {
        let offset = Animation.getValue(frames: Frames.headerTitlePositionShrink, time: fabs(topOffset))
        self.header.constNameTop.constant = offset
    }
    
    func shrinkHeaderBBorder() {
        self.header.showBBorder = topOffset > headerShrinkHeight
    }

    
    //MARK:- Scroll Animation
    
    func updateOpenProgress() {
        updateBackgroundColor()
        updateHeader()
    }
    
    func updateBackgroundColor() {
        let color = getBgColor()
        
        header.backgroundColor = color
        listHeader?.backgroundColor = color
    }
    
    func updateHeader() {
        
        updateHeaderArrowOpacity()
        updateHeaderArrowRotation()
        
        updateHeaderDotsOpacity()
        
        updateHeaderTitlePosition()
        updateHeaderTitleOpacity()
    }
    
    func updateHeaderTitlePosition() {
        let offset = Animation.getValue(frames: Frames.headerTitlePosition, time: openProgress)
        self.header.constNameTop.constant = offset
    }
    
    func updateHeaderTitleOpacity() {
        
        let titleOpacity = Animation.getValue(frames: Frames.headerTitleOpacity, time: openProgress)
        self.header.nameLabel.layer.opacity = Float(titleOpacity)
        self.header.profLabel.layer.opacity = Float(titleOpacity)
    }
    
    func updateHeaderArrowRotation() {
        
        var degrees:CGFloat = 0
        
        if openProgress <= 0.4 {
            degrees = 180
        } else {
            degrees = 0
        }
        
        let angle = CGAffineTransform(rotationAngle: degrees * CGFloat.pi/180.0)
        
        self.header.arrowImageView.transform = angle
    }
    
    func updateHeaderArrowOpacity() {
        let arrowOpacity = Animation.getValue(frames: Frames.arrowOpacity, time: openProgress)
        self.header.arrowImageView.layer.opacity = Float(arrowOpacity)
    }
    
    func updateHeaderDotsOpacity() {
        let dotsOpacity = Animation.getValue(frames: Frames.headerDotsOpacity, time: openProgress)
        self.header.dotsImageView.layer.opacity = Float(dotsOpacity)
    }
    
    func getBgColor() -> UIColor {
        
        let curAlpha = Animation.getValue(frames: Frames.bgOpacity, time: openProgress)
        return UIColor.init(white: curAlpha, alpha: 1)
    }
}
