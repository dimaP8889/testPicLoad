//
//  DataManager.swift
//  testPic
//
//  Created by Dmytro Pogrebniak on 14.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager {
    
    private var realm = try! Realm()
    
    func save(_ data : [SearchModel]) {
        
        try! realm.write {
            realm.add(data, update: .modified)
        }
    }
    
    func delete(_ element: SearchModel) {
        
        let object = load().filter { $0 == element }
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func load() -> [SearchModel] {
        
        let objects = try! Realm().objects(SearchModel.self)
        
        return Array(objects)
    }
    
    
}
