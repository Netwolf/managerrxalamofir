//
//  Request.swift
//  RxAlamofireMyMixtapez
//
//  Created by HugoSilva on 2/15/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import RxSwift
import Alamofire

enum Method: String {
    case GET, POST, PUT, PATCH, DELETE
}

enum UrlEncoding {
    case json
    case url
}

class Request {

    fileprivate static var baseURL: String = ApiConstants.Config.BaseURL
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
        self.headers["Authorization"] = "\(Request.Token.TokenType) \(Request.Token.AccessToken)"
        self.headers["Content-Type"] = "application/json"
        self.headers["Accept-Encoding"] = "gzip"
        return self
    }
    
    public static func headerToken(_ headers: [String: String]) -> Request.Type {
        self.headers = headers
        self.headers["Authorization"] = "\(ApiConstants.BasicAuthentication.BasicTypeToken) \(ApiConstants.BasicAuthentication.BasicAccessToken)"
        self.headers["Accept-Encoding"] = "gzip"
        return self
    }
    
    public static func encodParameters(_ encoding: UrlEncoding) -> Request.Type {
        self.encoding = encoding == .json ? JSONEncoding.default : URLEncoding.default
        return self
    }
    
    public static func request() -> Observable<(HTTPURLResponse, Any)> {
        
        headers["Authorization"] = "\(Request.Token.TokenType) \(Request.Token.AccessToken)"
        headers["Content-Type"] = "application/json"
        headers["Accept-Encoding"] = "gzip"
        

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        let result = Request.sharedManager
            .rx.responseJSON(method, url, parameters: parameters, encoding: encoding, headers: headers)
        
        return result
        
    }
    
    public static func refreshToken() -> Observable<(HTTPURLResponse, Any)> {
        
        
        let urlRefresh = baseURL + "/oauth/token"
        
        let refreshParams = ["grant_type": "refresh_token", "refresh_token": "\(Request.Token.RefreshToken)"]
        
        var headers:[String:String] = [String:String]()
        headers["Authorization"] = "Basic aW9zOlNEYTVnU3VXZmdoNlFVVXU="
        headers["Accept-Encoding"] = "gzip"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        let result = Request.sharedManager
            .rx.responseJSON(.post, urlRefresh, parameters: refreshParams, encoding: URLEncoding.default , headers: headers)
        
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

