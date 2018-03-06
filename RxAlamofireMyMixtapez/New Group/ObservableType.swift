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
                        return string
                    }
                } catch {
                    throw error
                }
                
            }
            throw APIResponseError()
        }
    }
    
    func checkResponseError(urlResponse: HTTPURLResponse, json: Any) -> APIResponseError? {

        if urlResponse.statusCode > 400 {
            if let recipe =  Mapper<APIResponseError>().map(JSON: json as! [String : Any]) {
                return recipe
            }
        }
        return nil
    }
    
}

