//
//  PhotoModal.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 27/06/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation

struct PhotoModal : Codable {
    
    var id : Int = 0
    var type : String = ""
    var img_ServerPAth : String?
    var img_inDataForm : Data?
    
    init(id: Int, type: String, serverPath: String? = nil , img_inDataForm: Data? = nil) {
        
        self.id = id
        self.type = type
        self.img_ServerPAth = serverPath
        self.img_inDataForm = img_inDataForm
    }
    
    
}
