//
//  AlbumBusiness.swift
//  RxAlamofireMyMixtapez
//
//  Created by Fabricio Oliveira on 2/28/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import ObjectMapper
import RxSwift
import Alamofire
import RxAlamofire

struct AlbumBusiness {
    
    var albumService = AlbumService()
    
    func listVeryNew() -> Void {
        albumService.listVeryNew()
    }

}
