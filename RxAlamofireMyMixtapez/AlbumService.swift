//
//  AlbumService.swift
//  RxAlamofireMyMixtapez
//
//  Created by Fabricio Oliveira on 2/28/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

protocol AlbumServiceProtocol {
    func fetched(list: [Album]?)
    func fetched(object: Album?)
    func error(error: APIResponseError)
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
    
    func list() {
        RequestManager.shared.fetchList(url: "/v2/albums/features", parameters: [:], headers: [:], schedulerType: SerialDispatchQueueScheduler.init(qos: .background), scheduler: MainScheduler.instance, retries: 3, object: Album.self).then { response -> Void in
            self.delegate?.fetched(list: response)
            }.catch { error in
                self.delegate?.error(error: error as! APIResponseError)
            }.always {
        }
    }
}
