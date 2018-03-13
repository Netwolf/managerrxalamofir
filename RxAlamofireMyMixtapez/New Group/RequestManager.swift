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
    
    func observable(url: String, method: Method = .GET ,parameters: [String: AnyObject] = [:], headers: [String: AnyObject] = [:]) -> Observable<(HTTPURLResponse, Any)> {
        return Request.fromPathURL(url).method(method).header(headers as! [String : String]).queryParameters(parameters).request()
    }

    func fetch<T:Mappable>(url: String, method: Method = .GET, parameters: [String: AnyObject] = [:], headers: [String: AnyObject] = [:], schedulerType: SchedulerType = SerialDispatchQueueScheduler.init(qos: .background), scheduler: ImmediateSchedulerType = MainScheduler.instance, retries: Int = 1, object: T.Type) -> Promise<String> {
        
        return Promise { fullFill, reject in
            observable(url: url, method: method ,parameters: parameters, headers: headers)
                .subscribeOn(schedulerType)
                .do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = true })
                .mapRequest()
                .observeOn(scheduler)
                .retry(retries)
                .do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = false })
                .subscribe(onNext: { objectResponse in
                    fullFill(objectResponse)
                },onError: { error in
                    let error = self.errorManager.handle(error: error)
                    if error.errorCode == 401 {
                        self.refreshTokenFetch(url: url, parameters: parameters, headers: headers as! [String : String]).then { response -> Void in
                            fullFill(response)
                            }.catch { error in
                                reject(self.errorManager.handle(error: error))
                        }
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    func refreshTokenFetch(url: String, method: Method = .GET, parameters: [String: AnyObject] = [:], headers: [String: String] = [:]) -> Promise<String> {
        
        return Promise { fullFill, reject in
            
            let refreshParams = ["grant_type": "refresh_token", "refresh_token": "\(Request.Token.RefreshToken)"]
            
            Request.fromPathURL("/oauth/token").method(.POST).headerToken([:]).queryParameters(refreshParams as [String : AnyObject]).request()
                .subscribeOn(SerialDispatchQueueScheduler.init(qos: .background))
                .do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = true })
                .mapRequest().observeOn(MainScheduler.instance)
                .do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = false })
                .subscribe(onNext: { objectResponse in
                    
                    print("Response: \(objectResponse)")
                    if  let objectToken =  Mapper<RefreshToken>().map(JSONString: objectResponse) {
                        Request.saveTokens(tokens: objectToken)
                    }
                    
                    self.observable(url: url, method: method, parameters: parameters, headers: headers as [String : AnyObject])
                        .subscribeOn(SerialDispatchQueueScheduler.init(qos: .background))
                        .do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = true })
                        .mapRequest()
                        .observeOn(MainScheduler.instance)
                        .do(onNext: { _ in UIApplication.shared.isNetworkActivityIndicatorVisible = false })
                        .subscribe(onNext: { objectResponse in
                            fullFill(objectResponse)
                        },onError: { error in
                            print("error refresh: \(error)")
                            reject(self.errorManager.handle(error: error))
                        }).disposed(by: self.disposeBag)
                    
                },onError: { error in
                    print("error: \(error)")

                }).disposed(by: disposeBag)
            
        }
        
    }
    
}


extension RequestManager: ErrorProtocol {

    func show(error: String) {
        
    }
}

