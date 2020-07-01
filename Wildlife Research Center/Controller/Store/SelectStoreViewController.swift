//
//  SelectStoreViewController.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 24/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit

class SelectStoreViewController: UIViewController {
    
    //MARK:- Outlets:
    
    @IBOutlet weak var btnStoreName: UIButton!
    @IBOutlet weak var btnStateName: UIButton!
    @IBOutlet weak var btnStoreName_Manually: UIButton!
    @IBOutlet weak var btnStateName_Manually: UIButton!
    @IBOutlet weak var btnCityName_Manually: UIButton!
    
    @IBOutlet weak var btnGetListOfStores: ThemeButton!
    @IBOutlet weak var btnUseThisStore: ThemeButton!
    
    @IBOutlet weak var vwTopSection: UIView!
    @IBOutlet weak var vwbottomSection: UIView!
    
    
    //MARK:- Properties:
    var storeList : [String] = ["Select"]
    var stateList : [String] = ["Select"]
    var cityList : [String] = ["Select"]

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
    
    var pickerView: UIPickerView?
    var selectedTag = Int()
    var selectedValue = "Select"
    
    let textField = UITextField(frame: .zero)
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self
        
        webServiceforLists()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBarWithMenuORBack(Title: "Select Store", leftButton: "back", IsNeedRightButton: false, isTranslucent: false, isRounded: false)
    }
    
    override func viewDidLayoutSubviews() {
        vwTopSection.clipsToBounds = true
        vwTopSection.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        vwbottomSection.clipsToBounds = true
        vwbottomSection.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    
    //MARK:- Events
    
    @IBAction func getListOfStores_BtnPressed(_ sender: Any) {
        
        
        if btnStoreName.title(for: .normal) == "Select" {
            btnStoreName.layer.borderWidth = 0.5
            btnStoreName.layer.borderColor = UIColor.red.cgColor
        }
        
        if btnStateName.title(for: .normal) == "Select" {
            btnStateName.layer.borderWidth = 0.5
            btnStateName.layer.borderColor = UIColor.red.cgColor
        }
    
        
        guard btnStateName.title(for: .normal) != "Select" && btnStoreName.title(for: .normal) != "Select" else {
            showAlert(msg: "Please Select a value")
            return
        }

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectLocationViewController") as! SelectLocationViewController
        vc.state = btnStateName.title(for: .normal)!
        vc.store = btnStoreName.title(for: .normal)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func useThisStore_BtnPressed(_ sender: Any) {
        
        if btnStoreName_Manually.title(for: .normal) == "Select" {
            btnStoreName_Manually.layer.borderWidth = 0.5
            btnStoreName_Manually.layer.borderColor = UIColor.red.cgColor
        }
        
        
        if btnStateName_Manually.title(for: .normal) == "Select" {
            btnStateName_Manually.layer.borderWidth = 0.5
            btnStateName_Manually.layer.borderColor = UIColor.red.cgColor
        }
        
        
        if btnCityName_Manually.title(for: .normal) == "Select" {
            btnCityName_Manually.layer.borderWidth = 0.5
            btnCityName_Manually.layer.borderColor = UIColor.red.cgColor
        }
        
        
    
        guard btnStoreName_Manually.title(for: .normal) != "Select" else { showAlert(msg: "Please Select a value")
            return
        }
        guard btnStateName_Manually.title(for: .normal) != "Select" else { showAlert(msg: "Please Select a value")
            return
        }
        guard btnCityName_Manually.title(for: .normal) != "Select" else { showAlert(msg: "Please Select a value")
            return
        }
        
        guard WebService.shared.isConnected else {
            Utilities.displayAlert("You must be connected to the internet to add store manually")
            return
        }
        
        webService_AddStoreManually()
    }
    
    
    
    // Whenever user presses a button to open a picker to choose state / store / city
    @IBAction func btnDropDownAction(_ sender: UIButton) {
        
        
        btnStoreName.layer.borderWidth = 0
        btnStateName.layer.borderWidth = 0
        btnStoreName_Manually.layer.borderWidth = 0
        btnStateName_Manually.layer.borderWidth = 0
        btnCityName_Manually.layer.borderWidth = 0
        
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
        self.view.addSubview(textField)
        textField.becomeFirstResponder()
        
        
        switch sender.tag {
        case 1:
            let str = sender.title(for: .normal)
            p1Index = self.storeList.firstIndex(of: str!)!
            selectedValue = str!
            pickerView?.selectRow(p1Index, inComponent: 0, animated: true)
        
        case 2:
            let str = sender.title(for: .normal)
            p2Index = self.stateList.firstIndex(of: str!)!
            selectedValue = str!
            pickerView?.selectRow(p2Index, inComponent: 0, animated: true)
        
        case 3:
            
            let str = sender.title(for: .normal)
            p3Index = self.storeList.firstIndex(of: str!)!
            selectedValue = str!
            pickerView?.selectRow(p3Index, inComponent: 0, animated: true)
        
        case 4:
            let str = sender.title(for: .normal)
            p4Index = self.stateList.firstIndex(of: str!)!
            selectedValue = str!
            pickerView?.selectRow(p4Index, inComponent: 0, animated: true)
        
        case 5:
            let str = sender.title(for: .normal)
            p5Index = self.cityList.firstIndex(of: str!)!
            selectedValue = str!
            pickerView?.selectRow(p5Index, inComponent: 0, animated: true)
        
        default:
            pickerView!.selectRow(0, inComponent: 0, animated: false)
        }
        
    }
    
    // Custom ToolBar -> Done btn Tap -> handles the selected value in picker
    @objc func doneButtonTapped() {
        
        switch selectedTag {
        case 1:
            btnStoreName.setTitle(selectedValue_1, for: .normal)
            if btnStateName.currentTitle! != "Select" && btnStoreName.currentTitle != "Select" {
                ChangeThemeFor_btn_GetListOfStore()
            } else {
                reset_btnGetListOfStore()
            }
            
        case 2:
            btnStateName.setTitle(selectedValue_2, for: .normal)
            if btnStoreName.currentTitle! != "Select" && btnStateName.currentTitle != "Select" {
                ChangeThemeFor_btn_GetListOfStore()
            } else {
                reset_btnGetListOfStore()
            }
            
        case 3:
            btnStoreName_Manually.setTitle(selectedValue_3, for: .normal)
            if btnCityName_Manually.currentTitle! != "Select" && btnStateName_Manually.currentTitle! != "Select" && btnStoreName.currentTitle != "Select" {
                ChangeThemeFor_btn_UseThisStore()
            } else {
                reset_btnUseThisStore()
            }
            
        case 4:
            btnStateName_Manually.setTitle(selectedValue_4, for: .normal)
            if btnStoreName_Manually.currentTitle! != "Select" && btnCityName_Manually.currentTitle! != "Select" && btnStateName.currentTitle != "Select"  {
                ChangeThemeFor_btn_UseThisStore()
            } else {
                reset_btnUseThisStore()
            }
            
        case 5:
            btnCityName_Manually.setTitle(selectedValue_5, for: .normal)
            if btnStoreName_Manually.currentTitle! != "Select" && btnStateName_Manually.currentTitle! != "Select" && btnCityName_Manually.currentTitle != "Select"  {
                ChangeThemeFor_btn_UseThisStore()
            } else {
                reset_btnUseThisStore()
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
    
    
    
    //MARK:- API Call
    
    func webServiceforLists() {
        
        if WebService.shared.isConnected {
            WebServiceSubClass.storeStateCityListsApi(showhud: true) { (json, success, resp) in
                if success {
                    let storeJson = json["title_list"].arrayValue
                    storeJson.forEach { (eachStore) in
                        self.storeList.append(eachStore.stringValue)
                    }
                    let storeNamesData = try? PropertyListEncoder().encode(self.storeList)
                    userDefault.set(storeNamesData, forKey: UserDefaultsKey.storeNames.rawValue)
                    
                    
                    let stateJson = json["state_list"].arrayValue
                    stateJson.forEach { (eachState) in
                        self.stateList.append(eachState.stringValue)
                    }
                    let stateNameData = try? PropertyListEncoder().encode(self.stateList)
                    userDefault.set(stateNameData, forKey: UserDefaultsKey.stateNames.rawValue)
                    
                    let cityJson = json["city_list"].arrayValue
                    cityJson.forEach { (eachCity) in
                        self.cityList.append(eachCity.stringValue)
                    }
                    let cityNameData = try? PropertyListEncoder().encode(self.cityList)
                    userDefault.set(cityNameData, forKey: UserDefaultsKey.cityNames.rawValue)
                    
                    
                    let isStoreSelected = userDefault.value(forKey: UserDefaultsKey.isStoreSelected.rawValue) as? Bool
                    if isStoreSelected != nil && isStoreSelected! {
                        
                        guard let storeData = userDefault.object(forKey: UserDefaultsKey.storeInfo.rawValue) as? Data else { return }
                        guard let storeinfo = try? PropertyListDecoder().decode(StoreInfo.self, from: storeData) else { return }
                        
                        if storeinfo.isStoreAddedManually! {
                            self.btnStoreName_Manually.setTitle(storeinfo.storeName, for: .normal)
                            self.btnStateName_Manually.setTitle(storeinfo.stateName, for: .normal)
                            self.btnCityName_Manually.setTitle(storeinfo.cityName, for: .normal)
                            
                            if self.btnStoreName_Manually.currentTitle! != "Select" && self.btnStateName_Manually.currentTitle! != "Select" && self.btnCityName_Manually.currentTitle != "Select"  {
                                self.ChangeThemeFor_btn_UseThisStore()
                            } else {
                                self.reset_btnUseThisStore()
                            }
                            
                        } else {
                            self.btnStateName.setTitle(storeinfo.stateName, for: .normal)
                            self.btnStoreName.setTitle(storeinfo.storeName, for: .normal)
                            
                            if self.btnStoreName.currentTitle! != "Select" && self.btnStateName.currentTitle != "Select" {
                                self.ChangeThemeFor_btn_GetListOfStore()
                            } else {
                                self.reset_btnGetListOfStore()
                            }
                            
                        }
                    }
                    
                } else {
                    self.showAlert(msg: json["message"].stringValue)
                }
            }
        } else {
            // In offline Mode : Bring the Data stored in User Defaults from the previous calls..
            
            guard let storeNameData = userDefault.object(forKey: UserDefaultsKey.storeNames.rawValue) as? Data else {
                 self.showAlert(msg: "No Internet Connectivity")
                return }
            guard let finalStoreList = try? PropertyListDecoder().decode(Array<String>.self, from: storeNameData) else { return }
            self.storeList = finalStoreList
            
            guard let stateNameData = userDefault.object(forKey: UserDefaultsKey.stateNames.rawValue) as? Data else {
                self.showAlert(msg: "No Internet Connectivity")
                return }
            guard let finalStateList = try? PropertyListDecoder().decode(Array<String>.self, from: stateNameData) else { return }
            self.stateList = finalStateList
            
            guard let cityNameData = userDefault.object(forKey: UserDefaultsKey.cityNames.rawValue) as? Data else {
                self.showAlert(msg: "No Internet Connectivity")
                return }
            guard let finalCityList = try? PropertyListDecoder().decode(Array<String>.self, from: cityNameData) else { return }
            self.cityList = finalCityList
            
            if self.storeList.count < 3 && self.stateList.count < 3 && self.cityList.count < 3 {
                self.showAlert(msg: "No Internet Connectivity")
                
            }
        }
    }
    
    
    func webService_AddStoreManually() {
        guard let storetxt = btnStoreName_Manually.title(for: .normal), storetxt != "", storetxt != "Select" else { return }
        guard let statetxt = btnStateName_Manually.title(for: .normal), statetxt != "", statetxt != "Select" else { return }
        guard let citytxt = btnCityName_Manually.title(for: .normal), citytxt != "", citytxt != "Select" else { return }
        
        WebServiceSubClass.addStoreManually(store: storetxt, state: statetxt, city: citytxt, showhud: true) { (json, success, resp) in
            if success {
                
                // Store info Will be thr if first tym then all values will be "Select" and switch data will be used.
                guard let storeData = userDefault.object(forKey: UserDefaultsKey.storeInfo.rawValue) as? Data else { return }
                guard let storeinfo = try? PropertyListDecoder().decode(StoreInfo.self, from: storeData) else { return }
                
                let nwStore = StoreInfo(store: storetxt, state: statetxt, city: citytxt, retailStoreQuestions_Arr: storeinfo.retailStoreQuestions_Arr, isStoreAddedManually: true)
                let data = try? PropertyListEncoder().encode(nwStore)
                userDefault.set(data, forKey: UserDefaultsKey.storeInfo.rawValue)
                
                userDefault.set(true, forKey: UserDefaultsKey.isStoreSelected.rawValue)
                
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showAlert(msg: json["message"].stringValue)
            }
        }
        
    }

    func showAlert(msg: String) {
        let alert = UIAlertController(title: AppInfo.appName, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}


extension SelectStoreViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch selectedTag {
        case 1:
            return storeList.count
        case 2:
            return stateList.count
        case 3:
            return storeList.count
        case 4:
            return stateList.count
        case 5:
            return cityList.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch selectedTag {
        case 1:
            return storeList[row]
        case 2:
            return stateList[row]
        case 3:
            return storeList[row]
        case 4:
            return stateList[row]
        case 5:
            return cityList[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard storeList.count != 0 else {return}
        guard stateList.count != 0 else {return}
        guard cityList.count != 0 else {return}
        
        if selectedTag == 1 || selectedTag == 2 {
            btnStoreName_Manually.setTitle("Select", for: .normal)
            btnCityName_Manually.setTitle("Select", for: .normal)
            btnStateName_Manually.setTitle("Select", for: .normal)
            
            reset_btnUseThisStore()
        } else {
            btnStoreName.setTitle("Select", for: .normal)
            btnStateName.setTitle("Select", for: .normal)
            
            reset_btnGetListOfStore()
        }
        
        switch selectedTag {
        case 1:
            selectedValue_1 = storeList[row]
            p1Index = row
            
        case 2:
            selectedValue_2 = stateList[row]
            p2Index = row
            
        case 3:
            selectedValue_3 = storeList[row]
            p3Index = row
            
        case 4:
            selectedValue_4 = stateList[row]
            p4Index = row
            
        case 5:
            selectedValue_5 = cityList[row]
            p5Index = row
            
        default:
            selectedValue = ""
            p1Index = 0 ; p2Index = 0 ; p3Index = 0 ; p4Index = 0 ; p5Index = 0
        }
    }
    
    // helper funcs for custom btn :
    func ChangeThemeFor_btn_UseThisStore() {
            btnUseThisStore.isGrayButton = false
            btnUseThisStore.awakeFromNib()
    }
    
    func ChangeThemeFor_btn_GetListOfStore() {
        
        btnGetListOfStores.isGrayButton = false
        btnGetListOfStores.awakeFromNib()
    }
    
    func reset_btnUseThisStore() {
        btnUseThisStore.isGrayButton = true
        btnUseThisStore.awakeFromNib()
    }
    
    func reset_btnGetListOfStore() {
        btnGetListOfStores.isGrayButton = true
        btnGetListOfStores.awakeFromNib()
    }
    
}