//
//  ObservableType.swift
//  RxAlamofireMyMixtapez
//
//  Created by HugoSilva on 2/19/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import RxSwift
import RxAlamofire
import ObjectMapper
import PromiseKit

extension ObservableType {
    
    public func mapRequest() -> Observable<String> {
        return map { (arg) -> String in
            if let (response, json) = (arg as? (HTTPURLResponse, Any)) {
                
                if let error = self.checkResponseError(urlResponse: response, json: json) {
                    throw error
                }
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
                    if let string = String(data: data, encoding: String.Encoding.utf8) {
                        print(string)
                        return string
                    }
                } catch {
                    throw error
                }
                
            }
            throw APIResponseError()
        }
    }
    
    func retryWithAuthIfNeeded() -> Observable<E> {
        
        return retryWhen { (e: Observable<Error>) in
            Observable.zip(e, Observable.range(start: 1, count: 3), resultSelector: { $1 }).flatMap { i in
                return Request.refreshToken().mapRequest().catchError({ (error) -> Observable<String> in
                    return Observable.error(error)

                }).flatMapLatest({ (response) -> Observable<(HTTPURLResponse, Any)> in
                    
                    if  let objectToken = Mapper<RefreshToken>().map(JSONString: response) {
                        Request.saveTokens(tokens: objectToken)
                        return Request.request()
                    }
                    return Observable.error(APIResponseError.init(code: 10, description: "Error ocurred while refreshing token"))

                })
                
            }
        }
    
    }


    func checkResponseError(urlResponse: HTTPURLResponse, json: Any) -> APIResponseError? {
        print(urlResponse.statusCode)
        
        if urlResponse.statusCode >= 400 {
            if let recipe = Mapper<APIResponseError>().map(JSON: json as! [String : Any]) {
                recipe.errorCode = urlResponse.statusCode
                return recipe
            }
        }
        return nil
    }
}

