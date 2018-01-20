//
//  ViewController.swift
//  UIScrollViewWithUITableViewControlledByCollectionView
//
//  Created by EthanLin on 2018/1/10.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UISearchBarDelegate {

    
    
    
    
    //用來看是否被點到的array
    var didSelectArray = [Bool]()
    
    var pageNum:Int = 0
    var currentViewNumber:Int = 0
    
    //處理ScrollView的部分
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    //實作CollectionView的方法
    var buttonTitleArray = ["最新文章","附近熱門","我的追蹤","一週熱門","部落客排行"]
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewButtonCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewButtonCell", for: indexPath) as! ButtonCollectionViewCell
        collectionViewButtonCell.labelToCoverCollectionViewCellButton.text = buttonTitleArray[indexPath.item]
        

        
        //小心不要漏掉這兩行，很重要
        //把collectionView我們自己定義的protocol方法中的index存成官方collectionView的indexPath
        //        collectionViewButtonCell.index = indexPath
        //        //設定collectiobViewCell的delegate為viewController
        //        collectionViewButtonCell.collectionViewDelegate = self
        
        //處理點選到的時候Cell要顯示的外觀
        if didSelectArray == []{
            //第0項為true
            didSelectArray.append(true)
            print(didSelectArray)
            //其他項為false
            for _ in 1...buttonTitleArray.count-1 {
                didSelectArray.append(false)
            }
        }

        if didSelectArray[indexPath.item] {
            collectionViewButtonCell.layer.masksToBounds = true
            collectionViewButtonCell.layer.cornerRadius = 30
            collectionViewButtonCell.layer.borderWidth = 1.5
            collectionViewButtonCell.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        } else {
           collectionViewButtonCell.layer.borderColor = UIColor.clear.cgColor
        }
        
        
        return collectionViewButtonCell
    }
    
    // 判斷點到哪個CollectionViewItem
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        for i in 0...boolingArray.count-1{
//            boolingArray[i] = false
//        }
//        boolingArray[indexPath.item] = true
//        print(boolingArray)
//        collectionButtonView.reloadData()
//
        //先把陣列裡面的都清空
        for i in 0...(didSelectArray.count-1){
            didSelectArray[i] = false
        }
        //點到的變成true
        didSelectArray[indexPath.item] = true
        print(didSelectArray)
        collectionButtonView.reloadData()
        //點選到的時候要換scrollView
        pageNum = indexPath.item
        
        myScrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(pageNum), y: 0) , animated: true)
        
//        switch indexPath.item {
//        case 0:
//            myScrollView.setContentOffset(CGPoint(x: 0,y:0), animated: true)
//        case 1:
//            myScrollView.setContentOffset(CGPoint(x: self.view.frame.width,y: 0), animated: true)
//        default:
//            myScrollView.setContentOffset(CGPoint(x: self.view.frame.width*2,y: 0), animated: true)
//        }
    }
    
    //從有點選到沒點選要清除顏色
    //    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    //        let cellToDeselect = collectionButtonView.cellForItem(at: indexPath)
    //        cellToDeselect?.layer.masksToBounds = true
    //        cellToDeselect?.layer.borderColor = UIColor.clear.cgColor
    //
    //    }
    
    
    
    
    
    //collectionView的排版class flowLayout
    @IBOutlet weak var myCollectionViewLayout: UICollectionViewFlowLayout!
    
    
    @IBOutlet weak var collectionButtonView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //讀取到mainStoryboard的FirstViewController
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = mainStoryboard.instantiateViewController(withIdentifier: "firstTableView") as! FirstViewController
        self.addChildViewController(firstViewController)
        self.myScrollView.addSubview(firstViewController.view)
        firstViewController.didMove(toParentViewController: self)
        //讀取到mainStoryboard的SecondViewController
        let secondViewController = mainStoryboard.instantiateViewController(withIdentifier: "secondTableView") as! SecondViewController
        self.addChildViewController(secondViewController)
        self.myScrollView.addSubview(secondViewController.view)
        secondViewController.didMove(toParentViewController: self)
        //設定SecondViewConTroller的位置及邊框
        var frame2ForSecondViewController = secondViewController.view.frame
        frame2ForSecondViewController.origin.x = self.view.frame.size.width
        secondViewController.view.frame = frame2ForSecondViewController
        
        //讀取到mainStoryboard的ThirdViewController
        let thirdViewController = mainStoryboard.instantiateViewController(withIdentifier: "thirdView") as! ThirdViewController
        self.addChildViewController(thirdViewController)
        self.myScrollView.addSubview(thirdViewController.view)
        thirdViewController.didMove(toParentViewController: self)
        
        //設定ThirdViewController的View的位置及邊框
        var frame3ForThirdViewController = thirdViewController.view.frame
        frame3ForThirdViewController.origin.x = self.view.frame.size.width * 2
        thirdViewController.view.frame = frame3ForThirdViewController
        
        
        //設定ViewController為scrollView的delegate，以及contentSize
        myScrollView.delegate = self
        
        myScrollView.contentSize = CGSize(width: self.view.frame.width * 5, height: self.view.frame.height)
        
        //設定collectionView的delegate及一些排版
        collectionButtonView.delegate = self
        collectionButtonView.dataSource = self
        collectionButtonView.backgroundColor = UIColor.init(red: 225/255, green: 227/255, blue: 232/255, alpha: 1)
        myCollectionViewLayout.itemSize.width = (UIScreen.main.bounds.size.width) / 3
        
        //加上searchBar
        createSearchBar()
        
        
        
    }
    
            func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
                
                
//                for i in 0...buttonTitleArray.count-1{
    //                collectionView(collectionButtonView, didDeselectItemAt: [0,i])
    //            }
//                let currentViewNumber = Int(round(myScrollView.contentOffset.x / myScrollView.frame.size.width))
                
                currentViewNumber = Int(round(myScrollView.contentOffset.x / myScrollView.frame.size.width))
                //讓下面滑動時上面跟著移動，但是要讓collectionView跟ScrollView是分開控制
                if pageNum != currentViewNumber{
                    collectionView(collectionButtonView, didSelectItemAt: [0, Int(currentViewNumber)])
                    collectionButtonView.scrollToItem(at: [0,Int()], at: .left, animated: true)
                   
                }
                
            }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //在navigationBar上面加上SearchBar
    func createSearchBar(){
        let searchBar = UISearchBar()
        
        searchBar.showsCancelButton = false
        searchBar.placeholder = "搜尋"
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor.init(red: 244/255, green: 220/255, blue: 66/255, alpha: 1)
        self.navigationItem.titleView = searchBar
       
//        searchController.searchBar.placeholder = "搜尋"
//        searchController.searchBar.delegate = self
    }
    
    
}

//處理collectionViewButton的點擊事件（自定義）protocol
//extension ViewController:CollectionViewButtonDelegate{
//    func buttonInCollectionViewDidTapped(index: IndexPath) {
//        switch index.item {
//        case 0:
//            myScrollView.setContentOffset(CGPoint(x: 0,y:0), animated: true)
//        default:
//            myScrollView.setContentOffset(CGPoint(x: self.view.frame.width,y: 0), animated: true)
//        }
//    }
//
//
//}

