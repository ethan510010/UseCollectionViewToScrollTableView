//
//  SecondViewController.swift
//  UIScrollViewWithUITableViewControlledByCollectionView
//
//  Created by EthanLin on 2018/1/10.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var sports = ["baseball","basketball","soccer"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //調整section的高度，背景色預設是灰色
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
            return CGFloat(10)
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nearbyCell = tableView.dequeueReusableCell(withIdentifier: "nearbyCell", for: indexPath)
        nearbyCell.textLabel?.text = sports[indexPath.row]
        return nearbyCell
    }
    

    @IBOutlet weak var secondTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondTableView.delegate = self
        secondTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
