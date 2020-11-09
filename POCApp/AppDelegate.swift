//
//  AppDelegate.swift
//  POCApp
//
//  Created by Ritesh on 07/11/20.
//  Copyright © 2020 Ritesh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        let rootControoler = UINavigationController(rootViewController: HomeViewController())
        window?.rootViewController = rootControoler
        return true
    }

}

