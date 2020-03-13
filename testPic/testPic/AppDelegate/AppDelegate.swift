//
//  AppDelegate.swift
//  testPic
//
//  Created by Dmytro Pogrebniak on 13.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Instance Properties
    public lazy var coordinator = HomeCoordinator(router: router)
    public lazy var router = HomeRouter(window: window!)
    public lazy var window: UIWindow? =
      UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        coordinator.present()
        return true
    }
}

