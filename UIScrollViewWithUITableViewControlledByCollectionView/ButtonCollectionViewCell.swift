//
//  ButtonCollectionViewCell.swift
//  UIScrollViewWithUITableViewControlledByCollectionView
//
//  Created by EthanLin on 2018/1/10.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit


protocol CollectionViewButtonDelegate{
    func buttonInCollectionViewDidTapped(index:IndexPath)
}

class ButtonCollectionViewCell: UICollectionViewCell {
    
    
    
    var collectionViewDelegate:CollectionViewButtonDelegate?
    var index:IndexPath?
    
    @IBOutlet weak var collectionViewCellButtonText: UIButton!
    
    @IBOutlet weak var labelToCoverCollectionViewCellButton: UILabel!
    
    @IBAction func collectionViewCellButtonToScrollTableViewBelow(_ sender: UIButton) {
        collectionViewDelegate?.buttonInCollectionViewDidTapped(index: index!)
    }
}
