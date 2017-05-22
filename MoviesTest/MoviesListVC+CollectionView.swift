//
//  MoviesListVC+CollectionView.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 22.05.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

extension MoviesListVC:UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.moviesSelected(index: indexPath.row)
    }
}

extension MoviesListVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return  CGSize(width: 130, height: 250)
    }
}

