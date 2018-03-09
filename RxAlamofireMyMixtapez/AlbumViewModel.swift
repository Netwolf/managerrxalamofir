//
//  AlbumBusiness.swift
//  RxAlamofireMyMixtapez
//
//  Created by Fabricio Oliveira on 2/28/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import ObjectMapper
import RxSwift
import Alamofire
import RxAlamofire

class AlbumViewModel {
    
    var albumService = AlbumService()
    
    init() {
        albumService.delegate = AnyServiceResponseProtocol(self)
    }
    
    
    func list() -> Void {
        albumService.fetchList()
    }
    
}


extension AlbumViewModel: ServiceResponseProtocol {
    
    typealias T = Album
    
    func fetchedList(value: [T]) {
        
    }
    
    func fetchedObject(value: T) {
        
    }
    
    func error(error: APIResponseError) {
        
    }
    

}

