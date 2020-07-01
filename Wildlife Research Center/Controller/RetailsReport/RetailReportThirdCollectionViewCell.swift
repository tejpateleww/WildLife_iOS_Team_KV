//
//  RetailReportThirdCollectionViewCell.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 25/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit

class RetailReportThirdCollectionViewCell: UICollectionViewCell {
    
    var isRemoved: (() -> Void)?
    
    
    @IBOutlet weak var imgPicked: UIImageView!
    @IBOutlet weak var btnRemove: UIButton!
    
    @IBAction func btnRemovedAction(_ sender: UIButton) {
        isRemoved!()
    }
    
    
}
