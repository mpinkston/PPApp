//
//  NHKDescription.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/9/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import RxSwift

class NHKDescription: Object, Mappable {
    private let _separator = "||"
    
    dynamic var id = 0
    dynamic var eventId: String? = nil
    dynamic var startTime: Date? = nil
    dynamic var endTime: Date? = nil
    dynamic var area: NHKArea? = nil
    dynamic var service: NHKService? = nil
    dynamic var title: String? = nil
    dynamic var subtitle: String? = nil
    dynamic var content: String? = nil
    dynamic var act: String? = nil
    dynamic var programLogo: String? = nil
    dynamic var programUrl: String? = nil
    dynamic var episodeUrl: String? = nil
    
    // Used for storage in Realm
    dynamic var _genres: String? = nil
    dynamic var _hashtags: String? = nil
    
    // Arrays
    var genres: [String] {
        get { return _genres?.components(separatedBy: _separator) ?? [] }
        set { _genres = newValue.joined(separator: _separator) }
    }
    var hashtags: [String] {
        get { return _hashtags?.components(separatedBy: _separator) ?? [] }
        set { _hashtags = newValue.joined(separator: _separator) }
    }
    
    // Extras
    dynamic var ondemandProgram: String? = nil
    dynamic var ondemandEpisode: String? = nil
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["genres", "hashtags"]
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
        content <- map["content"]
        act <- map["act"]
        programLogo <- map["program_logo.url"]
        programUrl <- map["program_url"]
        episodeUrl <- map["episode_url"]
        
        genres <- map["genres"]
        hashtags <- map["hashtags"]
    }
}
