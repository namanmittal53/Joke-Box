//
//  AppDelegate.swift
//  Joke Box
//
//  Created by Naman on 23/06/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Set Window for the AppDelegate
    //==========================================
    var window: UIWindow?
    static var shared: AppDelegate {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate
        }
        fatalError("Invalid Access of AppDelegate")
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setAsWindowRoot()
        return true
    }
    
    
}

extension AppDelegate {
    
    // MARK: - General Method to set Window Root View Controller
    //===============================================================
    func setAsWindowRoot() {
        let navigationController = UINavigationController(rootViewController: JokesVC())
        navigationController.setNavigationBarHidden(true, animated: false)
        AppDelegate.shared.window = UIWindow(frame: UIScreen.main.bounds)
        AppDelegate.shared.window?.rootViewController = navigationController
        AppDelegate.shared.window?.becomeKey()
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
}
