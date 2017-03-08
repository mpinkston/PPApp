//
//  API.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/8/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Alamofire
import Foundation
import Timberjack

class API {
    static let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        Timberjack.logStyle = .verbose
        configuration.protocolClasses?.insert(Timberjack.self, at: 0)
        
        // API logging
        return SessionManager(configuration: configuration)
    }()
}
