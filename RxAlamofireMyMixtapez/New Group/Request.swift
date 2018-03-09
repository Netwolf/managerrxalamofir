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




enum Method: String {
    case GET, POST, PUT, PATCH, DELETE
}

enum UrlEncoding {
    case json
    case url
}

class Request {
    
    public static let sharedManager: Alamofire.SessionManager = {
        
        let certificates = ServerTrustPolicy.certificates(in: Bundle.main)
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "api.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            "api-sandbox.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            "search.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            "hits.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            "image.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            
            "video.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            
            "music.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            
            "stream.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            )
            
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        
        return Alamofire.SessionManager(configuration: configuration)
        //return Alamofire.SessionManager(
           // configuration: configuration,
           // serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        //)
        
        
    }()
    
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
    
    
    public static func request() -> Observable<(HTTPURLResponse, Any)> {
        
        //headers["Authorization"] = "\(Request.Token.TokenType) \(Request.Token.AccessToken)"
        headers["Authorization"] = "bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MjA2MzE3NTMsInVzZXJfbmFtZSI6IjI5NDI0MjAiLCJhdXRob3JpdGllcyI6WyJST0xFX1VTRVIiXSwianRpIjoiOWNlY2ZlZDctNzdkNS00YzgwLWJkODMtYzU1NWJkZmViM2VhIiwiY2xpZW50X2lkIjoiYW5kcm9pZCIsInNjb3BlIjpbInJlYWQiXX0.foRux0psn2KOOIA7yw3B7n2WWJHhbiznj5VtsEeJ8eEE"
        headers["Content-Type"] = "application/json"
        headers["Accept-Encoding"] = "gzip"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        
        let result = Request.sharedManager
            .rx.responseJSON(method, url, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        return result
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

