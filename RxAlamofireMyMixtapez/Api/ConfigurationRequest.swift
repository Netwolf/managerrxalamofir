//
//  ConfigurationRequest.swift
//  RxAlamofireMyMixtapez
//
//  Created by HugoSilva on 2/26/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import Foundation

private let RestShipAccessToken    = "RestShipAccessToken"
private let RestShipRefreshToken   = "RestShipRefreshToken"
private let RestShipExpireToken    = "RestShipExpireToken"
private let RestShipTypeToken      = "RestShipTypeToken"
private let RestShipRefreshURL     = "RestShipRefreshURL"
private let RestShipDate           = "RestShipDate"

typealias RequestVariable = Request
extension RequestVariable {
    
    public struct Configuration {
        public init() { }
    }
    
    public struct Token {
        public static var AccessToken: String {
            get { return Request.defaultsStringForKey(RestShipAccessToken) }
            set { Request.defaultsSetString(newValue, forkey: RestShipAccessToken)
                  Request.grounpSetObject(object: newValue as NSObject, forkey: "GroupRefreshToken") }
        }
        
        public static var RefreshToken: String {
            get { return Request.defaultsStringForKey(RestShipRefreshToken) }
            set { Request.defaultsSetString(newValue, forkey: RestShipRefreshToken)
                  Request.grounpSetObject(object: newValue as NSObject, forkey: "GroupRestShipRefreshToken") }
        }
        
        public static var ExpiresIn: Double {
            get { return Request.defaultsDoubleForKey(RestShipExpireToken) }
            set { Request.defaultsSetdouble(newValue, forkey: RestShipExpireToken)
                  Request.grounpSetObject(object: newValue as NSObject, forkey: "GroupRestShipExpiresIn") }
        }
        
        public static var TokenType: String {
            get { return Request.defaultsStringForKey(RestShipTypeToken) }
            set { Request.defaultsSetString(newValue, forkey: RestShipTypeToken) }
        }
        
        public static var RefreshURL: String {
            get { return Request.defaultsStringForKey(RestShipRefreshURL) }
            set { Request.defaultsSetString(newValue, forkey: RestShipRefreshURL) }
        }
        
        public static var RefreshDate: NSObject {
            get { return Request.defaultsDateForKey(RestShipDate) as NSObject }
            set { Request.defaultsSetDate(newValue, forkey: RestShipDate)
                  Request.grounpSetObject(object: newValue, forkey: "GroupRestShipRefresDate") }
        }
        
    }
    
    fileprivate static func defaultsStringForKey(_ key: String) -> String {
        let defaults = UserDefaults.standard
        guard let object = defaults.string(forKey: key)
            else { return "" }
        return object
    }
    
    fileprivate static func defaultsSetString(_ object: String, forkey key: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(object, forKey: key)
    }
    
    fileprivate static func defaultsDoubleForKey(_ key: String) -> Double {
        let defaults = UserDefaults.standard
        return defaults.double(forKey: key)
    }

    fileprivate static func defaultsSetdouble(_ object: Double, forkey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(object, forKey: key)
    }
    
    fileprivate static func defaultsDateForKey(_ key: String) -> NSObject {
        let defaults = UserDefaults.standard
        if(UserDefaults.standard.object(forKey: key) == nil){
            return "" as NSObject
        }
        return defaults.object(forKey: key) as! NSObject
    }
    
    fileprivate static func defaultsSetDate(_ object: NSObject, forkey key: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(object, forKey: key)
    }

    //----------- User Default Group
    fileprivate static func grounpSetObject(object: NSObject, forkey key: String) {
        let defaults = UserDefaults(suiteName: "group.com.mymixtapez.ios")
        defaults!.setValue(object, forKey: key)
    }
    
    fileprivate static func groupGetObjectForKey(key: String) -> NSObject {
        let defaults = UserDefaults(suiteName: "group.com.mymixtapez.ios")
        guard let object = defaults!.object(forKey: key)
            else { return "" as NSObject }
        return object as! NSObject
        
    }
    
    public static func saveTokens(tokens: RefreshToken){
        Request.Token.AccessToken = tokens.accessToken
        Request.Token.RefreshToken = tokens.refreshToken
        Request.Token.TokenType = tokens.tokenType
        Request.Token.RefreshDate = Date().add(second: Int(tokens.expiresIn )) as NSObject
    }
    
    public static func clearTokens() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: RestShipAccessToken)
        defaults.removeObject(forKey: RestShipRefreshToken)
        defaults.removeObject(forKey: RestShipExpireToken)
        defaults.removeObject(forKey: RestShipTypeToken)
        defaults.removeObject(forKey: RestShipRefreshURL)
        defaults.removeObject(forKey: RestShipDate)
    }
    
}

extension Date {
    
    func add(second: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .second, value: second, to: self)!
    }
    
}

