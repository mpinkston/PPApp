//
//  Program.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/8/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import RxSwift

// Example response object
//{
//    "id" : "2017030830240",
//    "event_id" : "30240",
//    "start_time" : "2017-03-08T04:11:00+09:00",
//    "end_time" : "2017-03-08T04:15:00+09:00",
//    "area":{
//        "id" : "130",
//        "name" : "東京"
//        },
//    "service":{
//        "id" : "g1",
//        "name" : "ＮＨＫ総合１",
//        "logo_s":{
//            "url" : "//www.nhk.or.jp/common/img/media/gtv-100x50.png",
//            "width" : "100",
//            "height" : "50"
//            },
//        "logo_m":{
//            "url" : "//www.nhk.or.jp/common/img/media/gtv-200x100.png",
//            "width" : "200",
//            "height" : "100"
//            },
//        "logo_l":{
//            "url" : "//www.nhk.or.jp/common/img/media/gtv-200x200.png",
//            "width" : "200",
//            "height" : "200"
//            }
//        },
//    "title" : "ＮＨＫプレマップ「ＮＨＫスクープＢＯＸに投稿を」",
//    "subtitle" : "",
//    "content" : "",
//    "act" : "",
//    "genres":[
//    "0207"
//    ]
//},

class NHKProgram: Object, Mappable {
    dynamic var id = 0
    dynamic var title: String? = nil
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
    }
}
