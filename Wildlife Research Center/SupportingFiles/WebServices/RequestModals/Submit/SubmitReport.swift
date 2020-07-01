//
//  SubmitReport.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 28/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation

struct SubmitReport : Codable {
    
    var createdByUserNum : String = ""
    var store_name : String = ""
    var store_state : String = ""
    var store_city : String = ""

    var photos : String = ""
    var photos_02 : String = ""
    var photos_03 : String = ""
    var photos_04 : String = ""
    var photos_05 : String = ""
    var photos_06 : String = ""
    var photos_07 : String = ""
    var photos_08 : String = ""

    var submitedby : String = ""
    var email : String = ""

    var wildlife_product_set_up : Bool = false
    var wildlife_product_displayed_correctly : Bool = false
    var discuss_any_issues : Bool = false
    var product_training : Bool = false
    var did_you_work_an_event : Bool = false


    var brandname1 : String = ""
    var scent_elimination_facings1 : String = ""
    var scent_elimination_pallet_displays1 : String = ""
    var scent_and_dispenser_facings1 : String = ""
    var scent_and_dispenser_pallet_facings1 : String = ""
    var exclusive_end_cap_1 : String = ""

    var brandname2 : String = ""
    var scent_elimination_facings2 : String = ""
    var scent_elimination_pallet_displays2 : String = ""
    var scent_and_dispenser_facings2 : String = ""
    var scent_and_dispenser_pallet_facings2 : String = ""
    var exclusive_end_cap_2 : String = ""

    var brandname3 : String = ""
    var scent_elimination_facings3 : String = ""
    var scent_elimination_pallet_displays3 : String = ""
    var scent_and_dispenser_facings3 : String = ""
    var scent_and_dispenser_pallet_facings3 : String = ""
    var exclusive_end_cap_3 : String = ""

    var brandname4 : String = ""
    var scent_elimination_facings4 : String = ""
    var scent_elimination_pallet_displays4 : String = ""
    var scent_and_dispenser_facings4 : String = ""
    var scent_and_dispenser_pallet_facings4 : String = ""
    var exclusive_end_cap_4 : String = ""

    var brandname5 : String = ""
    var scent_elimination_facings5 : String = ""
    var scent_elimination_pallet_displays5 : String = ""
    var scent_and_dispenser_facings5 : String = ""
    var scent_and_dispenser_pallet_facings5 : String = ""
    var exclusive_end_cap_5 : String = ""

    var brandname6 : String = ""
    var scent_elimination_facings6 : String = ""
    var scent_elimination_pallet_displays6 : String = ""
    var scent_and_dispenser_facings6 : String = ""
    var scent_and_dispenser_pallet_facings6 : String = ""
    var exclusive_end_cap_6 : String = ""

    var brandname7 : String = ""
    var scent_elimination_facings7 : String = ""
    var scent_elimination_pallet_displays7 : String = ""
    var scent_and_dispenser_facings7 : String = ""
    var scent_and_dispenser_pallet_facings7 : String = ""
    var exclusive_end_cap_7 : String = ""

    var were_our_products_priced : Bool = false
    var ask_someone_to_price : Bool = false
    var rep_group : String = ""
    var did_you_leave_seps : Bool = false

    var comments : String = ""
    
