//
//  APIRequest.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/8/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import Alamofire
import EVReflection

public protocol APIParamsConvertible {
    var apiParams: Parameters { get }
}

class Request: EVObject, APIParamsConvertible {
    var apiParams: Parameters {
        return self.toDictionary() as! Parameters
    }
    
    override func skipPropertyValue(_ value: Any, key: String) -> Bool {
        return value is NSNull
    }
}
