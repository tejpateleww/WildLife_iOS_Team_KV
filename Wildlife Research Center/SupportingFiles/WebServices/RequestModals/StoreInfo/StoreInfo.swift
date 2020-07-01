//
//  StoreInfo.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 18/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import SwiftyJSON

struct StoreInfo : Codable {
    
    var storeName : String!
    var stateName: String!
    var cityName: String!
    var retailStoreQuestions_Arr : [RetailsStoreQuestion] = []
    
    var isStoreAddedManually : Bool?
    
    init(store: String, state: String, city: String, retailStoreQuestions_Arr : [RetailsStoreQuestion] = [], isStoreAddedManually: Bool)
    {
        self.storeName = store
        self.stateName = state
        self.cityName = city
        
        self.retailStoreQuestions_Arr = retailStoreQuestions_Arr
        
        self.isStoreAddedManually = isStoreAddedManually
    }
       
}
