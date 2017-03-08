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
        
        static func programInfo(request: NHKProgramInfoRequest) -> Observable<NHKProgram> {
            return API.manager.rx.responseObject(NHKRouter.programInfo(request))
        }
        
        static func onAir(request: NHKOnAirRequest) -> Observable<[NHKProgram]> {
            return API.manager.rx.responseArray(NHKRouter.onAir(request))
        }
    }
}
