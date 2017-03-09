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

class NHKProgram: Object, Mappable {
    private let _separator = "||"
    
    dynamic var id = 0
    dynamic var eventId: String? = nil
    dynamic var startTime: Date? = nil
    dynamic var endTime: Date? = nil
    dynamic var area: NHKArea? = nil
    dynamic var service: NHKService? = nil
    dynamic var title: String? = nil
    dynamic var subtitle: String? = nil

    // Used for storage in Realm
    dynamic var _genres: String? = nil
    
    // Arrays
    var genres: [String] {
        get { return _genres?.components(separatedBy: _separator) ?? [] }
        set { _genres = newValue.joined(separator: _separator) }
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func ignoredProperties() -> [String] {
        return ["genres"]
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        eventId <- map["event_id"]
        startTime <- (map["start_time"], API.Transform.stringToDate)
        endTime <- (map["end_time"], API.Transform.stringToDate)
        area <- map["area"]
        service <- map["service"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        genres <- map["genres"]
    }
}
