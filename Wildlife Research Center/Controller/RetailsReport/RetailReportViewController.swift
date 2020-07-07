//
//  RetailReportViewController.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 23/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit

class RetailReportViewController: UIViewController {

    @IBOutlet weak var btnScentEliminationFacings: UIButton!
    @IBOutlet weak var btnScentElimination_PalletDisplays: UIButton!
    @IBOutlet weak var btnScentAndDispenserFacings: UIButton!
    @IBOutlet weak var btnScentAndDispenser_PalletDisplays: UIButton!
    @IBOutlet weak var btnExclusiveEndcap: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    
    var pickerView: UIPickerView?
    var selectedTag = Int()
    var selectedValue = "Select"
    let textField = UITextField(frame: .zero)
    var aryItems = [String]()

    var brandName : String = ""
    
    var brandID : Int = 0
    
    var arr_1 : [String] = (0...500).map{$0}.map{"\($0)".count == 1 ? "0\($0)" : "\($0)"}
    var arr_2 : [String] = (0...25).map{$0}.map{"\($0)".count == 1 ? "0\($0)" : "\($0)"}
    var arr_3 : [String] = (0...500).map{$0}.map{"\($0)".count == 1 ? "0\($0)" : "\($0)"}
    var arr_4 : [String] = (0...25).map{$0}.map{"\($0)".count == 1 ? "0\($0)" : "\($0)"}
    var arr_5 : [String] = (0...5).map{$0}.map{"\($0)".count == 1 ? "0\($0)" : "\($0)"}
    
    var selectedValue_1 = "Select"
    var selectedValue_2 = "Select"
    var selectedValue_3 = "Select"
    var selectedValue_4 = "Select"
    var selectedValue_5 = "Select"
    
    var p1Index : Int = 0
    var p2Index : Int = 0
    var p3Index : Int = 0
    var p4Index : Int = 0
    var p5Index : Int = 0
    
    var fillData_1 = 0
    var fillData_2 = 0
    var fillData_3 = 0
    var fillData_4 = 0
    var fillData_5 = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        aryItems = (1...25).map{$0}.map{"\($0 * 0)"}

        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBarWithMenuORBack(Title: brandName, leftButton: "back", IsNeedRightButton: true, isTranslucent: false)
        
        setBtnTitles()
    }
    
    
    @IBAction func btnTapAction_HowToCountFacingsLink(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    
    func setBtnTitles() {
        
        if fillData_1 == 0 {
            btnScentEliminationFacings.setTitle("Select", for: .normal)
        } else {
            btnScentEliminationFacings.setTitle("\(fillData_1)", for: .normal)
        }
        p1Index = fillData_1
        
        if fillData_2 == 0 {
             btnScentElimination_PalletDisplays.setTitle("Select", for: .normal)
        } else {
            btnScentElimination_PalletDisplays.setTitle("\(fillData_2)", for: .normal)
        }
        p2Index = fillData_2
        
        if fillData_3 == 0 {
            btnScentAndDispenserFacings.setTitle("Select", for: .normal)
        } else {
            btnScentAndDispenserFacings.setTitle("\(fillData_3)", for: .normal)
        }
        p3Index = fillData_3
        
        if fillData_4 == 0 {
            btnScentAndDispenser_PalletDisplays.setTitle("Select", for: .normal)
        } else {
            btnScentAndDispenser_PalletDisplays.setTitle("\(fillData_4)", for: .normal)
        }
        p4Index = fillData_4
        
        if fillData_5 == 0 {
            btnExclusiveEndcap.setTitle("Select", for: .normal)
        } else {
            btnExclusiveEndcap.setTitle("\(fillData_5)", for: .normal)
        }
        p5Index = fillData_5
        
    }
    
    //MARK:- Events

    @IBAction func btnScentEliminationAction(_ sender: UIButton) {
        
        btnScentEliminationFacings.layer.borderWidth = 0
        btnScentElimination_PalletDisplays.layer.borderWidth = 0
        btnScentAndDispenserFacings.layer.borderWidth = 0
        btnScentAndDispenser_PalletDisplays.layer.borderWidth = 0
        btnExclusiveEndcap.layer.borderWidth = 0
        
        selectedValue = "Select"
        selectedTag = sender.tag
        
        pickerView?.reloadComponent(0)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneButtonTapped));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        textField.inputAccessoryView = toolbar
        textField.inputView = pickerView
