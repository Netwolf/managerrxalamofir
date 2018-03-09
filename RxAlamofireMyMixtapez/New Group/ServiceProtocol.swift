//
//  ServiceProtocols.swift
//  RxAlamofireMyMixtapez
//
//  Created by Fabricio Oliveira on 3/9/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    associatedtype T
    func fetchList()
    func fetchObject()
}

protocol ServiceResponseProtocol {
    associatedtype T
    func fetchedList(value: [T])
    func fetchedObject(value: T)
    func error(error: APIResponseError)
}

class AnyServiceResponseProtocol<T>: ServiceResponseProtocol {
    
    private let _fetchedList:(_ value: [T] ) -> Void
    private let _fetchedObject:(_ value: T) -> Void
    private let _error:(_ error: APIResponseError) -> Void
    
    init<ServiceFactory: ServiceResponseProtocol>(_ serviceFactory: ServiceFactory) where ServiceFactory.T == T {
        _fetchedList = serviceFactory.fetchedList
        _fetchedObject = serviceFactory.fetchedObject
        _error = serviceFactory.error
    }
    
    func error(error: APIResponseError) {
        _error(error)
    }
    
    func fetchedList(value: [T]) {
        _fetchedList(value)
    }
    
    func fetchedObject(value: T) {
        _fetchedObject(value)
    }
}
