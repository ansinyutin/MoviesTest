//
//  ActorDetailsHeaderView.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 30.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

class ActorDetailsHeaderView: UIView {
    
    let nameLabel = UILabel(frame: .zero)
    let profLabel = UILabel(frame: .zero)
    let dotsImageView = UIImageView(frame: .zero)
    let arrowImageView = UIImageView(frame: .zero)
    
    var constArrowTop = NSLayoutConstraint()
    var constNameTop = NSLayoutConstraint()
    
    struct Metrics {
        static var arrowTopMax:CGFloat = 15
        static var arrowTopMin:CGFloat = 0
        
        static var dotsTop:CGFloat = 16
        static var dotsRight:CGFloat = 21
        
        static var nameTopMax:CGFloat = 34
        static var nameTopMin:CGFloat = 0
        static var nameBottom:CGFloat = 0
        
        static var profBottom:CGFloat = 18
    }
    
    var showBBorder = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        
        self.backgroundColor = UIColor.moviesBlack5
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = UIColor.moviesBlackTwo
        nameLabel.font = UIFont.semiboldFontOfSize(12)
        nameLabel.textAlignment = .center
        self.addSubview(nameLabel)
        
        
        profLabel.translatesAutoresizingMaskIntoConstraints = false
        profLabel.textColor = UIColor.black.withAlphaComponent(0.3)
        profLabel.font = UIFont.semiboldFontOfSize(10)
        profLabel.textAlignment = .center
        self.addSubview(profLabel)
        
        
        dotsImageView.translatesAutoresizingMaskIntoConstraints = false
        dotsImageView.image = UIImage(named: "three_circles")
        self.addSubview(dotsImageView)
        
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.image = UIImage(named: "drag_arrow")
        self.addSubview(arrowImageView)
        
        addCustomConstraints()
    }
    
    func setupWith(actor:Actor) {
        
        nameLabel.text = actor.name
        profLabel.text = actor.professions.joined(separator: ", ").uppercased()
        profLabel.addTextSpacing(1)
    }
    
    func addCustomConstraints() {
        
        let metrics:[String:Any] = [
            "arrowTopMax": Metrics.arrowTopMax,
            "arrowTopMin": Metrics.arrowTopMin,
            
            "dotsTop": Metrics.dotsTop,
            "dotsRight": Metrics.dotsRight,
            
            "nameTopMax": Metrics.nameTopMax,
            "nameTopMin": Metrics.nameTopMin,
            "nameBottom": Metrics.nameBottom,
            
            "profBottom": Metrics.profBottom
        ]
    
        let views: [String:UIView] = [
            "name":nameLabel,
            "prof":profLabel,
            "dots":dotsImageView,
            "arrow":arrowImageView
        ]
        
        //Horizontal layout
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[name]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[prof]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[dots]-(dotsRight)-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.addConstraint(NSLayoutConstraint(item: arrowImageView,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .centerX,
                                                   multiplier: 1.0,
                                                   constant: 0))
        
        
        
        //Vertical layout
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(dotsTop)-[dots]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.constArrowTop = NSLayoutConstraint(item: arrowImageView,
                                                attribute: .top,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .top,
                                                multiplier: 1.0,
                                                constant: Metrics.arrowTopMax)
        self.addConstraint(self.constArrowTop)
        
        
        self.constNameTop = NSLayoutConstraint(item: nameLabel,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: Metrics.nameTopMax)
        self.addConstraint(self.constNameTop)
        
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[name]-(nameBottom)-[prof]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if showBBorder {
            let grayLine = UIBezierPath(rect: CGRect(x: 0, y: rect.size.height - 2, width: rect.size.width, height: 1))
            
            UIColor.moviesSeparator.setFill()
            grayLine.fill()
            
            let whiteLine = UIBezierPath(rect: CGRect(x: 0, y: rect.size.height - 1, width: rect.size.width, height: 1))
            
            UIColor.white.setFill()
            whiteLine.fill()
        }
    }
    
}
