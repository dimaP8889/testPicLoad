//
//  SearchModel.swift
//  testPic
//
//  Created by Dmytro Pogrebniak on 14.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation
import RealmSwift

class SearchModel: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var picture: Data = Data()
    @objc dynamic var creationDate: Date = Date()
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    init(name : String, picture: Data, creation: Date) {
        self.name = name
        self.picture = picture
        self.creationDate = creation
    }
    
    required init() {}
}


