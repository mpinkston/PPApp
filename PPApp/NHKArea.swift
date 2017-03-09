//
//  NHKArea.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/9/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import RxSwift

class NHKArea: Object, Mappable {
    dynamic var id = 0
    dynamic var name: String? = nil
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
