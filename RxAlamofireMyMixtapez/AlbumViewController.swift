//
//  ViewController.swift
//  RxAlamofireMyMixtapez
//
//  Created by HugoSilva on 2/7/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import UIKit
import ObjectMapper

//protocol BasicsService {
//    func getModel
//    func getList
//    refresh
//}


class AlbumViewController: UIViewController {

    let sourceStringURLWithout = "http://api.geonames.org/citiesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&lang=de&username=demo"
    let exempleRequest = "http://jsonplaceholder.typicode.com/posts"
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Request.Token.TokenType = "bearer"
//        
//        Request.Token.AccessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MjA0NTUwMTYsInVzZXJfbmFtZSI6IjI5NDI0MjAiLCJhdXRob3JpdGllcyI6WyJST0xFX1VTRVIiXSwianRpIjoiNjI5YzE3YTctNWI2ZS00MmJkLThlMWUtOTM4MWE2NWRhYTYyIiwiY2xpZW50X2lkIjoiYW5kcm9pZCIsInNjb3BlIjpbInJlYWQiXX0.fbelypC3tMEeCMiO9Dc6S0XJ1lO8fdGuHTSj_8A3Uiosdf"
//        
//        Request.Token.RefreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiIwIiwic2NvcGUiOlsicmVhZCJdLCJhdGkiOiJlZWUwZmVjOC04NmNkLTRhYmMtODIyYS00NTgzMmI1OWQ1YjciLCJleHAiOjE1MjU2Mjk2NDMsImF1dGhvcml0aWVzIjpbIlJPTEVfR1VFU1QiXSwianRpIjoiZDQ3NGIwNWItNmIyNi00MGY1LTk1NzEtYzQzNjViMDBmYzA3IiwiY2xpZW50X2lkIjoiaW9zIn0.QpcIC49TrgiS00nH0o87WI5Lyr0CYN1NGOFuauxuO0E"

        
        AlbumViewModel().list()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
 
    
    func refresh() {
       print("Refresh token")

    }
    
    
}






