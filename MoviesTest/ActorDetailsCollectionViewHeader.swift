//
//  ActorDetailsCollectionViewHeader.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 29.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

class ActorDetailsCollectionViewHeader: UICollectionReusableView {
    
    let biographyLabel = UILabel(frame: .zero)
    
    let fansList = ActorsFansView(frame: .zero)
    
    let fansLabel = UILabel(frame: .zero)
    let fansHeartImageView = UIImageView(frame: .zero)
    
    let fansView = UIView(frame: .zero)
    
    struct Metrics {
        static var bioTop:CGFloat = 4
        static var bioSide:CGFloat = 40
        static var bioBottom:CGFloat = 20
        static var fansBottom:CGFloat = 16
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        
        biographyLabel.translatesAutoresizingMaskIntoConstraints = false
        biographyLabel.font = UIFont.regularFontOfSize(14)
        biographyLabel.textColor = .black
        biographyLabel.numberOfLines = 0
        biographyLabel.lineBreakMode = .byWordWrapping
        biographyLabel.textAlignment = .center
        biographyLabel.sizeToFit()
        
        self.addSubview(biographyLabel)
        
        fansList.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fansList)
        
        
        addCustomConstraints()
    }
    
    func setupWith(actor:Actor) {
        
        fansList.setupWith(fans: actor.fans, maxCellsCount: 6)
        biographyLabel.text = actor.biography
    }
    
    func addCustomConstraints() {
        
        let metrics:[String:Any] = [
            "bioTop": Metrics.bioTop,
            "bioSide": Metrics.bioSide,
            "bioBottom": Metrics.bioBottom,
            "fansBottom": Metrics.fansBottom,
        ]

        let views: [String:UIView] = [
            "biography":biographyLabel,
            "fans":fansList
        ]
        
        //Horizontal layout
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(bioSide)-[biography]-(bioSide)-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[fans]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        //Vertical layout
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(bioTop)-[biography]-(bioBottom)-[fans]-(fansBottom)-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        self.biographyLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .vertical)
    }
    
    static func heightForActor(_ actor:Actor, parentView: UIView) -> CGFloat {
        
        var height:CGFloat = 0
        
        let bioHeight = actor.biography.heightWithConstrainedWidth(
            font: UIFont.regularFontOfSize(14),
            withWidth: parentView.frame.width - (Metrics.bioSide*2)
        )
        
        height += bioHeight
        
        height += Metrics.bioBottom
        height += Metrics.bioTop
        height += 62.5 //fans height
        height += Metrics.fansBottom
        
        height = ceil(height)
        
        print("header height: \(height)")

        return height
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        biographyLabel.preferredMaxLayoutWidth = biographyLabel.frame.size.width
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
