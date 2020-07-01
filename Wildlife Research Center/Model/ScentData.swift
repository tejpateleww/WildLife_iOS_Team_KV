//
//  ScentData.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 25/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation

struct ScentData : Codable {
    var scent_Elimination_Facings : Int!
    var scent_Elimination_Pallet_Displays : Int!
    var scent_And_Dispenser_Facings : Int!
    var scent_And_Dispenser_Pallet_Displays : Int!
    var does_this_Brand_have_An_Exclusive_EndCap : Int!
    
    init(scent_Elimination_Facings: Int, scent_Elimination_Pallet_Displays : Int, scent_And_Dispenser_Facings: Int, scent_And_Dispenser_Pallet_Displays : Int, does_this_Brand_have_An_Exclusive_EndCap : Int ) {
        
        self.scent_Elimination_Facings = scent_Elimination_Facings
        self.scent_Elimination_Pallet_Displays = scent_Elimination_Pallet_Displays
        self.scent_And_Dispenser_Facings = scent_And_Dispenser_Facings
        self.scent_And_Dispenser_Pallet_Displays = scent_And_Dispenser_Pallet_Displays
        self.does_this_Brand_have_An_Exclusive_EndCap = does_this_Brand_have_An_Exclusive_EndCap
    }
}
