//
//  FirstViewController.swift
//  UIScrollViewWithUITableViewControlledByCollectionView
//
//  Created by EthanLin on 2018/1/10.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, buttonDidTapped{
    
    //跳轉並傳值到WebView
    func buttonDidTapped(index: IndexPath) {
        performSegue(withIdentifier: "turnToWebView", sender: dataFromAPI?.data[index.row].from_url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "turnToWebView"{
            if let webViewController = segue.destination as? WebViewController{
                if let webAddress = sender as? String{
                    webViewController.webAddressFromViewOne = webAddress
                }
            }
        }
    }
    
    var dataFromAPI: JSONData?
    
    var articleUrl = "https://triper.darkwing.co/api.php/story/get_story_list/token/5E7aQ3Wpmd9ZkU22/category/all/order/hot/user_id/-1/page/1"
    
    var page = 1
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = dataFromAPI?.data.count{
            return numberOfRows
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleCell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        articleCell.articleTopicLabel.text = dataFromAPI?.data[indexPath.row].title
        if let viewNumber = dataFromAPI?.data[indexPath.row].view_num{
            articleCell.viewNumberLabel.text = "瀏覽\(viewNumber),"
        }
        if let likeNumber = dataFromAPI?.data[indexPath.row].me_too_num{
            articleCell.likeNumberLabel.text = "喜歡\(likeNumber)"
        }
        if let authorName = dataFromAPI?.data[indexPath.row].nickname{
            articleCell.authorName.text = authorName
        }

        //把Cell裡面的index存成這邊的indexPath
        //以及設定代理
        articleCell.index = indexPath
        articleCell.delegateForFirstTableViewCell = self
        //作者大頭貼的設定
        if let authorImageIRL = dataFromAPI?.data[indexPath.row].avatar_image_url{
            if let authorPicture = URL(string: authorImageIRL){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: authorPicture)
                    if let downloadedImageData = data{
                        let downloadedImage = UIImage(data: downloadedImageData)
                        DispatchQueue.main.async {
                            articleCell.authorImage.image = downloadedImage
                        }
                    }
                }
            }
        }
        return articleCell
    }
    
    //設定tableView的列高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    
    
    @IBOutlet weak var firstTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTableView.delegate = self
        firstTableView.dataSource = self
        downloadArticles(url: articleUrl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //設定一個下載與解析JSON的方法
    func downloadArticles(url:String){
        if let url = URL(string: url){
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error!.localizedDescription)
                }
                if let downloadedData = data{
                    do{
                        let decoder = JSONDecoder()
                        let articleData = try decoder.decode(JSONData.self, from: downloadedData)
                        print(articleData.data.count)
                        if self.dataFromAPI == nil  {
                            self.dataFromAPI = articleData
                            
                        } else {
                            self.dataFromAPI?.data.append(contentsOf: articleData.data)
                            
                        }
                        DispatchQueue.main.async {
                            self.firstTableView.reloadData()
                        }
                    }catch{
                        print("JSON error")
                    }
                }
            })
            task.resume()
            
        }
    }
    
    //配合往下拉可以更新JSON的資料
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let numberOfData = dataFromAPI?.data.count{
            if indexPath.row == numberOfData - 1{
                page = page + 1
                downloadArticles(url: "https://triper.darkwing.co/api.php/story/get_story_list/token/5E7aQ3Wpmd9ZkU22/category/all/order/hot/user_id/-1/page/\(page)")
            }
        }
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//    
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


