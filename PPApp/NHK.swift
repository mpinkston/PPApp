//
//  NHK.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/8/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import RxSwift

extension API {
    class NHK {        
        static func programList(request: NHKProgramListRequest) -> Observable<[NHKProgram]> {
            return API.manager.rx.responseArray(NHKRouter.programList(request))
        }
        
        static func programGenre(request: NHKProgramGenreRequest) -> Observable<[NHKProgram]> {
            return API.manager.rx.responseArray(NHKRouter.programGenre(request))
        }
        
        static func programInfo(request: NHKProgramInfoRequest) -> Observable<NHKDescription?> {
            let apiRequest = NHKRouter.programInfo(request)
            
            // The API returns an array with a single element, so convert that into an Observable<NHKDescription>
            return API.manager.rx.request(apiRequest).flatMap { (dataRequest) -> Observable<[NHKDescription]> in
                return dataRequest.rx.responseArray(apiRequest.keyPath)
            }.flatMap({Observable.just($0.first)})
        }
        
        static func onAir(request: NHKOnAirRequest) -> Observable<[NHKProgram]> {
            return API.manager.rx.responseArray(NHKRouter.onAir(request))
        }
    }
}
