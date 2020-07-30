//
//  Singleton.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 22/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation

class SingletonClass: NSObject {
    
     static let sharedInstance = SingletonClass()
        
        var UserId = String()
        var LoginRegisterUpdateData : UserInfo?
        var Api_Key = String()
        var DeviceToken : String = ""
    
    //    var currentLat = Double()
    //    var currentLong = Double()
        
        ///Owner Profile Info
    //    var OwnerProfileInfo : ResProfileRootClass?
      
        var arrFutureYears:[String] {
            get {
                let calendar = Calendar.current
                let currentYear = calendar.component(.year, from: Date())
                return (currentYear...(currentYear + 11)).map { String($0)}
            }
        }
        
        func clearSingletonClass() {
            SingletonClass.sharedInstance.UserId = ""
            SingletonClass.sharedInstance.LoginRegisterUpdateData = nil
            SingletonClass.sharedInstance.Api_Key = ""
        }
    
    deinit {
    }
}
