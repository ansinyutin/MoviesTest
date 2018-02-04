//
//  ActorDetailsVC.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 29.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit
import pop

class ActorDetailsVC: UIViewController {
    
    struct Metrics {
        static var headerHeight:CGFloat = 80.0
        
        static var closedBgColor = UIColor(rgba: "#202020")
        static var openedBgColor = UIColor.moviesBlack5
    }
    
    struct Frames {
        
        static let headerHeightShrink:[KeyFrame] = [
            KeyFrame(time: 0, value: 80),
            KeyFrame(time: 20, value: 60),
        ]
        
        static let headerArrowOpacityShrink:[KeyFrame] = [
            KeyFrame(time: 0, value: 1),
            KeyFrame(time: 20, value: 0),
        ]
        
        static let headerArrowPositionShrink:[KeyFrame] = [
            KeyFrame(time: 0, value: 15),
            KeyFrame(time: 20, value: 5),
        ]
        
        static let headerTitlePositionShrink:[KeyFrame] = [
            KeyFrame(time: 0, value: 34),
            KeyFrame(time: 20, value: 18),
        ]
        
        static let headerTitlePosition:[KeyFrame] = [
            KeyFrame(time: 0, value: 44),
            KeyFrame(time: 0.6, value: 44),
            KeyFrame(time: 0.9, value: 34),
            KeyFrame(time: 1, value: 34),
        ]
        
        static let headerTitleOpacity:[KeyFrame] = [
            KeyFrame(time: 0, value: 0),
            KeyFrame(time: 0.6, value: 0),
            KeyFrame(time: 0.85, value: 1),
            KeyFrame(time: 1, value: 1),
        ]
        
        static let arrowOpacity:[KeyFrame] = [
            KeyFrame(time: 0, value: 0.2),
            KeyFrame(time: 0.4, value: 0),
            KeyFrame(time: 0.6, value: 0),
            KeyFrame(time: 1, value: 1),
        ]
        
        static let headerDotsOpacity:[KeyFrame] = [
            KeyFrame(time: 0, value: 0),
            KeyFrame(time: 0.9, value: 0),
            KeyFrame(time: 1, value: 1),
        ]
        
        static let bgOpacity:[KeyFrame] = [
            KeyFrame(time: 0, value: 0.13),
            KeyFrame(time: 0.3, value: 0.13),
            KeyFrame(time: 0.9, value: 0.95),
            KeyFrame(time: 1, value: 0.95),
        ]
    }
    
    let header = ActorDetailsHeaderView(frame: .zero)
    
    var list:UICollectionView!
    var listHeader:UICollectionReusableView? = nil
    
    var listItemSize:CGSize {
        return UIScreen.isiPhone4or5() ? CGSize(width: 80, height: 120) : CGSize(width: 100, height: 150)
    }
    
    let data:[Movie] = DataStorage.shared.movies
    
    let reuseIdForMoviesHeader = "ActorDetailsMoviesHeader"
    let reuseIdForMoviesItem = "ActorDetailsMoviesItem"
    
    var actor:Actor = DataStorage.shared.WilliamDafoe
    
    var panRecognizer:UIPanGestureRecognizer!
    
    var constHeaderHeight = NSLayoutConstraint()
    
    var initialOffset:CGFloat = 0
    var lastOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    let minOffset:CGFloat = 0
    lazy var maxOffset:CGFloat = {
        return self.list.contentSize.height - self.list.frame.size.height
    }()
    
    var prevTopOffset:CGFloat = 0
    var topOffset:CGFloat = 0
    
    var openProgress:CGFloat = 0 // 0.0 - 1.0

    var isOpened:Bool {
        return self.openProgress == 1.0
    }
    
    let headerShrinkHeight:CGFloat = 20
    
    var isTopReached:Bool {
        return self.list.contentOffset.y <= self.minOffset
    }
    
    var isBottomReached:Bool {
        return self.list.contentOffset.y >= self.maxOffset
    }
    
    var listOffset: CGFloat {
        
        var offset = topOffset
        
        if offset > headerShrinkHeight {
            offset -= headerShrinkHeight
        } else {
            offset = 0
        }
        
        return offset
    }

    override func loadView() {
        super.loadView()
        
        setup()
        refresh()
    }
    
    
    //MARK:- Refresh
    
    func refresh(){
        self.header.setupWith(actor: actor)
        updateAnimatableViews()
    }
    
    
    //MARK:- Scroll handling
    
    func update(withTopOffset offset: CGFloat, openProgress progress: CGFloat) {
        
        prevTopOffset = topOffset
        topOffset = offset
        openProgress = progress
        
        updateAnimatableViews()
    }
}