    init(createdByUserNum: String,
         store_name: String,
         store_state: String,
         store_city: String,
         photos: String,
         photos_02: String,
         photos_03: String,
         photos_04: String,
         photos_05: String,
         photos_06: String,
         photos_07: String,
         photos_08: String,
         submitedby:String,
         email: String,
         wildlife_product_set_up: Bool,
         wildlife_product_displayed_correctly: Bool,
         discuss_any_issues: Bool,
         product_training: Bool,
         did_you_work_an_event: Bool,
         brandname1: String,
         scent_elimination_facings1: String,
         scent_elimination_pallet_displays1: String,
         scent_and_dispenser_facings1: String,
         scent_and_dispenser_pallet_facings1: String,
         exclusive_end_cap_1: String,
         brandname2: String,
         scent_elimination_facings2: String,
         scent_elimination_pallet_displays2: String,
         scent_and_dispenser_facings2: String,
         scent_and_dispenser_pallet_facings2: String,
         exclusive_end_cap_2: String,
         brandname3: String,
         scent_elimination_facings3: String,
         scent_elimination_pallet_displays3: String,
         scent_and_dispenser_facings3: String,
         scent_and_dispenser_pallet_facings3: String,
         exclusive_end_cap_3: String,
         brandname4: String,
         scent_elimination_facings4: String,
         scent_elimination_pallet_displays4: String,
         scent_and_dispenser_facings4: String,
         scent_and_dispenser_pallet_facings4: String,
         exclusive_end_cap_4: String,
         brandname5: String,
         scent_elimination_facings5: String,
         scent_elimination_pallet_displays5: String,
         scent_and_dispenser_facings5: String,
         scent_and_dispenser_pallet_facings5: String,
         exclusive_end_cap_5: String,
         brandname6: String,
         scent_elimination_facings6: String,
         scent_elimination_pallet_displays6: String,
         scent_and_dispenser_facings6: String,
         scent_and_dispenser_pallet_facings6: String,
         exclusive_end_cap_6: String,
         brandname7: String,
         scent_elimination_facings7: String,
         scent_elimination_pallet_displays7: String,
         scent_and_dispenser_facings7: String,
         scent_and_dispenser_pallet_facings7: String,
         exclusive_end_cap_7: String,
         were_our_products_priced: Bool,
         ask_someone_to_price: Bool,
         rep_group: String,
         did_you_leave_seps: Bool,
         comments: String) {
        
        self.createdByUserNum = createdByUserNum
        self.store_name = store_name
        self.store_state = store_state
        self.store_city = store_city
        self.photos = photos
        self.photos_02 = photos_02
        self.photos_03 = photos_03
        self.photos_04 = photos_04
        self.photos_05 = photos_05
        self.photos_06 = photos_06
        self.photos_07 = photos_07
        self.photos_08 = photos_08
        self.submitedby = submitedby
        self.email = email
        self.wildlife_product_set_up = wildlife_product_set_up
        self.wildlife_product_displayed_correctly = wildlife_product_displayed_correctly
        self.discuss_any_issues = discuss_any_issues
        self.product_training = product_training
        self.did_you_work_an_event = did_you_work_an_event
        self.brandname1 = brandname1
        self.scent_elimination_facings1 = scent_elimination_facings1
        self.scent_elimination_pallet_displays1 = scent_elimination_pallet_displays1
        self.scent_and_dispenser_facings1 = scent_and_dispenser_facings1
        self.scent_and_dispenser_pallet_facings1 = scent_and_dispenser_pallet_facings1
        self.exclusive_end_cap_1 = exclusive_end_cap_1
        self.brandname2 = brandname2
        self.scent_elimination_facings2 = scent_elimination_facings2
        self.scent_elimination_pallet_displays2 = scent_elimination_pallet_displays2
        self.scent_and_dispenser_facings2 = scent_and_dispenser_facings2
        self.scent_and_dispenser_pallet_facings2 = scent_and_dispenser_pallet_facings2
        self.exclusive_end_cap_2 = exclusive_end_cap_2
        self.brandname3 = brandname3
        self.scent_elimination_facings3 = scent_elimination_facings3
        self.scent_elimination_pallet_displays3 = scent_elimination_pallet_displays3
        self.scent_and_dispenser_facings3 = scent_and_dispenser_facings3
        self.scent_and_dispenser_pallet_facings3 = scent_and_dispenser_pallet_facings3
        self.exclusive_end_cap_3 = exclusive_end_cap_3
        self.brandname4 = brandname4
        self.scent_elimination_facings4 = scent_elimination_facings4
        self.scent_elimination_pallet_displays4 = scent_elimination_pallet_displays4
        self.scent_and_dispenser_facings4 = scent_and_dispenser_facings4
        self.scent_and_dispenser_pallet_facings4 = scent_and_dispenser_pallet_facings4
        self.exclusive_end_cap_4 = exclusive_end_cap_4
        self.brandname5 = brandname5
        self.scent_elimination_facings5 = scent_elimination_facings5
        self.scent_elimination_pallet_displays5 = scent_elimination_pallet_displays5
        self.scent_and_dispenser_facings5 = scent_and_dispenser_facings5
        self.scent_and_dispenser_pallet_facings5 = scent_and_dispenser_pallet_facings5
        self.exclusive_end_cap_5 = exclusive_end_cap_5
        self.brandname6 = brandname6
        self.scent_elimination_facings6 = scent_elimination_facings6
        self.scent_elimination_pallet_displays6 = scent_elimination_pallet_displays6
        self.scent_and_dispenser_facings6 = scent_and_dispenser_facings6
        self.scent_and_dispenser_pallet_facings6 = scent_and_dispenser_pallet_facings6
        self.exclusive_end_cap_6 = exclusive_end_cap_6
        self.brandname7 = brandname7
        self.scent_elimination_facings7 = scent_elimination_facings7
        self.scent_elimination_pallet_displays7 = scent_elimination_pallet_displays7
        self.scent_and_dispenser_facings7 = scent_and_dispenser_facings7
        self.scent_and_dispenser_pallet_facings7 = scent_and_dispenser_pallet_facings7
        self.exclusive_end_cap_7 = exclusive_end_cap_7
        self.were_our_products_priced = were_our_products_priced
        self.ask_someone_to_price = ask_someone_to_price
        self.rep_group = rep_group
        self.did_you_leave_seps = did_you_leave_seps
        self.comments = comments
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        dictionary["createdByUserNum"] = createdByUserNum
        dictionary["createdByUserNum"] = createdByUserNum
        dictionary["store_name"] = store_name
        dictionary["store_state"] = store_state
        dictionary["store_city"] = store_city
        dictionary["photos"] = photos
        dictionary["photos_02"] = photos_02
        dictionary["photos_03"] = photos_03
        dictionary["photos_04"] = photos_04
        dictionary["photos_05"] = photos_05
        dictionary["photos_06"] = photos_06
        dictionary["photos_07"] = photos_07
        dictionary["photos_08"] = photos_08
        dictionary["submitedby"] = submitedby
        dictionary["email"] = email
        dictionary["wildlife_product_set_up"] = wildlife_product_set_up
        dictionary["wildlife_product_displayed_correctly"] = wildlife_product_displayed_correctly
        dictionary["discuss_any_issues"] = discuss_any_issues
        dictionary["product_training"] = product_training
        dictionary["did_you_work_an_event"] = did_you_work_an_event
        dictionary["brandname1"] = brandname1
        dictionary["scent_elimination_facings1"] = scent_elimination_facings1
        dictionary["scent_elimination_pallet_displays1"] = scent_elimination_pallet_displays1
        dictionary["scent_and_dispenser_facings1"] = scent_and_dispenser_facings1
        dictionary["scent_and_dispenser_pallet_facings1"] = scent_and_dispenser_pallet_facings1
        dictionary["exclusive_end_cap_1"] = exclusive_end_cap_1
        dictionary["brandname2"] = brandname2
        dictionary["scent_elimination_facings2"] = scent_elimination_facings2
        dictionary["scent_elimination_pallet_displays2"] = scent_elimination_pallet_displays2
        dictionary["scent_and_dispenser_facings2"] = scent_and_dispenser_facings2
        dictionary["scent_and_dispenser_pallet_facings2"] = scent_and_dispenser_pallet_facings2
        dictionary["exclusive_end_cap_2"] = exclusive_end_cap_2
        dictionary["brandname3"] = brandname3
        dictionary["scent_elimination_facings3"] = scent_elimination_facings3
        dictionary["scent_elimination_pallet_displays3"] = scent_elimination_pallet_displays3
        dictionary["scent_and_dispenser_facings3"] = scent_and_dispenser_facings3
        dictionary["scent_and_dispenser_pallet_facings3"] = scent_and_dispenser_pallet_facings3
        dictionary["exclusive_end_cap_3"] = exclusive_end_cap_3
        dictionary["brandname4"] = brandname4
        dictionary["scent_elimination_facings4"] = scent_elimination_facings4
        dictionary["scent_elimination_pallet_displays4"] = scent_elimination_pallet_displays4
        dictionary["scent_and_dispenser_facings4"] = scent_and_dispenser_facings4
        dictionary["scent_and_dispenser_pallet_facings4"] = scent_and_dispenser_pallet_facings4
        dictionary["exclusive_end_cap_4"] = exclusive_end_cap_4
        dictionary["brandname5"] = brandname5
        dictionary["scent_elimination_facings5"] = scent_elimination_facings5
        dictionary["scent_elimination_pallet_displays5"] = scent_elimination_pallet_displays5
        dictionary["scent_and_dispenser_facings5"] = scent_and_dispenser_facings5
        dictionary["scent_and_dispenser_pallet_facings5"] = scent_and_dispenser_pallet_facings5
        dictionary["exclusive_end_cap_5"] = exclusive_end_cap_5
        dictionary["brandname6"] = brandname6
        dictionary["scent_elimination_facings6"] = scent_elimination_facings6
        dictionary["scent_elimination_pallet_displays6"] = scent_elimination_pallet_displays6
        dictionary["scent_and_dispenser_facings6"] = scent_and_dispenser_facings6
        dictionary["scent_and_dispenser_pallet_facings6"] = scent_and_dispenser_pallet_facings6
        dictionary["exclusive_end_cap_6"] = exclusive_end_cap_6
        dictionary["brandname7"] = brandname7
        dictionary["scent_elimination_facings7"] = scent_elimination_facings7
        dictionary["scent_elimination_pallet_displays7"] = scent_elimination_pallet_displays7
        dictionary["scent_and_dispenser_facings7"] = scent_and_dispenser_facings7
        dictionary["scent_and_dispenser_pallet_facings7"] = scent_and_dispenser_pallet_facings7
        dictionary["exclusive_end_cap_7"] = exclusive_end_cap_7
        dictionary["were_our_products_priced"] = were_our_products_priced
        dictionary["ask_someone_to_price"] = ask_someone_to_price
        dictionary["rep_group"] = rep_group
        dictionary["did_you_leave_seps"] = did_you_leave_seps
        dictionary["Comments"] = comments
        
        return dictionary
    }
    
    
}



//As far as i know... in the old APK there was image selection for each brand... i dont know about the design.
//The new APK has image selection after selecting all brands.
