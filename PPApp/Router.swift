//
//  Router.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/8/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Alamofire

public protocol APIRequestConvertible: URLRequestConvertible, CustomStringConvertible {
    var baseUrl: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var keyPath: String { get }
}

class Router {
    static func createURLRequest(router: APIRequestConvertible) -> URLRequest {
        let url = try! router.baseUrl.asURL().appendingPathComponent(router.path)
        var request = URLRequest(url: url)
        request.httpMethod = router.method.rawValue
        return request
    }
}
