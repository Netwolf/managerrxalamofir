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
        self.headers["Authorization"] = "Basic aW9zOlNEYTVnU3VXZmdoNlFVVXU="
        self.headers["Accept-Encoding"] = "gzip"
        return self
    }
    
    public static func encodParameters(_ encoding: UrlEncoding) -> Request.Type {
        self.encoding = encoding == .json ? JSONEncoding.default : URLEncoding.default
        return self
    }
    
    public static func request() -> Observable<(HTTPURLResponse, Any)> {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        let result = Request.sharedManager
            .rx.responseJSON(method, url, parameters: parameters, encoding: encoding, headers: headers)
        
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

