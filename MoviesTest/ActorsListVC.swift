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

class ActorsListVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    weak var delegate:ActorsListVCDelegate?
    
    var list:UICollectionView!
    
    let data:[Dictionary<String,String>] = [
        [
            "name": "Christine Grant",
            "image": "persons_item_1"
        ],
        [
            "name": "Christine Grant",
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
    }
    
    override func loadView() {
        super.loadView()
        
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.addGradientLayerWithColors(colors: [UIColor(rgba: "#fbfbfb"), .white])
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let dataItem = self.data[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "actorCell", for: indexPath) as! ActorCell
        
        let imageName = dataItem["image"]!
        let image = UIImage(named:imageName)!
        
        cell.setupWith(image: image, title: dataItem["name"]!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.actorSelected(index: indexPath.row)
    }
    
}
