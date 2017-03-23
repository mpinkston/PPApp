//
//  User.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/23/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var kana: String = ""
    
    dynamic var image1: String? = nil
    dynamic var image2: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

