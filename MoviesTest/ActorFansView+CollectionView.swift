//
//  ActorFansView+CollectionView.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 22.05.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

extension ActorsFansView:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let index = indexPath.row
        
        let dataItem = self.data[index]
        
        var cell:UICollectionViewCell
        
        if isMaxCellsCountExceeded  && index == (maxCellsCount - 1) {
            
            let moreFansCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.moreFansReuseId, for: indexPath) as! ActorFansCollectionViewMoreFansCell
            
            moreFansCell.setupWith(moreFansCount: self.moreFansCount)
            
            cell = moreFansCell
            
        } else {
            
            let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.defaultCellReuseId, for: indexPath) as! ActorFansCollectionViewCell
            
            defaultCell.setupWith(image: dataItem.image, imageSize: cellSize)
            
            cell = defaultCell
        }
        
        return cell
    }
    
}

extension ActorsFansView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth:CGFloat = cellSize.width * CGFloat(self.cellsCount)
        let totalSpacingWidth:CGFloat = CGFloat(5 * (self.cellsCount - 1))
        
        let halfParentWidth = collectionView.frame.width / 2
        let contentWidth = totalCellWidth + totalSpacingWidth
        let halfContentWidth = contentWidth / 2
        
        let leftInset = halfParentWidth - halfContentWidth
        
        return UIEdgeInsetsMake(0, leftInset, 0, 0)
    }
}
