//
//  OfflineReportModal.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 29/06/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation

struct OfflineReportModal : Codable {
    
    var paramsDict : Data!
    var imgArr : [PhotoModal] = []
    
    init(paramsDict: Data , imgArr: [PhotoModal]) {
        
        self.paramsDict = paramsDict
        self.imgArr = imgArr
    }
    
}
