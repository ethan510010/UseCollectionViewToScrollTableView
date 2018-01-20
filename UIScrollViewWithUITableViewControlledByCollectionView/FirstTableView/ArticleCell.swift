//
//  ArticleCell.swift
//  UIScrollViewWithUITableViewControlledByCollectionView
//
//  Created by EthanLin on 2018/1/11.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

protocol buttonDidTapped {
    func buttonDidTapped(index:IndexPath)
}

class ArticleCell: UITableViewCell {
    
    var index: IndexPath?
    
    var delegateForFirstTableViewCell: buttonDidTapped?
    
    @IBOutlet weak var authorImage: UIImageView!
    
    
    @IBOutlet weak var authorName: UILabel!
    
    
    @IBOutlet weak var countTimeLabel: UILabel!
    
    
    @IBOutlet weak var articleImage: UIImageView!
    
    
    @IBOutlet weak var articleTopicLabel: UILabel!
    
    
    @IBOutlet weak var viewNumberLabel: UILabel!
    
    @IBOutlet weak var likeNumberLabel: UILabel!
    

    @IBAction func likeButton(_ sender: UIButton) {
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
    }
    
    @IBAction func moreButton(_ sender: UIButton) {
    }
    
    @IBAction func bigButtonDidTap(_ sender: UIButton) {
        delegateForFirstTableViewCell?.buttonDidTapped(index: index!)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        authorImage.contentMode = .scaleAspectFill
        
        // 讓圖形變元框
        authorImage.layer.masksToBounds = true
        authorImage.layer.cornerRadius = authorImage.frame.width/2
        //設定圖片匡邊界
        authorImage.layer.borderWidth = 1.5
        authorImage.layer.borderColor = UIColor.init(red: 255/255, green: 204/255, blue: 0, alpha: 1).cgColor
        
    }
    
  
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
