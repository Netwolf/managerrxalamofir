//
//  ObjectClass.swift
//  RxAlamofireMyMixtapez
//
//  Created by HugoSilva on 2/16/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class Album: Codable, Mappable {
    
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

class APIResponseError: Error, Mappable {
    
    var errorCode : Int = -1
    var errorDescription : String = "Could not decode object"
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    init(code: Int, description: String) {
        self.errorCode = code
        self.errorDescription = description
    }
    
    func mapping(map: Map) {
        errorCode <- map["error_code"]
        errorDescription <- map["error_description"]
    }
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

