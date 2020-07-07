//
//  AppDelegate.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 22/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let list_Group = DispatchGroup()
    
    let network = NetworkManager.sharedInstance
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        let container = NSPersistentContainer(name: "WildlifeResearchCenter")
//        print(container.persistentStoreDescriptions.first?.url)
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
            
            if WebService.shared.isConnected {
                self.webserviceCallForInit()
            }
            
        } else {
            
            if WebService.shared.isConnected {
                
                self.webserviceCallForInit()
                
                DispatchQueue.global(qos: .background).async {
                    self.webserviceCallForMapDealer { (boolvalue) in
                        if boolvalue {
                            self.webServiceforLists()
//                            self.webserviceCallForInit()
                        }
                    }

                }
                
                UserDefaults.standard.set(true, forKey: "launchedBefore")
            }
        }
        
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
                    
                    //                      DispatchQueue.main.async {
                    AppDelegate.shared.window?.rootViewController!.present(alert, animated: true, completion: nil)
                    //                    }
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
                    AppDelegate.shared.window?.rootViewController!.present(alert, animated: true, completion: nil)
                }
            }
            
            
            let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
            if launchedBefore  {
                print("Not First Time")
                
                // This only occurs if
                if json["option"].stringValue == "1" {
                    self.webserviceCallForMapDealer { (boolv) in
                        if boolv {
                            self.webServiceforLists()
                        }
                    }
                }
            }
        }
    }
      
      
      
    func webserviceCallForMapDealer( completion : @escaping (Bool) -> ()) {
        
        DataBaseHandler.sharedManager.deleteMapDealerData()
        
        WebServiceSubClass.mapDealers(showhud: false) { (json, success, resp) in
            
            if success {
                
                let jsonArr = json["result"].arrayValue
                var arr_MapDealers : [MapDealerData] = []
                
                //                DispatchQueue.global(qos: .background).async {
                for eachJsonDict in jsonArr {
                    let newMapDealer = MapDealerData(json: eachJsonDict)
                    arr_MapDealers.append(newMapDealer)
                    DataBaseHandler.sharedManager.saveMapDealerData(modal: newMapDealer)
                }
                //                }
                
                DataBaseHandler.sharedManager.saveContext()
                
                completion(true)
                
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
                var stateList : [String] = []
                stateJson.forEach { (eachState) in
                    stateList.append(eachState.stringValue)
                }
                
                let cityJson = json["city_list"].arrayValue
                var cityList : [String] = []
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
                
                DataBaseHandler.sharedManager.saveContext()
                
            } else {
                // unsuccessfull
            }
        }
    }


}

