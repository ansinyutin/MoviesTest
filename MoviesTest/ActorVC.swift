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
    
    var isDetailHandlingPan = false
    
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
    
    
    func addGradientToPhoto() {
//        photoImageView.addGradientLayerWithColors(colors: [.clear, .black], start: CGPoint(x:0, y:0.8))
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
  
}
