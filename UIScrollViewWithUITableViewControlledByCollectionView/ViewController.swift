//
//  ViewController.swift
//  UIScrollViewWithUITableViewControlledByCollectionView
//
//  Created by EthanLin on 2018/1/10.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    //處理ScrollView的部分
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    //實作CollectionView的方法
    var buttonTitleArray = ["最新文章","附近熱門","我的追蹤","一週熱門","部落客排行"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let collectionViewButtonCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewButtonCell", for: indexPath) as! ButtonCollectionViewCell
        collectionViewButtonCell.labelToCoverCollectionViewCellButton.text = buttonTitleArray[indexPath.row]
        
        //小心不要漏掉這兩行，很重要
        //把collectionView我們自己定義的protocol方法中的index存成官方collectionView的indexPath
        collectionViewButtonCell.index = indexPath
        //設定collectiobViewCell的delegate為viewController
        collectionViewButtonCell.collectionViewDelegate = self
        
        return collectionViewButtonCell
    }
    
 
 
    
    
    
    //處理CollectionView的排版
    
    @IBOutlet weak var myCollectionViewLayout: UICollectionViewFlowLayout!
    

    @IBOutlet weak var collectionButtonView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = mainStoryboard.instantiateViewController(withIdentifier: "firstTableView") as! FirstViewController
        self.addChildViewController(firstViewController)
        self.myScrollView.addSubview(firstViewController.view)
        firstViewController.didMove(toParentViewController: self)
        //
        let secondViewController = mainStoryboard.instantiateViewController(withIdentifier: "secondTableView") as! SecondViewController
        self.addChildViewController(secondViewController)
        self.myScrollView.addSubview(secondViewController.view)
        secondViewController.didMove(toParentViewController: self)
        
        var frame2ForSecondViewController = secondViewController.view.frame
        frame2ForSecondViewController.origin.x = self.view.frame.size.width
        secondViewController.view.frame = frame2ForSecondViewController
        
        
        //
        myScrollView.delegate = self
    
        myScrollView.contentSize = CGSize(width: self.view.frame.width * 2, height: self.view.frame.height)
        
        //
        collectionButtonView.delegate = self
        collectionButtonView.dataSource = self
        collectionButtonView.backgroundColor = .gray
        myCollectionViewLayout.itemSize.width = (UIScreen.main.bounds.size.width) / 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//處理collectionViewButton的點擊事件（自定義）protocol
extension ViewController:CollectionViewButtonDelegate{
    func buttonInCollectionViewDidTapped(index: IndexPath) {
        switch index.item {
        case 0:
            myScrollView.setContentOffset(CGPoint(x: 0,y:0), animated: true)
        default:
            myScrollView.setContentOffset(CGPoint(x: self.view.frame.width,y: 0), animated: true)
        }
    }
    
    
}

