//
//  AppDelegate.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 20/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Create a window and a view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

}

