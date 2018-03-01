//
//  AlbumService.swift
//  RxAlamofireMyMixtapez
//
//  Created by Fabricio Oliveira on 2/28/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//


protocol Gettable {
    associatedtype Model
    associatedtype Error where Error == APIResponseError
    func list(completion: @escaping (Result<[Model], Error>) -> Void)
    func unique(completion: @escaping (Result<Model, Error>) -> Void)
    func listNew(url: String) -> Observable<(HTTPURLResponse, Any)>
}

import UIKit
import Foundation
import ObjectMapper
import RxSwift
import Alamofire
import RxAlamofire

struct AlbumService {
    typealias Model = Album
    typealias Error = APIResponseError



func listVeryNew() {
    RequestManager.fetcheListOfObject(url: "/v2/albums/features", object: Album.self, onSuccess: { (object) in
        
        
    }) { (error) in
        
        
    }
}


}
