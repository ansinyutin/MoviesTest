//
//  listVC.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 27.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

@objc protocol MoviesListVCDelegate {
    func moviesSelected(index: Int)
}

class MoviesListVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    weak var delegate:MoviesListVCDelegate?
    
    var list:UICollectionView!
    
    let data:[Dictionary<String,String>] = [
        [
            "title": "La La Land",
            "year": "2007",
            "image": "movies_item_1"
        ],
        [
            "title": "Deadpool",
            "year": "2007",
            "image": "movies_item_2"
        ],
        [
            "title": "Mozart in the Jungle",
            "year": "2009",
            "image": "movies_item_3"
        ]
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
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 47, left: 20, bottom: 0, right: 20)
        
        list = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.backgroundColor = .clear
        
        list.delegate = self
        list.dataSource = self
        
        list.register(MovieCell.self, forCellWithReuseIdentifier: "movieCell")
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        let imageName = dataItem["image"]!
        let image = UIImage(named:imageName)!
        
        cell.setupWith(image: image, title: dataItem["title"]!, subtitle: dataItem["year"]!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return  CGSize(width: 130, height: 250)
    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        return UIEdgeInsets(top: 37, left: 20, bottom: 30, right: 20)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.moviesSelected(index: indexPath.row)
    }
    
}
