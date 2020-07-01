//
//  ApiPaths.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 15/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkRouterCompletion = ((Data?,[String:Any]?, Bool) -> ())

var userDefault = UserDefaults.standard

enum UserDefaultsKey : String {
    
    case userProfile = "userProfile"
    
    case isUserLogin = "isUserLogin"
    case X_API_KEY = "X_API_KEY"
    case DeviceToken = "DeviceToken"
    
    case storeInfo = "storeInfo"
    case isStoreSelected = "isStoreSelected"
    
    case storeNames = "storeNames"
    case stateNames = "stateNames"
    case cityNames = "cityNames"
    
    case brandData = "brandData"
    case brandArr = "brandArr"
    
    case submitsToSync = "submitsToSync"
    
    case appUsers = "appUsers"
}

enum APIEnvironment : String {
    
    case baseUrl = "http://wildlife.excellentwebworld.in/"
    case mediaUrl = ""
    
    static var baseURL: String{
        return APIEnvironment.environment.rawValue
    }
    
    static var environment: APIEnvironment{
        return .baseUrl
    }
    
    static var headers : HTTPHeaders
    {
        if userDefault.object(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil {
            
            if userDefault.object(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool == true {

                if userDefault.object(forKey:  UserDefaultsKey.userProfile.rawValue) != nil {
                    do {
                        if UserDefaults.standard.value(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil,UserDefaults.standard.value(forKey:  UserDefaultsKey.isUserLogin.rawValue) as? Bool ?? false
                        {
                            let decoded  = userDefault.object(forKey: UserDefaultsKey.userProfile.rawValue ) as? Data
//                            let userdata = NSKeyedUnarchiver.unarchiveObject(with: decoded ?? Data()) as? UserInfo
                            let userD = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded ?? Data()) as? UserInfo
                            
//                            SingletonClass.sharedInstance.Api_Key = userdata?.data.xApiKey ?? AppInfo.appStaticHeader
                            return [AppInfo.appDynamicHeaderKey:SingletonClass.sharedInstance.Api_Key]
                        }
                    }
                }
            }
        }
        return [AppInfo.appHeaderKey: AppInfo.appStaticHeader]
    }

}

enum ApiKey: String {
    case Init                  = "initapi.php?"
    case login                 = "loginapi.php?"
    case StoreStateAndCityList = "retail_location.php"
    case StoreListForStates    = "location_result.php?"
    case AddStoreManually      = "add_map_dealer.php?"
    case SubmitReports         = "report_submissions.php"
    case imageUpload           = "image_upload.php"
}
