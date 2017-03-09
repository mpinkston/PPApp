//
//  Service.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/9/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class NHKService: Object, Mappable {
    dynamic var id: String = ""
    dynamic var name: String? = nil
    dynamic var logoSmall: String = ""
    dynamic var logoMedium: String = ""
    dynamic var logoLarge: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        logoSmall <- map["logo_s.url"]
        logoMedium <- map["logo_m.url"]
        logoLarge <- map["logo_l.url"]
    }
}
