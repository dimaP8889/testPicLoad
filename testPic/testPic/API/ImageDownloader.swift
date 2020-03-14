//
//  ImageDownloader.swift
//  testPic
//
//  Created by Dmytro Pogrebniak on 14.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader {
    
    let url : URL
    
    init?(urlString: String) {
        
        guard let url = URL(string: urlString) else { return nil }
        self.url = url
    }
    
    func downloadImage() -> UIImage? {
       
        var image : UIImage?
        
        let group = DispatchGroup()
        group.enter()
        print("Download Started")
        getData(from: url) { [weak self] data, response, error in
            guard let data = data, error == nil, let self = self else { return }
            print(response?.suggestedFilename ?? self.url.lastPathComponent)
            print("Download Finished")
            image = UIImage(data: data)
            group.leave()
        }
        group.wait()
        
        return image
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
