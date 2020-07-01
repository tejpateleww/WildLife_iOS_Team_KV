//
//  SubmitMaster.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 29/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation

struct SubmitMaster : Codable {
    
    var isStoreAddedManually : Bool = false
    var imgUploads : Int = 0
    var imgArr : [Data]
    var submitModal : SubmitReport?
    
    init(isStoreAddedManually: Bool, imgUploads: Int, submitModal: SubmitReport, imgArrData: [Data]) {
        self.isStoreAddedManually = isStoreAddedManually
        self.imgUploads = imgUploads
        self.submitModal = submitModal
        
        self.imgArr = imgArrData
    }
}
