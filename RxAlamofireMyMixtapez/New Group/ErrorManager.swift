//
//  ErrorManager.swift
//  RxAlamofireMyMixtapez
//
//  Created by Fabricio Oliveira on 3/5/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import Foundation

protocol ErrorProtocol {
    func refreshToken()
    func show(error: String)
}

struct ErrorManager {
    
    var delegate: ErrorProtocol?
    
    func handle(error: Error) {
        guard let errorApi = error as? APIResponseError else {
            return
        }
        
        if errorApi.error_code == 401 {
            delegate?.refreshToken()
        } else {
            delegate?.show(error: errorApi.error_description)
        }
    }
    
}
