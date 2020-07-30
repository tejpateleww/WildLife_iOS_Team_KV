//
//  RetailReportSecondViewController.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 23/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit

class RetailReportSecondViewController: UIViewController {

    //MARK:- Outlets:
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var constantHeightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var btnNext: ThemeButton!
    
    //MARK:- Properyies:
    private var aryData = ["Wildlife Research Center",
                    "Tink's / Dead Down Wind",
                    "Hunter's Specialties/ Buck Bomb",
                    "Code Blue",
                    "Conquest",
                    "Nose Jammer",
                    "Other"]
    
    var brandArr : [BrandData] = []
    
    
    //MARK:- LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let brandarr = userDefault.object(forKey: UserDefaultsKey.brandArr.rawValue) as? Data
               if brandarr != nil {
                   let brandar = try? PropertyListDecoder().decode(Array<BrandData>.self, from: brandarr!)
                   self.brandArr = brandar!
               }
        
        if brandArr.count == 0 {
            for i in 0..<7 {
                let data = BrandData(id: i+1, brandName: aryData[i], scentData: ScentData(scent_Elimination_Facings: 0, scent_Elimination_Pallet_Displays: 0, scent_And_Dispenser_Facings: 0, scent_And_Dispenser_Pallet_Displays: 0, does_this_Brand_have_An_Exclusive_EndCap: 0, scent_elimination_end_cap: 0 ), allSubmitted: false)
                
                self.brandArr.append(data)
            }
            
            let arrdata = try? PropertyListEncoder().encode(brandArr)
            userDefault.set(arrdata, forKey: UserDefaultsKey.brandArr.rawValue)
        }
        
        setNavBarWithMenuORBack(Title: "Retail Report", leftButton: "back", IsNeedRightButton: true, isTranslucent: false)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        constantHeightOfTableView.constant = tableView.contentSize.height
        
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let brandarr = userDefault.object(forKey: UserDefaultsKey.brandArr.rawValue) as? Data
        if brandarr != nil {
            let brandar = try? PropertyListDecoder().decode(Array<BrandData>.self, from: brandarr!)
            self.brandArr = brandar!
        }
        
        var isEnabled : Bool = false
        brandArr.forEach { (data) in
            if data.allSubmitted == true {
                isEnabled = true
            }
        }
        if isEnabled {
            btnNext.isGrayButton = false
            btnNext.awakeFromNib()
        }

        self.tableView.reloadData()
    }
    
    //MARK:- Events:
    
    @IBAction func nextBtnPressed(_ sender: ThemeButton) {
        
//        var atleastOneSelected = false
//        self.brandArr.forEach { (brand) in
//            if brand.allSubmitted == true {
//                atleastOneSelected = true
//            }
//        }
        
//        if atleastOneSelected {
        
        
        
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RetailReportThirdViewController") as! RetailReportThirdViewController
            self.navigationController?.pushViewController(vc, animated: true)
//        } else {
//            Utilities.displayAlert("You must fill details of atleast one brand to submit your report")
//        }
       
    }
}


extension RetailReportSecondViewController: UITableViewDataSource, UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RetailReportSecondTableViewCell", for: indexPath) as! RetailReportSecondTableViewCell
        cell.selectionStyle = .none
        
        cell.setData(aryData[indexPath.row])
        
        brandArr.forEach { (brand) in
            if brand.brandName == aryData[indexPath.row] {
                cell.setData(brand)
            }
        }
        
        cell.btnResearch.setNeedsLayout()
//        cell.btnResearch.layoutSubviews()
//        cell.layoutSubviews()
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RetailReportViewController") as! RetailReportViewController
        
//        vc.brandName = brandArr[indexPath.row].brandName
        vc.brandName = aryData[indexPath.row]
        vc.brandID = (indexPath.row + 1)
        
        // To Display the Data on next page if available
        if brandArr.count >= indexPath.row + 1 {
            let data = brandArr[indexPath.row].scentData!
            
            vc.submitted = brandArr[indexPath.row].allSubmitted
            
            vc.fillData_1 = data.scent_Elimination_Facings ?? 00
            vc.fillData_2 = data.scent_Elimination_Pallet_Displays ?? 00
            vc.fillData_3 = data.scent_And_Dispenser_Facings ?? 00
            vc.fillData_4 = data.scent_And_Dispenser_Pallet_Displays ?? 00
            vc.fillData_5 = data.does_this_Brand_have_An_Exclusive_EndCap ?? 00
            
            vc.fillData_6 = data.scent_elimination_end_cap ?? 00
            
            vc.selectedValue_1 = "\(data.scent_Elimination_Facings ?? 00)"
            vc.selectedValue_2 = "\(data.scent_Elimination_Pallet_Displays ?? 00)"
            vc.selectedValue_3 = "\(data.scent_And_Dispenser_Facings ?? 00)"
            vc.selectedValue_4 = "\(data.scent_And_Dispenser_Pallet_Displays ?? 00)"
            vc.selectedValue_5 = "\(data.does_this_Brand_have_An_Exclusive_EndCap ?? 00)"
            
            vc.selectedValue_6 = "\(data.scent_elimination_end_cap ?? 00)"
            
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


