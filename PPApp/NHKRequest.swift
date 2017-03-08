//
//  NHKRequest.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/8/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import EVReflection

class NHKRequest: Request {
    var area: String!
    var service: String!
    var key: String = "7kv4ymFNJG8k5LH6hUCotjU60cmtLMh5" // <- BAD PRACTICE TO STORE API KEY LIKE THIS!!
    
    /// Only return the key. All other values are passed in the path
    override func skipPropertyValue(_ value: Any, key: String) -> Bool {
        return key != "key"
    }
}

class NHKProgramListRequest: NHKRequest {
    var date: String!
}

class NHKProgramGenreRequest: NHKRequest {
    var genre: String!
    var date: String!
}

class NHKProgramInfoRequest: NHKRequest {
    var id: String!
}

class NHKOnAirRequest: NHKRequest {
}
