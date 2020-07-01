//
//  BrandData.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 25/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation

struct BrandData : Codable {
    
    var id : Int?
    var brandName : String!
    var scentData : ScentData!
    var allSubmitted : Bool = false
    
    init(brandName: String, scentData: ScentData, allSubmitted : Bool) {
        
        self.brandName = brandName
        self.scentData = scentData
        self.allSubmitted = allSubmitted
    }
    
    init(id: Int? = nil, brandName: String, scentData: ScentData, allSubmitted : Bool ) {
        
        self.id = id
        self.brandName = brandName
        self.scentData = scentData
        self.allSubmitted = allSubmitted
    }
}
