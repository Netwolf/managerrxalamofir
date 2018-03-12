//
//  ConfigurationRequest.swift
//  RxAlamofireMyMixtapez
//
//  Created by HugoSilva on 2/26/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import Foundation

typealias RequestVariable = Request
extension RequestVariable {
    
    public struct ApiConstants {
        
        public struct Config {
            static let BaseURL = "https://api-sandbox.mymixtapez.com"
        }
        
        public struct BasicAuthentication {
            static let BasicTypeToken   = "Basic"
            static let BasicAccessToken = "aW9zOlNEYTVnU3VXZmdoNlFVVXU="
        }
        
        public struct Token{
            static let AccessToken       = "RestShipAccessToken"
            static let RefreshToken      = "RestShipRefreshToken"
            static let ExpireToken       = "RestShipExpireToken"
            static let TypeToken         = "RestShipTypeToken"
            static let RefreshURL        = "RestShipRefreshURL"
            static let Date              = "RestShipDate"
            static let GroupAccessToken  = "GroupRefreshToken"
            static let GroupRefreshToken = "GroupRestShipRefreshToken"
            static let GroupExpireToken  = "GroupRestShipExpiresIn"
            static let GroupDate         = "GroupRestShipRefresDate"
        }
        
        public struct UserDefaultGroup {
            static let GroupMyMixtapez = "group.com.mymixtapez.ios"
        }
        
    }
    
    public struct Token {
        public static var AccessToken: String {
            get { return Request.defaultsStringForKey(ApiConstants.Token.AccessToken) }
            set { Request.defaultsSetString(newValue, forkey: ApiConstants.Token.AccessToken)
                  Request.grounpSetObject(object: newValue as NSObject, forkey: ApiConstants.Token.GroupAccessToken) }
        }
        
        public static var RefreshToken: String {
            get { return Request.defaultsStringForKey(ApiConstants.Token.RefreshToken) }
            set { Request.defaultsSetString(newValue, forkey: ApiConstants.Token.RefreshToken)
                  Request.grounpSetObject(object: newValue as NSObject, forkey: ApiConstants.Token.GroupRefreshToken) }
        }
        
        public static var ExpiresIn: Double {
            get { return Request.defaultsDoubleForKey(ApiConstants.Token.ExpireToken) }
            set { Request.defaultsSetdouble(newValue, forkey: ApiConstants.Token.ExpireToken)
                  Request.grounpSetObject(object: newValue as NSObject, forkey: ApiConstants.Token.GroupExpireToken) }
        }
        
        public static var TokenType: String {
            get { return Request.defaultsStringForKey(ApiConstants.Token.TypeToken) }
            set { Request.defaultsSetString(newValue, forkey: ApiConstants.Token.TypeToken) }
        }
        
        public static var RefreshURL: String {
            get { return Request.defaultsStringForKey(ApiConstants.Token.RefreshURL) }
            set { Request.defaultsSetString(newValue, forkey: ApiConstants.Token.RefreshURL) }
        }
        
        public static var RefreshDate: NSObject {
            get { return Request.defaultsDateForKey(ApiConstants.Token.Date) as NSObject }
            set { Request.defaultsSetDate(newValue, forkey: ApiConstants.Token.Date)
                  Request.grounpSetObject(object: newValue, forkey: ApiConstants.Token.GroupDate) }
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
        let defaults = UserDefaults(suiteName: ApiConstants.UserDefaultGroup.GroupMyMixtapez)
        defaults!.setValue(object, forKey: key)
    }
    
    fileprivate static func groupGetObjectForKey(key: String) -> NSObject {
        let defaults = UserDefaults(suiteName: ApiConstants.UserDefaultGroup.GroupMyMixtapez)
        guard let object = defaults!.object(forKey: key)
            else { return "" as NSObject }
        return object as! NSObject
        
    }
    
    public static func saveTokens(tokens: RefreshToken) {
        Request.Token.AccessToken = tokens.accessToken
        Request.Token.RefreshToken = tokens.refreshToken
        Request.Token.TokenType = tokens.tokenType
        Request.Token.RefreshDate = Date().add(second: Int(tokens.expiresIn)) as NSObject
    }
    
    public static func clearTokens() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: ApiConstants.Token.AccessToken)
        defaults.removeObject(forKey: ApiConstants.Token.RefreshToken)
        defaults.removeObject(forKey: ApiConstants.Token.ExpireToken)
        defaults.removeObject(forKey: ApiConstants.Token.RefreshURL)
        defaults.removeObject(forKey: ApiConstants.Token.TypeToken)
        defaults.removeObject(forKey: ApiConstants.Token.Date)
        defaults.removeObject(forKey: ApiConstants.Token.GroupAccessToken)
        defaults.removeObject(forKey: ApiConstants.Token.GroupRefreshToken)
        defaults.removeObject(forKey: ApiConstants.Token.GroupExpireToken)
        defaults.removeObject(forKey: ApiConstants.Token.GroupDate)
    }
}

