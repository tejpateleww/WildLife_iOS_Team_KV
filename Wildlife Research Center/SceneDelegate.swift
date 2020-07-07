//
//  SceneDelegate.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 22/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
//        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
//        if launchedBefore  {
//            print("Not first launch.")
//        } else {
//
//            if WebService.shared.isConnected {
//                DispatchQueue.global(qos: .background).async {
//                    self.webserviceCallForMapDealer()
//                    self.webServiceforLists()
//                    UserDefaults.standard.set(true, forKey: "launchedBefore")
//                }
//            }
//        }
        
//        if WebService.shared.isConnected {
//            webserviceCallForInit()
//        }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "RetailReportMainViewController") as! RetailReportMainViewController
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window!.windowScene = windowScene
        
        
        let isUserLoggedin = userDefault.value(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool
        if isUserLoggedin != nil && isUserLoggedin == true {
            
            let mainNC = UINavigationController(rootViewController: mainVC)
                       window!.rootViewController = mainNC
            
        } else {
            
           let loginNC = UINavigationController(rootViewController: loginVC)
           window!.rootViewController = loginNC
            
        }
        
//        window!.rootViewController = VC
        window!.makeKeyAndVisible()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = window
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
    
    // API CALL:
    func webserviceCallForInit()
    {
        let strUrl = "app_version=\(AppInfo.appVersion)&type=IOS"
        
        WebServiceSubClass.initApi(strParams: strUrl, showHud: true) { (json, status, response) in
            
            guard json["status"].boolValue == true else { return }
            
            // if update is nil, then no update is available, if u get this param in resonse, then check for bool.
            if ((json["update"].bool) != nil) {
                
                if ((json["update"].bool) == false) {     // update - false means update is not compulsory hense add later action
                    
                    let alert = UIAlertController(title: AppInfo.appName,
                                                  message: json["message"].string ?? "New version is available on App Store",
                                                  preferredStyle: UIAlertController.Style.alert)
                    
                    let okAction = UIAlertAction(title: "Update", style: .default, handler: { (action) in
                        if let url = URL(string: AppInfo.appUrl) {
                            UIApplication.shared.open(url)
                        }
                    })
                    
                    let LaterAction = UIAlertAction(title: "Later", style: .default, handler: { (action) in
                        alert.dismiss(animated: true) {
                        }
                    })
                    
                    alert.addAction(okAction)
                    alert.addAction(LaterAction)
                    
                    DispatchQueue.main.async {
                        AppDelegate.shared.window?.rootViewController!.present(alert, animated: true, completion: nil)
                    }
                }
                else if((json["update"].boolValue) == true)
                {
                    let alert = UIAlertController(title: AppInfo.appName,
                                                  message: json["message"].string ?? "Update is required to proceed",
                                                  preferredStyle: UIAlertController.Style.alert)
                    
                    let okAction = UIAlertAction(title: "Update", style: .default, handler: { (action) in
                        if let url = URL(string: AppInfo.appUrl) {
                            UIApplication.shared.open(url)
                        }
                    })
                    
                    alert.addAction(okAction)
                    
                    DispatchQueue.main.async {
                        AppDelegate.shared.window?.rootViewController!.present(alert, animated: true, completion: nil)
                    }
                }
            }
            
            
            let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
            if launchedBefore  {
                print("Not first launch.")
                
                if json["option"].stringValue == "1" {
                    // Call the Lists and Map Dealer api async
                    DispatchQueue.global(qos: .background).async {
                        self.webServiceforLists()
                        self.webserviceCallForMapDealer()
                    }
                }
            }
            
        }
    }
    
    
    
    func webserviceCallForMapDealer() {
        
        DataBaseHandler.sharedManager.deleteMapDealerData()
        
        
        WebServiceSubClass.mapDealers(showhud: true) { (json, success, resp) in
            
            if success {
                
                let jsonArr = json["result"].arrayValue
                var arr_MapDealers : [MapDealerData] = []
                
                for eachJsonDict in jsonArr {
                    let newMapDealer = MapDealerData(json: eachJsonDict)
                    arr_MapDealers.append(newMapDealer)
                    DataBaseHandler.sharedManager.saveMapDealerData(modal: newMapDealer)
                }
                
            }
        }
    }
    
    
    func webServiceforLists() {
        
        WebServiceSubClass.storeStateCityListsApi(showhud: false) { (json, success, resp) in
            
            if success {
                let storeJson = json["title_list"].arrayValue
                var storeList : [String] = []
                storeJson.forEach { (eachStore) in
                    storeList.append(eachStore.stringValue)
                }
                
                let stateJson = json["state_list"].arrayValue
                var stateList : [String] = ["Select"]
                stateJson.forEach { (eachState) in
                    stateList.append(eachState.stringValue)
                }
                
                let cityJson = json["city_list"].arrayValue
                var cityList : [String] = ["Select"]
                cityJson.forEach { (eachCity) in
                    cityList.append(eachCity.stringValue)
                }
                
                //save the lists in Local DB
                
                storeList.forEach { (eachStoreName) in
                    DataBaseHandler.sharedManager.saveStoreNames(str: eachStoreName)
                }
                
                stateList.forEach { (eachStateName) in
                    DataBaseHandler.sharedManager.saveStateNames(str: eachStateName)
                }
                
                cityList.forEach { (eachCityName) in
                    DataBaseHandler.sharedManager.saveCityNames(str: eachCityName)
                }
                
            } else {
                // unsuccessfull
            }
        }
    }
    


}

