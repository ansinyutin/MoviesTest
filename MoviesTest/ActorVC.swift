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
    static let vcShowDuration:Double = 1.0 //0.5
    static let vcHideDuration:Double = 1.0 //0.2
}

struct ActorVCFrames {
    
    static let actorFadeFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: 1),
        KeyFrame(time: 0.45, value: 0.2)
    ]
    
    static let actorZoomFrames:[KeyFrame] = [
        KeyFrame(time: -1, value: 1.15),
        KeyFrame(time: 0, value: 1),
        KeyFrame(time: 1, value: 0.9)
    ]
    
    static let mainTextPanFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: -128),
        KeyFrame(time: 0.7, value: -198)
    ]
    
    static let bottomTextPanFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: -62),
        KeyFrame(time: 0.7, value: -132)
    ]
}

class ActorVC: UIViewController {
    
    //MARK: Views
    
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
    
    
    //MARK: Constraints
    
    var constMainBlockBottom = NSLayoutConstraint()
    var constMoviesBottom = NSLayoutConstraint()
    var constFansBottom = NSLayoutConstraint()
    var constRateBottom = NSLayoutConstraint()
    var constDetailTop = NSLayoutConstraint()
    var constPhotoTop = NSLayoutConstraint()
    
    
    //MARK: Recognizers
    
    var panRecognizer:UIPanGestureRecognizer!
    var tapRecognizer:UITapGestureRecognizer!
    
    
    //MARK: Scroll
    
    var previousPanPoint = CGPoint.zero
    var minDetailTopOffset:CGFloat = 30
    var topOffset:CGFloat = 0
    var minVelocityToAnimate:CGFloat = 200
    
    lazy var maxDetailTopOffset:CGFloat = {
        self.view.frame.height - self.minDetailTopOffset
    }()
    
    lazy var minOverallOffset:CGFloat = {
        -self.detailVC.maxOffset + self.minDetailTopOffset
    }()
    
    var openProgress:CGFloat {
        let maxDiff = maxDetailTopOffset - minDetailTopOffset
        let diff = constDetailTop.constant - minDetailTopOffset
        
        return 1 - diff/maxDiff
    }

    var detailHeight:CGFloat {
        return self.view.frame.size.height - minDetailTopOffset
    }
    
    var isEnoughPanVelocityToAnimate:Bool {
        let velocity = panRecognizer.velocity(in: self.view).y
        return fabs(velocity) >= minVelocityToAnimate
    }
    
    var verticalPanDelta: CGFloat {
        let panPoint:CGPoint = panRecognizer.translation(in: self.view)
        return panPoint.y - previousPanPoint.y
    }
    
    var mainOffset: CGFloat {
        
        var top = topOffset
        
        if top < minDetailTopOffset {
            top = minDetailTopOffset
        }
        
        return top
    }
    
    var extraOffset: CGFloat {
        
        var offset:CGFloat = 0;
        
        if topOffset <= minDetailTopOffset {
            offset = topOffset - minDetailTopOffset
        }
        
        if topOffset >= maxDetailTopOffset {
            offset = 0
        }
        
        return offset
    }
    
    //MARK:- VC lifecicle
    
    override func loadView() {
        super.loadView()
        
        setup()
        setupEvents()
        
        view.backgroundColor = .clear
        topOffset = maxDetailTopOffset
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        animateVCShow()
//    }
//
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        animateVCHide() //TODO custom VC transition
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK:- Debug
    
    func printStats() {
        
        print(
            "offset: \(String(format: "%000.1f", topOffset))\t" +
            "extra: \(String(format: "%.1f", extraOffset))\t" +
//            "delta: \(String(format: "%000.1f", verticalPanDelta))\t" +
            "main: \(String(format: "%.1f", mainOffset))\t" +
            "overall: \(String(format: "%.1f", minOverallOffset))\t" +
            "open: \(String(format: "%.2f", openProgress))\t" +
            "Dopen: \(String(format: "%.2f", getDetailOpenProgress()))\t" +
            "top: \(constDetailTop.constant)\t")
    }
    
    deinit {
        self.pop_removeAllAnimations()
    }
  
}
