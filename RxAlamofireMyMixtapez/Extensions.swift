//
//  Extensions.swift
//  RxAlamofireMyMixtapez
//
//  Created by Fabricio Oliveira on 2/28/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import Foundation

extension Date {
    func add(second: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .second, value: second, to: self)!
    }
}
