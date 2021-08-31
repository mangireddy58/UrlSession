//
//  AppDelegate.swift
//  UrlSession
//
//  Created by Mangi on 25/02/20.
//  Copyright © 2020 Mangi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEV
        print("Development")
        
        #elseif PROD
        print("Production")
        
        #elseif QA
        print("QA")
        
        #endif
        
        window?.makeKeyAndVisible()
        
        return true
    }


}

