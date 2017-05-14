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

enum Direction {
    case Up, Down
}

class ActorVC: UIViewController, ActorDetailsVCPanDelegate{
    
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
    
    var constDetailBottom = NSLayoutConstraint()
    
    var initDetailOffset:CGFloat = 0
    var lastOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    var lastDir:Direction = .Up
    
    var panRecognizer:UIPanGestureRecognizer!
    
    var maxDetailBottomOffset:CGFloat = -30
    lazy var minDetailBottomOffset:CGFloat = {
        -(self.view.frame.height + self.maxDetailBottomOffset)
    }()
    

    var isDetailOpened:Bool {
        return self.constDetailBottom.constant == minDetailBottomOffset
    }
    
    var detailHeight:CGFloat {
        return self.view.frame.size.height - 30
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        setup()
        setupEvents()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addGradientToPhoto()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        self.addEdgeBottomBounceAnimationToDetail(velocity: CGPoint(x:0, y:-200), toY: -30)
//    }
    
    //MARK:- Events
    
    func setupEvents() {
        self.panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        self.view.addGestureRecognizer(self.panRecognizer)
    }
    
    //MARK:- Scroll
    
    func enablePanRecognizer(isEnabled:Bool) {
        print("ACTOR RECOGNIZER: \(isEnabled)")
//        self.panRecognizer.isEnabled = isEnabled
    }

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
        
        self.refreshInitialDetailOffset()
        
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
            let detailOffset = CGPoint(x: 0, y: -outerOffset.y)
            
            self.detailVC.onPanChange(offset: detailOffset)
            
            isDetailHandlingPan = true
            
        } else {
            print(
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
        
        self.refreshInitialDetailOffset()
        
        if ( self.constDetailBottom.constant == minDetailBottomOffset ) {
            
            self.detailVC.onPanEnd(offset: offset, velocity: velocity)
            
            isDetailHandlingPan = true
            
        } else {
            
            self.animateDetailPosition(velocity: velocity.y)
            
            isDetailHandlingPan = false
        }
    }
    
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
            
            self.refreshInitialDetailOffset()
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
    
    func refreshInitialDetailOffset() {
        
        self.initDetailOffset = self.constDetailBottom.constant
        
        print("REFRESH INITIAL: \(self.initDetailOffset)")
    }
    
    //MARK:- Detail Pan Delegate
    
    var isDetailHandlingPan = false
    
    func onActorDetailPanAnimationEnd(velocity:CGPoint) {
        
        print("DETAIL DELEGATE: Pan Animation Ended v: \(velocity)")
        
        
        
        self.animateDetailPosition(velocity: -velocity.y)
    }
    
    func onActorDetailPanChange(offset: CGPoint) {
        
        print("DETAIL DELEGATE: Pan off: \(offset)")
        
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
    
    //MARK:- Setup
    
    func setup() {
        
        self.view.backgroundColor = .black
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.layer.cornerRadius = 10
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.drawsAsynchronously = true
        photoImageView.layer.shouldRasterize = true
        photoImageView.layer.masksToBounds = true
        
        if let win = UIApplication.shared.keyWindow {
            photoImageView.layer.rasterizationScale = win.screen.scale
        }
        
        self.view.addSubview(photoImageView)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = UIFont.extraboldFontOfSize(27)
        self.view.addSubview(titleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        subtitleLabel.font = UIFont.semiboldFontOfSize(10)
        self.view.addSubview(subtitleLabel)
        
        
        moviesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        moviesTitleLabel.textColor = .white
        moviesTitleLabel.font = UIFont.boldFontOfSize(12)
        self.view.addSubview(moviesTitleLabel)
        
        moviesSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        moviesSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.3)
        moviesSubtitleLabel.font = UIFont.semiboldFontOfSize(12)
        moviesSubtitleLabel.numberOfLines = 0
        self.view.addSubview(moviesSubtitleLabel)
        
        
        fansTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        fansTitleLabel.textColor = .white
        fansTitleLabel.font = UIFont.boldFontOfSize(12)
        self.view.addSubview(fansTitleLabel)
        
        fansSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        fansSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.3)
        fansSubtitleLabel.font = UIFont.semiboldFontOfSize(12)
        fansSubtitleLabel.numberOfLines = 0
        self.view.addSubview(fansSubtitleLabel)
        
        
        rateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        rateTitleLabel.textColor = .white
        rateTitleLabel.font = UIFont.boldFontOfSize(12)
        self.view.addSubview(rateTitleLabel)
        
        rateSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        rateSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.3)
        rateSubtitleLabel.font = UIFont.semiboldFontOfSize(12)
        rateSubtitleLabel.numberOfLines = 0
        self.view.addSubview(rateSubtitleLabel)
        
        rateStarImageView.translatesAutoresizingMaskIntoConstraints = false
        rateStarImageView.image = UIImage(named: "star")
        rateStarImageView.contentMode = .scaleAspectFit
        self.view.addSubview(rateStarImageView)
        
        
        
        detailVC.panDelegate = self
        detailVC.view.translatesAutoresizingMaskIntoConstraints = false
        detailVC.view.backgroundColor = .white
        self.addChildViewController(detailVC)
        self.view.addSubview(detailVC.view)
        detailVC.didMove(toParentViewController: self)
        
        detailVC.list.isScrollEnabled = false
        
        addCustomConstraints()
    }
    
