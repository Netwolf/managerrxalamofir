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

protocol ResultProtocol {
    associatedtype T
    associatedtype U
    func success(_: T)
    func error(_: U)
}

struct RequestManager {
    
    fileprivate static let disposeBag = DisposeBag()

    static func getRequest<T:Mappable>(url: String, schedulerType: SchedulerType = SerialDispatchQueueScheduler.init(qos: .default), scheduler: ImmediateSchedulerType = MainScheduler.instance, object: T.Type, onSuccess: @escaping (T) -> Void, onError: @escaping (APIResponseError)  -> Void) {
        
        Request.fromPathURL(url).requestNew().subscribeOn(schedulerType).observeOn(scheduler)
            .mapRequest().subscribe(onNext: { objectResponse in
        
                if let unity = Mapper<T>().map(JSONString: objectResponse) {
                    onSuccess(unity)
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


