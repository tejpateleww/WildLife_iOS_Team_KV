//
//  AppDelegate.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 22/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let network = NetworkManager.sharedInstance
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
        if #available(iOS 13.0, *){
            //do nothing we will have a code in SceneceDelegate for this
        } else {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "RetailReportMainViewController") as! RetailReportMainViewController
            
            let isUserLoggedin = userDefault.value(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool
                  if isUserLoggedin != nil && isUserLoggedin == true {
                    
                    let navigationController = UINavigationController(rootViewController: mainVC)
                    navigationController.isNavigationBarHidden = true // or not, your choice.
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window!.rootViewController = navigationController
                    
                  } else {
                      let navigationController = UINavigationController(rootViewController: loginVC)
                      navigationController.isNavigationBarHidden = true // or not, your choice.
                      self.window = UIWindow(frame: UIScreen.main.bounds)
                      self.window!.rootViewController = navigationController
                  }
            
        }
        
        
        IQKeyboardManager.shared.enable = true
        return true
    }

    // MARK: UISceneSession Lifecycle
     @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

