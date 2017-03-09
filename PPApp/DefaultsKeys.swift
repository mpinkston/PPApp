//
//  DefaultsKeys.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/9/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    // Authentication
    static let authUserId = DefaultsKey<Int?>("authUserId")
    
    // API token
    static let secretToken = DefaultsKey<String?>("secretToken")
}
