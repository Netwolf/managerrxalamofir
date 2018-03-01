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

enum Result<T, U> where U: APIResponseError  {
    case success(T)
    case error(U)
}


struct RequestManager {
    
    fileprivate static let disposeBag = DisposeBag()

    static func fetcheObject<T:Mappable>(url: String, schedulerType: SchedulerType = SerialDispatchQueueScheduler.init(qos: .default), scheduler: ImmediateSchedulerType = MainScheduler.instance, object: T.Type, onSuccess: @escaping (T) -> Void, onError: @escaping (APIResponseError)  -> Void) {
        
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
    
    static func fetcheListOfObject<T:Mappable>(url: String, schedulerType: SchedulerType = SerialDispatchQueueScheduler.init(qos: .default), scheduler: ImmediateSchedulerType = MainScheduler.instance, object: T.Type, onSuccess: @escaping ([T]) -> Void, onError: @escaping (APIResponseError)  -> Void) {
        
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



