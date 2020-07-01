//
//  ReportModal.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 27/06/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation

struct ReportModal : Codable {
    
//Below Fields are directly used as their keys in Submit report modal. (Just need the adjustments in brand and photo array. that should be in a loop)
    
    
    // Below Field from User Modal cause we need to Link a report to a particular User.
    var createdByUserNum : String = ""
    var submitedby : String = ""       // This is Full name
    var email : String = ""
    
    // Store Details from the StoreInfoModal
    var store_name : String = ""
    var store_state : String = ""
    var store_city : String = ""
    
    // Store Review Questions on the Main Page
    var wildlife_product_set_up : Bool = false
    var were_our_products_priced : Bool = false
    var ask_someone_to_price : Bool = false
    var wildlife_product_displayed_correctly : Bool = false
    var discuss_any_issues : Bool = false
    var product_training : Bool = false
    var did_you_leave_seps : Bool = false
    var did_you_work_an_event : Bool = false
    
    
    // Brand Array -> Make it totally dynamic -> there are 7 brands and each has 5 fields.
    var brandModal : [BrandData] = []
    
    // This array of Strings will contain all the response strings after each image is uploaded .. can contain infinite number of photos.
    var photoArray: [String] = []
    
    // Comments from the retail report third VC
    var Comments : String = ""
    
    
    
//Below Fields are used For Developer Purpose while storing the values in offline mode.
    
    var isStoreAddedManually : Bool = false
    var total_ImgUploads : Int = 0
    var imgArr : [Data] = []
    
}
