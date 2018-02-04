//
//  ActorsListVC.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 28.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

@objc protocol ActorsListVCDelegate {
    func actorSelected(index: Int)
}

class ActorsListVC: UIViewController {
    
    weak var delegate:ActorsListVCDelegate?
    
    var list:UICollectionView!
    
    let data:[Dictionary<String,String>] = [
        [
            "name": "Christine Grant",
            "image": "persons_item_1"
        ],
        [
            "name": "Willem Dafoe",
            "image": "persons_item_2"
        ],
        [
            "name": "Christine Grant",
            "image": "persons_item_3"
        ],
        [
            "name": "Christine Grant",
            "image": "persons_item_4"
        ],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGradientLayerWithColors(colors: [UIColor(rgba: "#fbfbfb"), .white])
    }
    
    override func loadView() {
        super.loadView()
        
        setup()
    }
    
    func setup() {

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 19
        flowLayout.sectionInset = UIEdgeInsets(top: 32, left: 20, bottom: 0, right: 20)
        
        
        list = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.backgroundColor = .clear
        
        list.delegate = self
        list.dataSource = self
        
        list.register(ActorCell.self, forCellWithReuseIdentifier: "actorCell")
        self.view.addSubview(list)
        
        addCustomConstraints()
    }    
    
    func addCustomConstraints() {
        
        let metrics = [String:Any]()
        
        let views: [String:UIView] = [
            "list":list
        ]
        
        //Horizontal layout
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[list]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        //Vertical layout
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[list]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
    }
}
