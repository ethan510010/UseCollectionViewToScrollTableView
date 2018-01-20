//
//  JSONData.swift
//  UIScrollViewWithUITableViewControlledByCollectionView
//
//  Created by EthanLin on 2018/1/11.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct JSONData: Codable{
    
    var success: Bool
    var error_msg: String
    
    var data:[ArticleData]
    
    struct ArticleData: Codable {
        var id: String
        var title: String
        var like_num: String
        var view_num: String
        var favorite_num: String
        var me_too_num: String
        var from_url: String
        var phone: String
        var address: String
        var lat: String
        var lng: String
        var created_at: String
        var thumb: String
        var user_id: String
        var third_party_id: String
        var nickname: String
        var username: String
        var avatar: String
        var fan_num: String
        var follow_num: String
        var statistic_time: String
        var post_num: String
        var avatar_image_url: String
        var like_exist: Int
    }
}