    func setupWithActor(name: String, professions: [String], moviesWatched: Int, allMovies: Int, fans: Int, rate: Float) {
        
        photoImageView.image = UIImage(named: "actor_big")
        
        
        titleLabel.text = name
        titleLabel.addTextSpacing(-0.3)
        
        subtitleLabel.text = professions.joined(separator: ", ").uppercased()
        subtitleLabel.addTextSpacing(1)
        
        let moviesTitleStr = NSMutableAttributedString(string: "\(moviesWatched)")
        let allMoviesStr     = NSAttributedString(string: "\(allMovies)")
        
        let ofAttribute = [ NSFontAttributeName: UIFont.playfairItalicFontOfSize(12)]
        let ofString = NSAttributedString(string: " of ", attributes: ofAttribute)
        
        moviesTitleStr.append(ofString)
        moviesTitleStr.append(allMoviesStr)
        
        moviesTitleLabel.attributedText = moviesTitleStr
        moviesSubtitleLabel.text = "Movies watched"
        
        fansTitleLabel.text = "\(fans)"
        fansSubtitleLabel.text = "Fans on Must"
        
        rateTitleLabel.text = "\(rate)"
        rateSubtitleLabel.text = "Average movies rating"
    }
    
    func addGradientToPhoto() {
//        photoImageView.addGradientLayerWithColors(colors: [.clear, .black], start: CGPoint(x:0, y:0.8))
    }
    
    //MARK:- Layout
    
    func addCustomConstraints() {
        
        let metrics:[String:Any] = [
            "textPadding": 30,
            "moviesWidth": 260,
            "fansWidth": 260,
            "rateWidth": 260,
            "detailHeight": self.view.frame.size.height - 20,
        ]
        
        let views: [String:UIView] = [
            "title":titleLabel,
            "subtitle":subtitleLabel,
            
            "moviesTitle":moviesTitleLabel,
            "moviesSubtitle":moviesSubtitleLabel,
            
            "fansTitle":fansTitleLabel,
            "fansSubtitle":fansSubtitleLabel,
            
            "rateTitle":rateTitleLabel,
            "rateSubtitle":rateSubtitleLabel,
            "rateStar":rateStarImageView,
            
            
            "photo":photoImageView,
            
            "detail":detailVC.view
        ]
        
        //Horizontal layout
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[photo]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[detail]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(textPadding)-[title]-(textPadding)-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(textPadding)-[subtitle]-(textPadding)-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))

        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(textPadding)-[moviesTitle(80)]-8-[fansTitle(60)]-13-[rateTitle]-2-[rateStar]-(>=0)-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: moviesSubtitleLabel,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: moviesTitleLabel,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: moviesSubtitleLabel,
                                                   attribute: .trailing,
                                                   relatedBy: .equal,
                                                   toItem: moviesTitleLabel,
                                                   attribute: .trailing,
                                                   multiplier: 1.0,
                                                   constant: 0))

    
        self.view.addConstraint(NSLayoutConstraint(item: fansSubtitleLabel,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: fansTitleLabel,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: fansSubtitleLabel,
                                                   attribute: .trailing,
                                                   relatedBy: .equal,
                                                   toItem: fansTitleLabel,
                                                   attribute: .trailing,
                                                   multiplier: 1.0,
                                                   constant: 0))
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[rateSubtitle(80)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: rateSubtitleLabel,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: rateTitleLabel,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 0))
        
        
        
        //Vertical layout
        
        
        //TODO delete
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[detail(detailHeight)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-43-[photo]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[title]-0-[subtitle]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[moviesTitle]-0-[moviesSubtitle]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[fansTitle]-0-[fansSubtitle]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[rateTitle]-0-[rateSubtitle]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: rateStarImageView,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: rateTitleLabel,
                                                   attribute: .centerY,
                                                   multiplier: 1.0,
                                                   constant: 0))
        
        self.constMainBlockBottom = NSLayoutConstraint(item: subtitleLabel,
                                                       attribute: .bottom,
                                                       relatedBy: .equal,
                                                       toItem: subtitleLabel.superview,
                                                       attribute: .bottom,
                                                       multiplier: 1.0,
                                                       constant: ActorVCAnimation.mainBlockYFrom)
        self.view.addConstraint(self.constMainBlockBottom)
        
        
        
        self.constMoviesBottom = NSLayoutConstraint(item: moviesSubtitleLabel,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: moviesSubtitleLabel.superview,
                                                    attribute: .bottom,
                                                    multiplier: 1.0,
                                                    constant: ActorVCAnimation.bottomBlockYFrom)
        self.view.addConstraint(self.constMoviesBottom)
        
        
        self.constFansBottom = NSLayoutConstraint(item: fansSubtitleLabel,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: fansSubtitleLabel.superview,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: ActorVCAnimation.bottomBlockYFrom)
        self.view.addConstraint(self.constFansBottom)
        
        
        self.constRateBottom = NSLayoutConstraint(item: rateSubtitleLabel,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: rateSubtitleLabel.superview,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: ActorVCAnimation.bottomBlockYFrom)
        self.view.addConstraint(self.constRateBottom)
        
        
        self.constDetailBottom = NSLayoutConstraint(item: detailVC.view,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: self.view,
                                                    attribute: .bottom,
                                                    multiplier: 1.0,
                                                    constant: ActorVCAnimation.detailYFrom)
//                                                    constant: -(view.frame.size.height + ActorVCAnimation.detailYFrom))
        self.view.addConstraint(self.constDetailBottom)
        

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
  
}
