//
//  ImagesResponse.swift
//  testPic
//
//  Created by Dmytro Pogrebniak on 14.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation

struct ImagesResponse : Decodable {
    
    let total : Int
    let totalHits : Int
    let imagesData : [ImageData]
    
    enum CodingKeys: String, CodingKey {

        case total = "total"
        case totalHits = "totalHits"
        case imagesData = "hits"
    }
}
