//
//  ActorFansView.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 30.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit


class ActorsFansView: UIView {
    
    
    var fansCountLabel = UILabel(frame: .zero)
    var heartImageView = UIImageView(frame: .zero)
    
    var list:UICollectionView!
    let defaultCellReuseId = "fansReuseId"
    let moreFansReuseId = "moreFansReuseId"
    
    var data:[Fan] = [Fan]()
    
    var maxCellsCount = 6
    
    var isMaxCellsCountExceeded = false
    
    var moreFansCount:Int {
        let count = data.count - maxCellsCount
        return count > 0 ? count : 0
    }
    
    let cellSize = CGSize(width: 30, height: 30)
    
    var cellsCount:Int {
        
        if data.count >= maxCellsCount {
            return maxCellsCount
        }
        
        return data.count
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        list = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.backgroundColor = .clear
        
        list.delegate = self
        list.dataSource = self
        
        list.register(ActorFansCollectionViewCell.self, forCellWithReuseIdentifier: defaultCellReuseId)
        list.register(ActorFansCollectionViewMoreFansCell.self, forCellWithReuseIdentifier: moreFansReuseId)
        
        list.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        
        self.addSubview(list)
        
        
        fansCountLabel.translatesAutoresizingMaskIntoConstraints = false
        fansCountLabel.textColor = UIColor.moviesWarmGrey
        fansCountLabel.font = UIFont.semiboldFontOfSize(10)
        self.addSubview(fansCountLabel)
        
        
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        heartImageView.image = UIImage(named: "heart")
        self.addSubview(heartImageView)
        
        addCustomConstraints()
        
    }
    
    func addCustomConstraints() {
        
        let metrics = [String:Any]()
        
        let views: [String:UIView] = [
            "list":list,
            "count":fansCountLabel,
            "heart":heartImageView,
        ]
        
        //Horizontal layout
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[list]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[heart]-5-[count]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.addConstraint(NSLayoutConstraint(item: fansCountLabel,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: fansCountLabel.superview,
                                              attribute: .centerX,
                                              multiplier: 1.0,
                                              constant: 0))
        //Vertical layout
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[count]-20-[list(30)]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        self.addConstraint(NSLayoutConstraint(item: heartImageView,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: fansCountLabel,
                                                   attribute: .centerY,
                                                   multiplier: 1.0,
                                                   constant: 0))
        
        self.fansCountLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        
    }
    
    //MARK:- Actions
    
    func setupWith(fans:[Fan], maxCellsCount: Int) {
        
        self.data = fans
        self.maxCellsCount = maxCellsCount
        self.checkIfMaxCellsCountExceeded()
        
        self.fansCountLabel.text = "\(fans.count) fans".uppercased()
        self.fansCountLabel.addTextSpacing(1)
    }
    
    func checkIfMaxCellsCountExceeded() {
        
        if self.data.count > self.maxCellsCount {
            self.isMaxCellsCountExceeded = true
        }
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
