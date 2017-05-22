//
//  ActorDetailsVC+Setup.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 19.05.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

extension ActorDetailsVC {
    
    func setup() {
        
        view.round(corners: [.topLeft, .topRight], radius: 10)
        
        setupList()
        setupHeader()
        
        addCustomConstraints()
    }
    
    func setupList() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 100, height: 150)
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 17, bottom: 20, right: 18)
        
        list = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.backgroundColor = .white
        
        list.delegate = self
        list.dataSource = self
        
        list.register(ActorDetailCollectionViewCell.self,
                      forCellWithReuseIdentifier: self.reuseIdForMoviesItem)
        
        list.register(ActorDetailsCollectionViewHeader.self,
                      forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                      withReuseIdentifier: self.reuseIdForMoviesHeader)
        
        self.view.addSubview(list)
    }
    
    func setupHeader() {
        header.backgroundColor = getBgColor()
        header.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(header)
    }
}
