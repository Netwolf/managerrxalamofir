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
        // Do any additional setup after loading the view, typically from a nib.
        //oneRequest()
        //AlbumBusiness().list()
        //AlbumBusiness().listNew()
        AlbumBusiness().listVeryVeryNew()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
 
    
    func refresh() {
       print("Refresh token")

    }
    
    
}






