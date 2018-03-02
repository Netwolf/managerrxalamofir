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

protocol AlbumServiceProtocol {
    func fetched(list: [Album]?)
    func fetched(object: Album?)
    func ocurredAn(error: APIResponseError)
}

import UIKit
import Foundation
import ObjectMapper
import RxSwift
import Alamofire
import RxAlamofire
import PromiseKit

struct AlbumService {

    var delegate: AlbumServiceProtocol?
    
    func listAlbums() {
        //UIApplication.shared.isNetworkActivityIndicatorVisible = true
        RequestManager.fetch(url: "/v2/albums/features", object: Album.self).then { responseRequest -> Void in
            self.delegate?.fetched(list: responseRequest.listOfObjects)
            }.catch { error in
                self.delegate?.ocurredAn(error: error as! APIResponseError)
            }.always {
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

    }
    
    func listVeryNew() {
        RequestManager.fetcheListOfObject(url: "/v2/albums/features", object: Album.self, onSuccess: { (object) in
            
        }) { (error) in
            
        }
    }
    
}
