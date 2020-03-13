//
//  HomeRouter.swift
//  testPic
//
//  Created by Dmytro Pogrebniak on 13.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class HomeRouter {
    
      // MARK: - Instance Properties
    public let window: UIWindow
    
    init(window : UIWindow) {
        self.window = window
    }
}

extension HomeRouter : Router {
    
    func present(_ viewController: UIViewController) {
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
