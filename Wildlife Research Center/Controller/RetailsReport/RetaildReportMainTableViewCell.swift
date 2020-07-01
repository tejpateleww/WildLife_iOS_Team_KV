//
//  RetaildReportMainTableViewCell.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 24/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit

class RetaildReportMainTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSwitch: UIButton!
    
    var switchTapped : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ currentItem: String, isOn: Bool) {
        let on = #imageLiteral(resourceName: "switchOn")
        let off = #imageLiteral(resourceName: "switchOff")
        lblTitle.text = currentItem
        btnSwitch.setImage(isOn ? on : off, for: .normal)
    }
    
    @IBAction func btnSwitchAction(_ sender: Any) {
        switchTapped!()
    }
    
    
    

}
