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

class AlbumService: UIViewController { //BasicsService {
    
}
class ViewController: UIViewController {

    let sourceStringURLWithout = "http://api.geonames.org/citiesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&lang=de&username=demo"
    let exempleRequest = "http://jsonplaceholder.typicode.com/posts"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        oneRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func oneRequest(){
        Request
            .fromPathURL("/v2/albums/features")
            .request(callback: { callback in
                switch callback {
                case .onSuccess(let objectResponse):
                    
                    if let objectToken =  Mapper<Album>().mapArray(JSONString: objectResponse){
                        print("Number of album: \(String(describing: objectToken.count))")
                    }
                    break
                case .onError(let objectError):
                    if objectError.error_code == 401 {
                        print("Error 401: \(objectError.error_description)")
                    }else {
                        print("Error normal: \(objectError.error_description)")
                    }
                    break
                }})
        
    }
    
    func refresh() {
       print("Refresh token")

    }
    
    
}






