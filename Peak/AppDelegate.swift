//
//  AppDelegate.swift
//  Peak
//
//  Created by akshatha hegde on 5/14/18.
//  Copyright © 2018 akshatha hegde. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //To Setup Backendless
    let APP_ID = "4090B29E-6ED8-0B4E-FFDD-DFF3580C3900"
    let API_KEY = "07D35989-395B-91CB-FF34-987752056600"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        //To Use Firebase
        FirebaseApp.configure()
        
        //To use backendless
        backendless!.initApp(APP_ID, apiKey: API_KEY)
        
        return true
    }

    

}

