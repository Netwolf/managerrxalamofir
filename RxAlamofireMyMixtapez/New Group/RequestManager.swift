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

class RequestManager {
    
    private let disposeBag = DisposeBag()
    private var errorManager = ErrorManager()
    
    static let shared = RequestManager()
    
    init() {
        errorManager.delegate = self
    }
    
    func observable(url: String, parameters: [String: AnyObject] = [:], headers: [String: AnyObject] = [:]) -> Observable<Any> {
        return Request.fromPathURL(url).request()
    }
    
    func fetch<T:Mappable>(url: String, parameters: [String: AnyObject] = [:], headers: [String: AnyObject] = [:], schedulerType: SchedulerType = SerialDispatchQueueScheduler.init(qos: .background), scheduler: ImmediateSchedulerType = MainScheduler.instance, retries: Int = 0, object: T.Type) -> Promise<T> {
        return Promise { fullFill, reject in
            observable(url: url, parameters: [:], headers: [:]).subscribeOn(schedulerType).do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = true }).map { json in
                
                guard let json = json as? [AnyObject] else {
                    reject(APIResponseError.init())
                    return
                }
                
                if let unity = Mapper<T>().map(JSONObject: json) {
                    fullFill(unity)
                } else  {
                    reject(APIResponseError())
                }
                
                }
                .observeOn(scheduler).retry(retries).do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = false }).subscribe(onNext: { objectResponse in
                    
                },onError: { error in
                    self.errorManager.handle(error: error)
                    guard let errorApi = error as? APIResponseError else {
                        return
                    }
                    reject(errorApi)
                    
                }).disposed(by: disposeBag)
        }
    }
    
    
    func fetchList<T:Mappable>(url: String, parameters: [String: AnyObject] = [:], headers: [String: AnyObject] = [:], schedulerType: SchedulerType = SerialDispatchQueueScheduler.init(qos: .background), scheduler: ImmediateSchedulerType = MainScheduler.instance, retries: Int = 0, object: T.Type) -> Promise<[T]> {
        return Promise { fullFill, reject in
            observable(url: url, parameters: [:], headers: [:]).subscribeOn(schedulerType).do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = true }).map { json in
                    guard let json = json as? [AnyObject] else {
                        reject(APIResponseError.init())
                        return
                    }
                    if let unities = Mapper<T>().mapArray(JSONObject: json) {
                        fullFill(unities)
                    } else {
                        reject(APIResponseError())
                    }
                
                }.observeOn(scheduler).retry(retries).do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = false }).subscribe(onNext: { objectResponse in
                
            },onError: { error in
                self.errorManager.handle(error: error)
                guard let errorApi = error as? APIResponseError else {
                    return
                }
                reject(errorApi)
                
            }).disposed(by: disposeBag)
        }
    }
    
}


extension RequestManager: ErrorProtocol {
    
    func refreshToken() {
        
    }
    
    func show(error: String) {
        
    }
}

