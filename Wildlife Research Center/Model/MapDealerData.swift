//
//  MapDealerData.swift
//  Wildlife Research Center
//
//  Created by EWW074 - Sj's iMAC on 02/07/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MapDealerData : Codable {
    
    var num : String = ""
    var createdDate : String = ""
    var createdByUserNum : String = ""
    var updatedDate : String = ""
    var updatedByUserNum : String = ""
    var dragSortOrder : String = ""
    var title : String = ""
    var address : String = ""
    var city : String = ""
    var state : String = ""
    var zip : String = ""
    var phone : String = ""
    var website : String = ""
    var latitude : String = ""
    var longitude : String = ""
    var store : String = ""
    
    
    init(json: JSON) {
        
        num = json["num"].stringValue
        createdDate = json["createdDate"].stringValue
        createdByUserNum = json["createdDate"].stringValue
        updatedDate = json["updatedDate"].stringValue
        updatedByUserNum = json["updatedByUserNum"].stringValue
        dragSortOrder = json["updatedByUserNum"].stringValue
        title = json["title"].stringValue
        address = json["address"].stringValue
        city = json["city"].stringValue
        state = json["state"].stringValue
        zip = json["zip"].stringValue
        phone = json["zip"].stringValue
        website = json["website"].stringValue
        latitude = json["latitude"].stringValue
        longitude = json["longitude"].stringValue
        store = json["store"].stringValue
    }
}
