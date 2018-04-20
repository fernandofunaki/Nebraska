//
//  Item.swift
//  nebraska_app
//
//  Created by fernando-mbp on 19/04/18.
//  Copyright © 2018 Fernando Funaki. All rights reserved.
//

import Foundation

class Item : Encodable, Decodable{
    var title: String = ""
    var done: Bool = false

//    init() {
//
//    }
//
//    convenience init(title: String, done: Bool) {
//        self.init()
//        self.title = title
//        self.done = done
//    }
}
