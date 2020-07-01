//
//  AppUser.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 27/06/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation

struct AppUser : Codable {
    
    // USer: We keep a record of all users using their unique email.
    var emailID : String = ""
    
    // Array of all his offline reports: Contains all the params recorded and the images that are yet to be uploaded.
    var arr_OfflineReports : [OfflineReportModal] = []
    
    init(user_Email : String, arr_OfflineReports : [OfflineReportModal]) {
        self.emailID = user_Email
        self.arr_OfflineReports = arr_OfflineReports
    }
        
}
