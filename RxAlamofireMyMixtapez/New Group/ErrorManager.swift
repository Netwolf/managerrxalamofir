//
//  ErrorManager.swift
//  RxAlamofireMyMixtapez
//
//  Created by Fabricio Oliveira on 3/5/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//


protocol ErrorProtocol {
    func show(error: String)
}

struct ErrorManager {
    
    var delegate: ErrorProtocol?
    
    func handle(error: Error) -> APIResponseError {
        guard let errorApi = error as? APIResponseError else {
            return APIResponseError()
        }
        
        delegate?.show(error: errorApi.errorDescription)
        return errorApi
    }
    
}
