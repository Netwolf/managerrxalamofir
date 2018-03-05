//
//  RequestManager.swift
//  RxAlamofireMyMixtapez
//
//  Created by Fabricio Oliveira on 2/28/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import Foundation
import Foundation
import ObjectMapper
import RxSwift
import Alamofire
import RxAlamofire
import PromiseKit

enum Result<T, U> where U: APIResponseError  {
    case success(T)
    case error(U)
}

class ResponseRequest<T> {
    var object: T?
    var listOfObjects: [T]?
    
    init(object: T) {
        self.object = object
    }
    
    init(listOfObjects: [T]) {
        self.listOfObjects = listOfObjects
    }
}


class RequestManager {
    
    private let disposeBag = DisposeBag()
    private var errorManager = ErrorManager()
    
    static let shared = RequestManager()
    
    init() {
        errorManager.delegate = self
    }
    
     func fetch<T:Mappable>(url: String, schedulerType: SchedulerType = SerialDispatchQueueScheduler.init(qos: .default), scheduler: ImmediateSchedulerType = MainScheduler.instance, object: T.Type) -> Promise<ResponseRequest<T>> {
        
        return Promise { fullFill, reject in
            Request.fromPathURL(url).requestNew().subscribeOn(schedulerType).do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = true }).observeOn(scheduler)
                .mapRequest().retry(3).do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = false }).subscribe(onNext: { objectResponse in
                    
                    if let unity = Mapper<T>().map(JSONString: objectResponse) {
                        fullFill(ResponseRequest(object: unity))
                    } else if let unities = Mapper<T>().mapArray(JSONString: objectResponse) {
                        fullFill(ResponseRequest(listOfObjects: unities))
                    } else  {
                        reject(APIResponseError())
                    }
                
                },onError: { error in
                    self.errorManager.handle(error: error)
                    guard let errorApi = error as? APIResponseError else {
                        return
                    }
                    reject(errorApi)
                    
                }).disposed(by: disposeBag)
        }
        
    }
    
    func fetcheObject<T:Mappable>(url: String, schedulerType: SchedulerType = SerialDispatchQueueScheduler.init(qos: .default), scheduler: ImmediateSchedulerType = MainScheduler.instance, object: T.Type, onSuccess: @escaping (T) -> Void, onError: @escaping (APIResponseError)  -> Void) {
        
        Request.fromPathURL(url).requestNew().subscribeOn(schedulerType).do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = true }).observeOn(scheduler)
            .mapRequest().do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = false }).subscribe(onNext: { objectResponse in
        
                
                if let unity = Mapper<T>().map(JSONString: objectResponse) {
                    onSuccess(unity)
                } else {
                    onError(APIResponseError.init())
                }
                
                if let unities = Mapper<T>().mapArray(JSONString: objectResponse) {
                    onSuccess(unities.first!)
                }
                
                
            },onError: { error in
                
                guard let errorApi = error as? APIResponseError else {
                    return
                }
                if errorApi.error_code == 401 {
                    onError(errorApi)
                } else {
                    onError(errorApi)
                }
            }).disposed(by: disposeBag)
    }
    
    func fetcheListOfObject<T:Mappable>(url: String, schedulerType: SchedulerType = SerialDispatchQueueScheduler.init(qos: .default), scheduler: ImmediateSchedulerType = MainScheduler.instance, object: T.Type, onSuccess: @escaping ([T]) -> Void, onError: @escaping (APIResponseError)  -> Void) {
        
        Request.fromPathURL(url).requestNew().subscribeOn(schedulerType).do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = true }).observeOn(scheduler)
            .mapRequest().do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = false }).subscribe(onNext: { objectResponse in
            
                
                if let unities = Mapper<T>().mapArray(JSONString: objectResponse) {
                    onSuccess(unities)
                } else {
                    onError(APIResponseError.init())
                }
                
                
            },onError: { error in
                
                guard let errorApi = error as? APIResponseError else {
                    return
                }
                if errorApi.error_code == 401 {
                    onError(errorApi)
                } else {
                    onError(errorApi)
                }
            }).disposed(by: disposeBag)
    }

    
}


extension RequestManager: ErrorProtocol {
    func refreshToken() {
        
    }
    
    func show(error: String) {
        
    }
}

