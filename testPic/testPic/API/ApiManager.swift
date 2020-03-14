//
//  APIManager.swift
//  testPic
//
//  Created by Dmytro Pogrebniak on 14.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class Networking {
    
    static let pixbayAPI = API<PixbayPresence>(base: "https://pixabay.com")
}


enum PixbayPresence {
    
    case picture(name : String)
}

extension PixbayPresence : Requestable {
    
    var apiKey: String {
        return "15598237-3c81488fe8ef71e34ef28e143"
    }
    
    func apiRoute() -> String {
        return "api"
    }
    
    func parameters() -> [String : String] {
        
        switch self {
        case .picture(let name):
            return [
                "key" : apiKey,
                "q" : name
            ]
        }
    }
}

enum APIResult {

    case success(ImagesResponse)
    case failure(APIError)
}

enum APIError: Error {
    
    case onRequestCreation
    case onRequestExecute(Error)
    case missingHTTPCode
    case badHTTPCode(Int)
    case missingData
    case jsonMappingFailed(Error)
}

class API<RQ: Requestable>: NSObject {
    
    private var base: URL
    private lazy var session: URLSession = {
        URLSession(configuration: .default)
    }()
    
    init?(base: String) {
        
        guard let _base = URL(string: base) else {
            return nil
        }
        
        self.base = _base
    }
    
    func dataTask(request: RQ, completion: @escaping (APIResult) -> ()) -> URLSessionDataTask {
        
        var urlRequest = request.urlRequest(base)
        
        urlRequest.allHTTPHeaderFields?.merge(request.headers()) { (_, new) in new }
        
        urlRequest.httpMethod = request.httpMethod()
        
        let task = session.dataTask(with: urlRequest) { [unowned self] (data, response, error) in
            
            self.isResponseOk(data, response, error) { (result) in
                
                switch result {
                case .success(let data):
                    completion(
                        .success(data)
                    )
                case .failure(let error):
                    completion(
                        .failure(error)
                    )
                }
            }
        }
        
        return task
    }
    
    private func isResponseOk(
                _ data: Data?,
                _ response: URLResponse?,
                _ error: Error?,
                completion: @escaping (APIResult)->()
    ) {
        guard error == nil else {
            
            return completion(
                .failure(.onRequestExecute(error!))
            )
        }
        
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            
            return completion(
                .failure(.missingHTTPCode)
            )
        }
        
        guard 200..<300 ~= code else {
            
            return completion(
                .failure(.badHTTPCode(code))
            )
        }
        
        guard let _data = data else {
            
            return completion(
                .failure(
                    .missingData
                )
            )
        }
        
        do {
            
            completion(
                .success(
                    try JSONDecoder().decode(ImagesResponse.self, from: _data)
                )
            )
        } catch let decodeError {
            
            completion(
                .failure(.jsonMappingFailed(decodeError))
            )
        }
    }
}

extension API where RQ == PixbayPresence {
    
    func getImage(_ name: String) -> UIImage? {
        
        guard let dataUrl = sync(request: .picture(name: name)) else { return nil }
        let downloader = ImageDownloader(urlString: dataUrl)
        
        return downloader?.downloadImage()
    }
}

extension API {
    
    func sync(request : RQ) -> String? {
        
        var result: APIResult!
        
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.dataTask(request: request) { (_result) in
                result = _result
                group.leave()
            }.resume()
        }
        
        group.wait()
        
        switch result {
        case .success(let imageData):
            guard let imageName = imageData.imagesData.first?.largeImageURL else {
                presentAlert(with: "No image found")
                return nil
            }
            return imageName
        case .failure(let error):
            presentAlert(with: error.localizedDescription)
            return nil
        case .none:
            fatalError()
        }
    }
}

extension API : ErrorAlert {}