//        textField.isHidden = true
        self.view.addSubview(textField)
        textField.becomeFirstResponder()
        
        switch sender.tag {
        case 1:
            pickerView?.selectRow(p1Index, inComponent: 0, animated: true)
            
        case 2:
            pickerView?.selectRow(p2Index, inComponent: 0, animated: true)
            
        case 3:
            pickerView?.selectRow(p3Index, inComponent: 0, animated: true)
            
        case 4:
            pickerView?.selectRow(p4Index, inComponent: 0, animated: true)
            
        case 5:
            pickerView?.selectRow(p5Index, inComponent: 0, animated: true)
            
            
        default:
            pickerView!.selectRow(0, inComponent: 0, animated: false)
        }
    }
    
    @objc func doneButtonTapped() {
        
        switch selectedTag {
           case 1:
            if selectedValue_1 == "00" || selectedValue_1 == "0" {
                btnScentEliminationFacings.setTitle("Select", for: .normal)
            } else {
                btnScentEliminationFacings.setTitle(selectedValue_1, for: .normal)
            }
            
           case 2:
            if selectedValue_2 == "00" || selectedValue_2 == "0" {
                btnScentElimination_PalletDisplays.setTitle("Select", for: .normal)
            } else {
                btnScentElimination_PalletDisplays.setTitle(selectedValue_2, for: .normal)
            }
            
           case 3:
            if selectedValue_3 == "00" || selectedValue_3 == "0" {
                btnScentAndDispenserFacings.setTitle("Select", for: .normal)
            } else {
                btnScentAndDispenserFacings.setTitle(selectedValue_3, for: .normal)
            }
            
           case 4:
            if selectedValue_4 == "00" || selectedValue_4 == "0" {
                btnScentAndDispenser_PalletDisplays.setTitle("Select", for: .normal)
            } else {
                btnScentAndDispenser_PalletDisplays.setTitle(selectedValue_4, for: .normal)
            }
            
           case 5:
            if selectedValue_5 == "00" || selectedValue_5 == "0" {
                btnExclusiveEndcap.setTitle("Select", for: .normal)
            } else {
                btnExclusiveEndcap.setTitle(selectedValue_5, for: .normal)
            }
            
           default:
               print("")
        }
        textField.removeFromSuperview()
        view.endEditing(true)
    }
    
     @objc func cancelDatePicker() {
        textField.removeFromSuperview()
        view.endEditing(true)
    }
    
    
    @IBAction func btnSubmitPressed(_ sender: ThemeButton) {
        
        
        // Store all the values - button titles to a modal.
        let a = Int(btnScentEliminationFacings.title(for: .normal)!) ?? 0
        let b = Int(btnScentElimination_PalletDisplays.title(for: .normal)!) ?? 0
        let c = Int(btnScentAndDispenserFacings.title(for: .normal)!) ?? 0
        let d = Int(btnScentAndDispenser_PalletDisplays.title(for: .normal)!) ?? 0
        let e = Int(btnExclusiveEndcap.title(for: .normal)!) ?? 0
        
        if a == 00 || a == 0 {
            btnScentEliminationFacings.layer.borderWidth = 0.5
            btnScentEliminationFacings.layer.borderColor = UIColor.red.cgColor
        }
        
        if b == 00 || b == 0 {
            btnScentElimination_PalletDisplays.layer.borderWidth = 0.5
            btnScentElimination_PalletDisplays.layer.borderColor = UIColor.red.cgColor
        }
        
        if c == 00 || c == 0 {
            btnScentAndDispenserFacings.layer.borderWidth = 0.5
            btnScentAndDispenserFacings.layer.borderColor = UIColor.red.cgColor
        }
        
        if d == 00 || d == 0 {
            btnScentAndDispenser_PalletDisplays.layer.borderWidth = 0.5
            btnScentAndDispenser_PalletDisplays.layer.borderColor = UIColor.red.cgColor
        }
        
        if e == 00 || e == 0 {
            btnExclusiveEndcap.layer.borderWidth = 0.5
            btnExclusiveEndcap.layer.borderColor = UIColor.red.cgColor
        }
        
        guard a > 0, b > 0, c > 0, d > 0, e > 0 else {
            
            let alert = UIAlertController(title: AppInfo.appName, message: "Please select all the values", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let scentData = ScentData(scent_Elimination_Facings: a,
                                  scent_Elimination_Pallet_Displays: b,
                                  scent_And_Dispenser_Facings: c,
                                  scent_And_Dispenser_Pallet_Displays: d,
                                  does_this_Brand_have_An_Exclusive_EndCap: e)
        
        let brandData = BrandData(id: brandID, brandName: self.brandName, scentData: scentData, allSubmitted: true)
        
        
        let data = try? PropertyListEncoder().encode(brandData)
        userDefault.set(data, forKey: UserDefaultsKey.brandData.rawValue)
        
        
        
        var br : [BrandData] = []
        let brandarr = userDefault.object(forKey: UserDefaultsKey.brandArr.rawValue) as? Data
        if brandarr != nil {
            let brandar = try? PropertyListDecoder().decode(Array<BrandData>.self, from: brandarr!)
            br = brandar!
        }
        
        for i in 0..<br.count {
            if br[i].brandName == brandData.brandName {
                br[i] = brandData
            }
        }
        
        let arrdata = try? PropertyListEncoder().encode(br)
        userDefault.set(arrdata, forKey: UserDefaultsKey.brandArr.rawValue)
        
        self.navigationController?.popViewController(animated: true)
    }
      
}


extension RetailReportViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch selectedTag {
        case 1:
            return arr_1.count
        case 2:
            return arr_2.count
        case 3:
            return arr_3.count
        case 4:
            return arr_4.count
        case 5:
            return arr_5.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch selectedTag {
        case 1:
            if arr_1[row] == "00" || arr_1[row] == "0" { return "Select" } else { return arr_1[row] }
            
        case 2:
            if arr_2[row] == "00" || arr_2[row] == "0" { return "Select" } else { return arr_2[row] }
            
        case 3:
            if arr_3[row] == "00" || arr_3[row] == "0" { return "Select" } else { return arr_3[row] }
            
        case 4:
            if arr_4[row] == "00" || arr_4[row] == "0" { return "Select" } else { return arr_4[row] }
            
        case 5:
            if arr_5[row] == "00" || arr_5[row] == "0" { return "Select" } else { return arr_5[row] }
        
        default:
            return "Select"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch selectedTag {
        case 1:
            selectedValue_1 = arr_1[row]
            p1Index = row
            
        case 2:
            selectedValue_2 = arr_2[row]
           p2Index = row
            
        case 3:
            selectedValue_3 = arr_3[row]
            p3Index = row
            
        case 4:
            selectedValue_4 = arr_4[row]
            p4Index = row
            
        case 5:
            selectedValue_5 = arr_5[row]
            p5Index = row
            
        default:
            selectedValue = ""
            p1Index = 0 ; p2Index = 0 ; p3Index = 0 ; p4Index = 0 ; p5Index = 0
        }
        
    }
}
