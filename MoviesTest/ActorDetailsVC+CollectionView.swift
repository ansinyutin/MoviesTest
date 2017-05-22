//
//  ActorDetailsVC+CollectionView.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 19.05.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

extension ActorDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let dataItem = self.data[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdForMoviesItem, for: indexPath) as! ActorDetailCollectionViewCell
        
        let imageName = dataItem["image"]!
        let image = UIImage(named:imageName)!
        
        cell.setupWith(image: image, imageSize: listItemSize)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView : UICollectionReusableView? = nil
        
        if (kind == UICollectionElementKindSectionHeader) {
            
            let headerView =
                collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: self.reuseIdForMoviesHeader,
                    for: indexPath) as! ActorDetailsCollectionViewHeader
            
            headerView.backgroundColor = getBgColor()
            headerView.setupWith(actor: self.actor)
            
            reusableView = headerView
            
            listHeader = headerView
        }
        
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dataItem = self.data[indexPath.row]
        
        print("actor detail list items selected \(dataItem)")
    }
    
}

extension ActorDetailsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return listItemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let height = ActorDetailsCollectionViewHeader.heightForActor(self.actor, parentView: self.list)
        return CGSize(width: collectionView.frame.size.width, height: height)
    }
}
