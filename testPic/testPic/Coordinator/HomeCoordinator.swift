//
//  HomeCoordanator.swift
//  testPic
//
//  Created by Dmytro Pogrebniak on 13.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation

class HomeCoordinator : NSObject {
    
    // MARK: - Instance Properties
    public let router: Router

    // MARK: - Object Lifecycle
    public init(router: Router) {
      self.router = router
    }

    // MARK: - Instance Methods
    public func present() {
        
        let vc = SearchVC()
        router.present(vc)
    }
}
