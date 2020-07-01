//
//  SelectStoreTableViewCell.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 19/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit

protocol SelectStoreTableViewCellDelegate : AnyObject{
    func selectStoreTblViewCell(_ selectStoreTblViewCell: SelectStoreTableViewCell, selectBtnTappedFor StoreList: StoreList)
}

class SelectStoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblStoreAddress: UILabel!
    @IBOutlet weak var btnSelect: ThemeButton!
    
    weak var delegate : SelectStoreTableViewCellDelegate?
    
    var storeAt : StoreList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.btnSelect.addTarget(self, action: #selector(selectBtnTapped), for: .touchUpInside)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func selectBtnTapped() {
        if let storeAt = storeAt,
            let _ = delegate {

            self.delegate?.selectStoreTblViewCell(self, selectBtnTappedFor: storeAt)
            
        }
    }

}
