//
//  Networking.swift
//  Networking
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

public protocol NetworkingProtocol: class {
    func getItems<T: Decodable>(path: String, params:[String:Any]?, headers:[String:String]?) -> Observable<[T]>
    func getItem<T: Decodable>(path: String, params:[String:Any]?, headers:[String:String]?) -> Observable<T>
    //TODO: add post, put, delete
}

public class Networking: NetworkingProtocol {
    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    public static func buildDefaultNetwork(with endPoint: String) -> NetworkingProtocol {
        return Networking(endPoint: endPoint, scheduler: ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1)))
    }
    
    public init(endPoint: String, scheduler: ConcurrentDispatchQueueScheduler) {
        self.endPoint = endPoint
        self.scheduler = scheduler
    }
    
    public func getItems<T>(path: String, params: [String : Any]?, headers: [String : String]?) -> Observable<[T]> where T : Decodable {
        let absolutePath = "\(endPoint)\(path)"
        return RxAlamofire
            .data(.get, absolutePath, parameters: params, encoding: URLEncoding.default, headers: headers)
            .debug()
            .observeOn(scheduler)
            .map({ data -> [T] in
                return try JSONDecoder().decode([T].self, from: data)
            })
    }
    
    public func getItem<T>(path: String, params: [String : Any]?, headers: [String : String]?) -> Observable<T> where T : Decodable {
        let absolutePath = "\(endPoint)\(path)"
        return RxAlamofire
            .data(.get, absolutePath, parameters: params, encoding: URLEncoding.default, headers: headers)
            .debug()
            .observeOn(scheduler)
            .map({ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            })
    }
    
    
}
