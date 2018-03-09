//
//  AlbumBusiness.swift
//  RxAlamofireMyMixtapez
//
//  Created by Fabricio Oliveira on 2/28/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

protocol ViewModelProtocol {
    associatedtype T
    func fetchedList(value: [T])
    func fetchedObject(value: T)
    func error(error: APIResponseError)
}

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
        print("*********************************list: \n \(value)")
    }
    
    func fetchedObject(value: T) {
        
    }
    
    func error(error: APIResponseError) {
        
    }
    

}

