//
//  AlbumService.swift
//  RxAlamofireMyMixtapez
//
//  Created by Fabricio Oliveira on 2/28/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//
import Foundation
import ObjectMapper
import RxSwift
import PromiseKit

class AlbumService: ServiceProtocol  {
    typealias T = Album
    
    var delegate: AnyServiceResponseProtocol<T>?
    
    func fetchList() {

         RequestManager.shared.fetch(url: "/v2/albums/features", parameters: [:], headers: [:], schedulerType: SerialDispatchQueueScheduler.init(qos: .background), scheduler: MainScheduler.instance, retries: 3, object: T.self).then { objectResponse -> Void in
                if let unities = Mapper<T>().mapArray(JSONString: objectResponse) {
                    self.delegate?.fetchedList(value: unities)
                }
            }.catch { error in
                self.delegate?.error(error: error as! APIResponseError)
            }.always {
                
        }
    }
    
    func fetchObject() {
        RequestManager.shared.fetch(url: "/v2/albums/features", parameters: [:], headers: [:], schedulerType: SerialDispatchQueueScheduler.init(qos: .background), scheduler: MainScheduler.instance, retries: 3, object: T.self).then { objectResponse -> Void in
            
            if let unity = Mapper<T>().map(JSONString: objectResponse) {
                self.delegate?.fetchedObject(value: unity)

            } else {

            }
            }.catch { error in
                self.delegate?.error(error: error as! APIResponseError)

                
            }.always {
                
        }
    }
    
}
