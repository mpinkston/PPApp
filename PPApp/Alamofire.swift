//
//  Alamofire.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/8/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import AlamofireObjectMapper
import ObjectMapper

import RxSwift
import struct RxSwift.Reactive
import protocol RxSwift.ReactiveCompatible

extension Reactive where Base: SessionManager {
    public func request(_ apiRequest: APIRequestConvertible) -> Observable<DataRequest> {
        return request(urlRequest: apiRequest)
    }
    
    public func responseObject<T: Mappable>(_ apiRequest: APIRequestConvertible, queue: DispatchQueue? = nil) -> Observable<T> {
        return request(apiRequest).flatMap {$0.rx.responseObject(apiRequest.keyPath, queue: queue)}
    }
    
    public func responseObject<T: Mappable>(_ apiRequest: APIRequestConvertible, queue: DispatchQueue? = nil) -> Observable<(HTTPURLResponse, T)> {
        return request(apiRequest).flatMap {$0.rx.responseObject(apiRequest.keyPath, queue: queue)}
    }
    
    public func responseArray<T: Mappable>(_ apiRequest: APIRequestConvertible, queue: DispatchQueue? = nil) -> Observable<[T]> {
        return request(apiRequest).flatMap {$0.rx.responseArray(apiRequest.keyPath, queue: queue)}
    }
    
    public func responseArray<T: Mappable>(_ apiRequest: APIRequestConvertible, queue: DispatchQueue? = nil) -> Observable<(HTTPURLResponse, [T])> {
        return request(apiRequest).flatMap {$0.rx.responseArray(apiRequest.keyPath, queue: queue)}
    }
}

extension Reactive where Base: DataRequest {
    public func responseObject<T: Mappable>(_ keyPath: String?, queue: DispatchQueue? = nil) -> Observable<T> {
        return responseResult(queue: queue, responseSerializer: DataRequest.ObjectMapperSerializer(keyPath))
    }
    
    public func responseObject<T: Mappable>(_ keyPath: String?, queue: DispatchQueue? = nil) -> Observable<(HTTPURLResponse, T)> {
        return responseResult(queue: queue, responseSerializer: DataRequest.ObjectMapperSerializer(keyPath))
    }
    
    public func responseArray<T: Mappable>(_ keyPath: String?, queue: DispatchQueue? = nil) -> Observable<[T]> {
        return responseResult(queue: queue, responseSerializer: DataRequest.ObjectMapperArraySerializer(keyPath))
    }
    
    public func responseArray<T: Mappable>(_ keyPath: String?, queue: DispatchQueue? = nil) -> Observable<(HTTPURLResponse, [T])> {
        return responseResult(queue: queue, responseSerializer: DataRequest.ObjectMapperArraySerializer(keyPath))
    }
    
    /**
     Transform a request into an observable of the response and serialized object.
     
     - parameter queue: The dispatch queue to use.
     - parameter responseSerializer: The the serializer.
     - returns: The observable of `(NSHTTPURLResponse, T.SerializedObject)` for the created download request.
     */
    public func responseResult<T: DataResponseSerializerProtocol>(queue: DispatchQueue? = nil, responseSerializer: T)
        -> Observable<(T.SerializedObject)>
    {
        return Observable.create { observer in
            let dataRequest = self.base
                .validate({ (request, response, data) -> Alamofire.Request.ValidationResult in
                    // Only check for known error codes
//                    guard [400, 401, 403].contains(response.statusCode) else { return .success }
//                    guard let data = data else { return .success }
//                    if let json = try? JSONSerialization.jsonObject(with: data) {
//                        if let message = (json as AnyObject?)?.value(forKeyPath: "message") as? String {
//                            // put custom error checking here.
//                        }
//                    }
                    return .success
                })
                .validate()
                .validate(contentType: ["application/json"])
                .response(queue: queue, responseSerializer: responseSerializer) { (packedResponse) -> Void in
                    switch packedResponse.result {
                    case .success(let result):
                        if packedResponse.response != nil {
                            observer.on(.next(result))
                        } else {
                            observer.on(.error(RxAlamofireUnknownError))
                        }
                        observer.on(.completed)
                    case .failure(let error):
                        // Custom error checking can go here too
                        observer.on(.error(error as Error))
                    }
            }
            return Disposables.create {
                dataRequest.cancel()
            }
        }
    }
}
