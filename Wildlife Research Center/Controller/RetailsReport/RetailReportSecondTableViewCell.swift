//
//  RetailReportSecondTableViewCell.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 23/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit

class RetailReportSecondTableViewCell: UITableViewCell {

    @IBOutlet weak var btnResearch: UIButton!
    @IBOutlet weak var iconArraw: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    func setData(_ brandInfo: BrandData) {
        btnResearch.setTitle(brandInfo.brandName, for: .normal)
        
        if brandInfo.allSubmitted {
           highlight()
        } else {
            unHighlight()
        }
        
    }
    
    func setData(_ currentData: String) {
        btnResearch.setTitle(currentData, for: .normal)
        unHighlight()
    }
    
    
    func highlight() {
        btnResearch.layoutSubviews()
        btnResearch.backgroundColor = UIColor.appColor(.highlitedGreen)
//        btnResearch.backgroundColor = UIColor(red: 92/254, green: 148/254, blue: 68/254, alpha: 1)
        btnResearch.setTitleColor(UIColor.white, for: .normal)
        iconArraw.image = #imageLiteral(resourceName: "arrawWhite")
        
        btnResearch.layoutIfNeeded()
        
    }
    
    func unHighlight() {
        btnResearch.backgroundColor = UIColor.appColor(.grayView)
        btnResearch.setTitleColor(UIColor.black, for: .normal)
        iconArraw.image = #imageLiteral(resourceName: "arrawBlack")
        
        btnResearch.layoutIfNeeded()
    }

}
