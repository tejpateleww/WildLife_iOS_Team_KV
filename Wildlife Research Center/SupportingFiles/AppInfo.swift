//
//  AppInfo.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 15/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import UIKit
struct AppInfo {
    
    static var appVersion: String {
        if let app_version = Bundle.main.infoDictionary?["CFBundleVersion"]  as? String {
            return app_version
        } else{
            return "no Version"
        }
    }
    
    static var appName:String{
        return Bundle.appName()
    }
    
    static var appHeaderKey:String{
        return "key"
    }
    
    static var appDynamicHeaderKey:String{
        return "x-api-key"
    }
    
    
    static var appStaticHeader:String{
        return ""
    }
    
    static var deviceType:String{
        return "ios"
    }
    
    static var appUrl:String{
        return "itms-apps://itunes.apple.com/app/id1488928328"
    }
    
    
    //
    static var Google_Client_Id: String {
        return ""
    }
}


extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }
}
