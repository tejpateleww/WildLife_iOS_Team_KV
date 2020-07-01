//
//  ReportListTableViewCell.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 24/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReportListTableViewCell: UITableViewCell {
    
    var isRemoved: (() -> Void)?

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblStoreTitle: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var btnRemove: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtViewDescription.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(submitMaster: SubmitMaster) {
        
        self.lblName.text = submitMaster.submitModal?.submitedby
        self.lblEmail.text = submitMaster.submitModal?.email
        self.lblStoreName.text = submitMaster.submitModal?.store_name
        self.txtViewDescription.text = submitMaster.submitModal?.comments
    }
    
    func setup1(offlineReport_ParamsDict : [String:Any]) {
        
        self.lblName.text = offlineReport_ParamsDict["submitedby"] as? String
        self.lblEmail.text = offlineReport_ParamsDict["email"] as? String
        self.lblStoreName.text = offlineReport_ParamsDict["store_name"] as? String
        let str = offlineReport_ParamsDict["comments"] as? String
//        let trimm = str?.filter {!$0.isNewline}
        self.txtViewDescription.text = str!.trimmedString
        
        
        
    }
    
    @IBAction func RemoveBtnPressed(_ sender: UIButton) {
        isRemoved!()
    }

}
