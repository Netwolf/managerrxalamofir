//
//  Request.swift
//  RxAlamofireMyMixtapez
//
//  Created by HugoSilva on 2/15/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import UIKit

import RxSwift
import Alamofire
import RxAlamofire
import ObjectMapper

enum ObjectResponse {
    case onSuccess(String)
    case onError(APIResponseError)
}

enum Method: String {
    case GET, POST, PUT, PATCH, DELETE
}

enum UrlEncoding {
    case json
    case url
}

class Request {
    
    fileprivate static var baseURL: String = "https://api.mymixtapez.com"
    fileprivate static var url: String = baseURL
    fileprivate static var method: Alamofire.HTTPMethod = .get
    fileprivate static var parameters: [String: AnyObject] = [:]
    fileprivate static var headers: [String: String] = [:]
    fileprivate static var encoding: ParameterEncoding = URLEncoding.default
    fileprivate static let disposeBag = DisposeBag()
    
    public static func method(_ method: Method) -> Request.Type {
        self.method = HTTPMethod(rawValue: method.rawValue)!
        return self
    }
    
    public static func queryParameters(_ parameters: [String: AnyObject]) -> Request.Type {
        self.parameters = parameters
        return self
    }
    
    
    public static func header(_ headers: [String: String]) -> Request.Type {
        self.headers = headers
        return self
    }
    
    
    public static func encodParameters(_ encoding: UrlEncoding) -> Request.Type {
        self.encoding = encoding == .json ? JSONEncoding.default : URLEncoding.default
        return self
    }
    
    
    public static func requestNew() -> Observable<(HTTPURLResponse, Any)> {
        
        //headers["Authorization"] = "\(Request.Token.TokenType) \(Request.Token.AccessToken)"
        headers["Authorization"] = "bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MjAwMDA5MDMsInVzZXJfbmFtZSI6IjAiLCJhdXRob3JpdGllcyI6WyJST0xFX0dVRVNUIl0sImp0aSI6ImJjM2I0ZWY3LTlhMjUtNDA1MS1iOWRkLTc0NWU1MWI0NjY5NSIsImNsaWVudF9pZCI6ImlvcyIsInNjb3BlIjpbInJlYWQiXX0.wlbxH_bh9kONXNc8jCWtpg2NFgNVRDbwMrRT44LCRiw"
        headers["Content-Type"] = "application/json"
        headers["Accept-Encoding"] = "gzip"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        let result = SessionManager(configuration: configuration)
            .rx.responseJSON(method,
                             self.url,
                             parameters: self.parameters,
                             encoding: URLEncoding.default,
                             headers: headers)
        
        return result
    }
    
    
    public static func request(callback: @escaping (ObjectResponse) -> Void) {
        
        headers["Authorization"] = "\(Request.Token.TokenType) \(Request.Token.AccessToken)"
        headers["Content-Type"] = "application/json"
        headers["Accept-Encoding"] = "gzip"
    
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        _ = SessionManager(configuration: configuration)
            .rx.responseJSON(method,
                             self.url,
                             parameters: self.parameters,
                             encoding: URLEncoding.default,
                             headers: headers)
            .subscribeOn(SerialDispatchQueueScheduler.init(qos: .background))
            .mapRequest()
            .subscribe(onNext: { objectResponse in
                callback(ObjectResponse.onSuccess(objectResponse))
            },onError: { error in
                callback(ObjectResponse.onError(error as! APIResponseError))
            }).disposed(by: disposeBag)
        
    }
    
    public static func refresh(callback: @escaping (ObjectResponse) -> Void) {
        
        let urlRefreshToken = baseURL + "/oauth/token"
        
        if let url = URL(string: urlRefreshToken) {
            
            let refreshParams = ["grant_type": "refresh_token", "refresh_token": Request.Token.RefreshToken]
            
            var headers:[String:String] = [String:String]()
            headers["Authorization"] = "Basic aW9zOlNEYTVnU3VXZmdoNlFVVXU="
            headers["Accept-Encoding"] = "gzip"
            
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
            
            _ = SessionManager(configuration: configuration)
                .rx.responseJSON(.post,
                                 url,
                                 parameters: refreshParams,
                                 encoding: URLEncoding.default,
                                 headers: headers)
                .subscribeOn(SerialDispatchQueueScheduler.init(qos: .background))
                .mapRequest()
                .subscribe(onNext: { objectResponse in
                    callback(ObjectResponse.onSuccess(objectResponse))
                },onError: { error in
                    callback(ObjectResponse.onError(error as! APIResponseError))
                }).disposed(by: disposeBag)
            
        }
        
    }
    
    
}

typealias RequestURL = Request
extension RequestURL {
    
    public static func fromPathURL(_ path: String) -> Request.Type {
        self.url = baseURL + path
        return self
    }
    
    public static func fromFullURL(_ url: String) -> Request.Type {
        self.url = url
        return self
    }
    
}

