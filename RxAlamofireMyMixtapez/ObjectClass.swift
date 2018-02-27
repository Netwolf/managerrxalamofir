//
//  ObjectClass.swift
//  RxAlamofireMyMixtapez
//
//  Created by HugoSilva on 2/16/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import UIKit
import ObjectMapper

class Album: Mappable {
    
    var id = 0
    var name: String = ""
    var bigger = false
    var single: Bool = false
    var position = 0
    var statusActive: Bool = false
    var hasFavoriteTrack: Bool = false
    var inPlaylist: Bool = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id  <- map["id"]
        name        <- map["name"]
        bigger      <- map["bigger"]
        single      <- map["single"]
        statusActive <- map["statusActive"]
        hasFavoriteTrack <- map["hasFavoriteTrack"]
        inPlaylist <- map["inPlaylist"]   
    }
    
}


class Status: Mappable {
    
    var status: ErrorT?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
    }
    
}

class ErrorT: Mappable {
    
    var message: String = ""
    var value: Int = 0
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        value <- map["value"]
    }
    
}


class Post: Mappable {
    var body: String = ""
    var id: Int = 0
    var title: String = ""
    var userId: Int = 0
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        body <- map["body"]
        id <- map["id"]
        title <- map["title"]
        userId <- map["userId"]
    }
}

class APIResponseError :  Error, Mappable {
    
    var error_code : Int = -1
    var error_description : String = "Could not decode object"
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        error_code <- map["error_code"]
        error_description <- map["error_description"]
    }
    
}

public struct ObjectRequest<T> {
    var objectResponse: T?
    var arrayResponse: [T]?
}



class RefreshToken: Mappable {
    
    var refreshToken : String = ""
    var scope : String = ""
    var jti : String = ""
    var tokenType : String = ""
    var accessToken : String = ""
    var expiresIn : Double = 0.0
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        refreshToken <- map["refresh_token"]
        scope <- map["scope"]
        jti <- map["jti"]
        tokenType <- map["token_type"]
        accessToken <- map["access_token"]
        expiresIn <- map["expires_in"]
    }
    
}

class ObjectClass: NSObject {

}
