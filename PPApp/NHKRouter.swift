//
//  NHKRouter.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/8/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import Alamofire

enum NHKRouter: APIRequestConvertible {
    case programList(NHKProgramListRequest)
    case programGenre(NHKProgramGenreRequest)
    case programInfo(NHKProgramInfoRequest)
    case onAir(NHKOnAirRequest)
    
    var baseUrl: String {
        return "http://api.nhk.or.jp/v2"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .programList(let request):
            return "/pg/list/\(request.area!)/\(request.service!)/\(request.date!).json"
        case .programGenre(let request):
            return "/pg/genre/\(request.area!)/\(request.service!)/\(request.genre!)/\(request.date!).json"
        case .programInfo(let request):
            return "/pg/info/\(request.area!)/\(request.service!)/\(request.id!).json"
        case .onAir(let request):
            return "/pg/now/\(request.area!)/\(request.service!).json"
        }
    }
    
    var keyPath: String {
        switch self {
        case .programList(let request):
            return "list.\(request.service!)"
        case .programGenre(let request):
            return "list.\(request.service!)"
        case .programInfo(let request):
            return "list.\(request.service!)"
        case .onAir(let request):
            return "nowonair_list.\(request.service!)"
        }
    }
    
    var description: String {
        switch self {
        case .programList: return "NHKRouter.programList"
        case .programGenre: return "NHKRouter.programGenre"
        case .programInfo: return "NHKRouter.programInfo"
        case .onAir: return "NHKRouter.onAir"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlRequest = Router.createURLRequest(router: self)
        
        switch self {
        case .programList(let request):
            return try URLEncoding.default.encode(urlRequest, with: request.apiParams)
        case .programGenre(let request):
            return try URLEncoding.default.encode(urlRequest, with: request.apiParams)
        case .programInfo(let request):
            return try URLEncoding.default.encode(urlRequest, with: request.apiParams)
        case .onAir(let request):
            return try URLEncoding.default.encode(urlRequest, with: request.apiParams)
        }
    }
}
