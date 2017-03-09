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
import ObjectMapper

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

extension API {
    class Transform {
        // Transforms an array of strings to a single 
        static let stringArrayToString: TransformOf<String, [String]> = {
            return TransformOf<String, [String]>(
                fromJSON: { (value: [String]?) -> String? in
                    return ""
                },
                toJSON: { (value: String?) -> [String]? in
                    return []
                }
            )
        }()
        
        // Transform an string in UTC (ISO 8601) format to NSDate
        static let stringToDate: TransformOf<Date, String> = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
            
            return TransformOf<Date, String>(
                fromJSON: { (value: String?) -> Date? in
                    if let dateStr = value {
                        return formatter.date(from: dateStr)
                    }
                    return nil
            },
                toJSON: { (value: Date?) -> String? in
                    if let date = value {
                        return formatter.string(from: date)
                    }
                    return nil
            })
        }()
        
        static let stringToPeriod: TransformOf<Date, String> = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMM"
            
            return TransformOf<Date, String>(
                fromJSON: { (value: String?) -> Date? in
                    if let dateStr = value {
                        return formatter.date(from: dateStr)
                    }
                    return nil
            },
                toJSON: { (value: Date?) -> String? in
                    if let date = value {
                        return formatter.string(from: date)
                    }
                    return nil
            })
        }()
        
        // Transform a string (eg. "1.1") to Float
        static let stringToFloat = TransformOf<Float, String>(
            fromJSON: { Float($0 ?? "0") },
            toJSON: { $0.map { String($0) } })
    }
}
