//
//  AlbumService.swift
//  RxAlamofireMyMixtapez
//
//  Created by Fabricio Oliveira on 2/28/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//


protocol Gettable {
    associatedtype Model
    associatedtype Error where Error == APIResponseError
    func list(completion: @escaping (Result<[Model], Error>) -> Void)
    func unique(completion: @escaping (Result<Model, Error>) -> Void)
    func listNew(url: String) -> Observable<(HTTPURLResponse, Any)>
}

import UIKit
import Foundation
import ObjectMapper
import RxSwift
import Alamofire
import RxAlamofire

struct AlbumService {
    typealias Model = Album
    typealias Error = APIResponseError



func listVeryNew() {
    
    RequestManager.getRequest(url: "/v2/albums/features", object: Album.self, onSuccess: { (object) in
        
    }) { (error) in
        
    }
}


        
}
        
//        RequestManager.getRequest(url: "/v2/albums/features", schedulerType: SerialDispatchQueueScheduler.init(qos: .background) , scheduler: MainScheduler.instance, object: Album.self) {
//            result in
//            switch result {
//            case .success(let sucess):
//                break
//
//
//            case .error(let error):
//                break
//
//            }
        
    
       // }
        
        
//        RequestManager.getRequest(url: "/v2/albums/features", schedulerType: SchedulerType, scheduler: MainScheduler.instance, object: Album)
        
//    }
//
//    func unique(completion: @escaping (Result<Model, Error>) -> Void) {
//
//    }
//
//
//
//    func listNew(url: String) -> Observable<(HTTPURLResponse, Any)> {
//        return Request.fromPathURL(url).requestNew()
//    }
//
//
//    func list(completion: @escaping (Result<[Model], Error>) -> Void) {
//        Request
//            .fromPathURL("/v2/albums/features")
//            .request(callback: { callback in
//                switch callback {
//                case .onSuccess(let objectResponse):
//                    guard let models = Mapper<Model>().mapArray(JSONString: objectResponse) else {
//                        return
//                    }
//                    completion(Result.success(models))
//                case .onError(let objectError):
//                break
//
//                }})
//    }
//

    
//}
