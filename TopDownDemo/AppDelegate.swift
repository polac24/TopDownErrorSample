//
//  AppDelegate.swift
//  TopDownDemo
//
//  Created by Bartosz Polaczyk on 18/02/2018.
//  Copyright © 2018 Bartosz Polaczyk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let logger: Loggerable = Logger()
    let reachibility: Reachable = ReachabilityMock()
    let apiClient: APIClientable = APIClientMock()
    var fc: FlowCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let errorHandler = ErrorHandler().listen(action: logger.log)
        fc = FlowCoordinator(window:window, apiClient: apiClient, reachability: reachibility, errorHandler: errorHandler)
        fc.start()
        
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }


}

