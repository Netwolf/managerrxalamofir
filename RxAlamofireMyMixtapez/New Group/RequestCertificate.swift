//
//  RequestCertificate.swift
//  RxAlamofireMyMixtapez
//
//  Created by HugoSilva on 3/7/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import Alamofire

typealias RequestCertificate = Request
extension RequestCertificate {
    
    public static let sharedManager: Alamofire.SessionManager = {
        
        let certificates = ServerTrustPolicy.certificates(in: Bundle.main)
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "api.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            "api-sandbox.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            "search.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            "hits.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            "image.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            
            "video.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            
            "music.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            ),
            
            "stream.mymixtapez.com": .pinCertificates(
                certificates: certificates,
                validateCertificateChain: true,
                validateHost: true
            )
            
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        
        return Alamofire.SessionManager(configuration: configuration)
        
    }()
    
}

