//
//  RetailReportMainViewController.swift
//  Wildlife Research Center
//
//  Created by EWW074 o n 24/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit
import CoreData

class RetailReportMainViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtReqGroup: UITextField!
    @IBOutlet weak var btnNext: ThemeButton!
    
    @IBOutlet weak var btnSelectStoree: ThemeButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    //MARK:- Properties
    var retailStoreQuestions_Array = [RetailsStoreQuestion]()
    var comesAfterSubmission : Bool = false
    
    var currentUserDetails : NSManagedObject!

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        userDefault.set(false, forKey: UserDefaultsKey.isStoreSelected.rawValue)
        
        txtName.isUserInteractionEnabled = false
        txtEmail.isUserInteractionEnabled = false
        txtReqGroup.isUserInteractionEnabled = false
        
        retailStoreQuestions_Array = [RetailsStoreQuestion(title: "Were wildlife products set-Up in store?", isOn: false),
                   RetailsStoreQuestion(title: "Were our products priced?", isOn: false),
                   RetailsStoreQuestion(title: "If not, did you ask someone to price them?", isOn: false),
                   RetailsStoreQuestion(title: "Were our products displayed correctly?", isOn: false),
                   RetailsStoreQuestion(title: "Did you discuss any issues with store personnel?", isOn: false),
                   RetailsStoreQuestion(title: "Did you do product training?", isOn: false),
                   RetailsStoreQuestion(title: "Did you leave SEP's?", isOn: false),
                   RetailsStoreQuestion(title: "Did you work on event?", isOn: false)
                  ]
        
        
        getUserDetails()
        
       // Stuff if the store is selected.
        
        let isStoreSelected = userDefault.value(forKey: UserDefaultsKey.isStoreSelected.rawValue) as? Bool
        if isStoreSelected != nil && isStoreSelected! {
            
            guard let storeData = userDefault.object(forKey: UserDefaultsKey.storeInfo.rawValue) as? Data else { return }
            guard let storeinfo = try? PropertyListDecoder().decode(StoreInfo.self, from: storeData) else { return }
            
            if storeinfo.retailStoreQuestions_Arr.count > 7 {
                self.retailStoreQuestions_Array = storeinfo.retailStoreQuestions_Arr
            } else {
                retailStoreQuestions_Array = [RetailsStoreQuestion(title: "Were wildlife products set-Up in store?", isOn: false),
                 RetailsStoreQuestion(title: "Were our products priced?", isOn: false),
                 RetailsStoreQuestion(title: "If not, did you ask someone to price them?", isOn: false),
                 RetailsStoreQuestion(title: "Were our products displayed correctly?", isOn: false),
                 RetailsStoreQuestion(title: "Did you discuss any issues with store personnel?", isOn: false),
                 RetailsStoreQuestion(title: "Did you do product training?", isOn: false),
                 RetailsStoreQuestion(title: "Did you leave SEP's?", isOn: false),
                 RetailsStoreQuestion(title: "Did you work on event?", isOn: false)
                ]
            }
        }
        
        tableView.tableFooterView = UIView()
        tableView.sizeToFit()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBarWithMenuORBack(Title: "Retail Report", leftButton: "menu", IsNeedRightButton: true, isTranslucent: false)
        mainScrollView.contentOffset = .zero
        
        btnNext.layoutSubviews()
        btnNext.layer.layoutSublayers()
    
        // Reset the Switches if pop backs from Report Submission
        if comesAfterSubmission {
            for i in 0..<retailStoreQuestions_Array.count {
                retailStoreQuestions_Array[i].isOn = false
            }
        }
        
        let isStoreSelected = userDefault.value(forKey: UserDefaultsKey.isStoreSelected.rawValue) as? Bool
        if isStoreSelected != nil && isStoreSelected! {
            
            guard let storeData = userDefault.object(forKey: UserDefaultsKey.storeInfo.rawValue) as? Data else { return }
            guard let storeinfo = try? PropertyListDecoder().decode(StoreInfo.self, from: storeData) else { return }
            
            self.retailStoreQuestions_Array = storeinfo.retailStoreQuestions_Arr
            
            btnNext.isGrayButton = false
            btnNext.awakeFromNib()
        } else {
            btnNext.isGrayButton = true
            btnNext.awakeFromNib()
        }
        
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.comesAfterSubmission = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        btnSelectStoree.layer.cornerRadius = 5
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tableViewHeightConstraint.constant = CGFloat(self.retailStoreQuestions_Array.count * 62) //self.tableView.contentSize.height
        }
        
        
//        check if store is selected. if selected then display the switch data as it was.
    }
    
    
    //MARK:- Events
    
    @IBAction func selectStoreBtnPress(_ sender: Any) {
        
        //Fetch Selected Store,, if nil or false then alert ,, else save store details.
        let isStoreSelected = userDefault.value(forKey: UserDefaultsKey.isStoreSelected.rawValue) as? Bool

        if isStoreSelected != nil && isStoreSelected! {
            
            // fetch store info if thr exists any and assign the selected switched data to it.
            guard let storeData = userDefault.object(forKey: UserDefaultsKey.storeInfo.rawValue) as? Data else { return }
            guard let storeinfo = try? PropertyListDecoder().decode(StoreInfo.self, from: storeData) else { return }
            
            let finalStoreInfo = StoreInfo(store: storeinfo.storeName, state: storeinfo.stateName, city: storeinfo.cityName, retailStoreQuestions_Arr: retailStoreQuestions_Array, isStoreAddedManually: storeinfo.isStoreAddedManually!)
            
            let data = try? PropertyListEncoder().encode(finalStoreInfo)
            userDefault.set(data, forKey: UserDefaultsKey.storeInfo.rawValue)
        } else {
            
            // If no Store Selected. Pass an empty store with Switches Data (retailstorequestions arr)
            let finalStoreInfo = StoreInfo(store: "Select", state: "Select", city: "Select", retailStoreQuestions_Arr: retailStoreQuestions_Array, isStoreAddedManually: false)
            
            let data = try? PropertyListEncoder().encode(finalStoreInfo)
            userDefault.set(data, forKey: UserDefaultsKey.storeInfo.rawValue)
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectStoreViewController") as! SelectStoreViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func btnNext_tapAction(_ sender: ThemeButton) {
        
        //Fetch Selected Store,, if nil or false then alert ,, else save store details.
        let isStoreSelected = userDefault.value(forKey: UserDefaultsKey.isStoreSelected.rawValue) as? Bool

        if isStoreSelected != nil && isStoreSelected! {

            //Fetch Store info ( state city store)
            guard let storeData = userDefault.object(forKey: UserDefaultsKey.storeInfo.rawValue) as? Data else { return }
            guard let storeinfo = try? PropertyListDecoder().decode(StoreInfo.self, from: storeData) else { return }

            // Add information ( Switch questions data )
            let finalStoreInfo = StoreInfo(store: storeinfo.storeName, state: storeinfo.stateName, city: storeinfo.cityName, retailStoreQuestions_Arr: retailStoreQuestions_Array, isStoreAddedManually: storeinfo.isStoreAddedManually!)

            let data = try? PropertyListEncoder().encode(finalStoreInfo)
            userDefault.set(data, forKey: UserDefaultsKey.storeInfo.rawValue)

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RetailReportSecondViewController") as! RetailReportSecondViewController
            self.navigationController?.pushViewController(vc, animated: true)

        } else {

            let alert = UIAlertController(title: AppInfo.appName, message: "You can select store from available Stores or you can add store manually", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension RetailReportMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retailStoreQuestions_Array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RetaildReportMainTableViewCell", for: indexPath) as! RetaildReportMainTableViewCell
        cell.selectionStyle = .none
        
        cell.setupData(retailStoreQuestions_Array[indexPath.row].Title, isOn: retailStoreQuestions_Array[indexPath.row].isOn)
        cell.switchTapped = { [unowned self] in
            self.retailStoreQuestions_Array[indexPath.row].isOn = !self.retailStoreQuestions_Array[indexPath.row].isOn
//            cell.setupData(self.aryData[indexPath.row].Title, isOn: self.aryData[indexPath.row].isOn)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
}


struct RetailsStoreQuestion : Codable {
    
    var Title: String!
    var isOn: Bool
    
    init(title: String, isOn: Bool) {
        self.Title = title
        self.isOn = isOn
    }
}

extension RetailReportMainViewController {
    
    // Get User Details from the user Defaults by unarchieving and Match the User Details in the DB ... and make the user as current user + get all the current Data for that user..
    func getUserDetails() {
        
        
        //Fetch User details from user details and store it in shared instance and fill textfields
        let data = userDefault.value(forKey: UserDefaultsKey.userProfile.rawValue) as? Data
        let userDetails = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as? UserInfo
        
        SingletonClass.sharedInstance.LoginRegisterUpdateData? = userDetails!
//        print(userDetails?.data.username)
        //Set the textfields
        txtName.text = userDetails?.data.full_name ?? ""
        txtEmail.text = userDetails?.data.email_address ?? ""
        txtReqGroup.text = userDetails?.data.rep_group ?? ""
        
        //Fetch all the user Data from the DB
        let allUserData = DataBaseHandler.sharedManager.fetchAllUserData(entityName: "User")
    
        //match and make the current user which is in the user defaults.
        for user in allUserData! {
            
            if user.value(forKeyPath: "username") as? String == userDetails?.data.username {
                // Make this user the current user
                user.setValue(true, forKeyPath: "isCurrentUser")
                
            } else {
                //Make all other users Non Current
                user.setValue(false, forKeyPath: "isCurrentUser")
            }
        }
        
        // Save the context/ Changes
        DataBaseHandler.sharedManager.saveContext()
        
        retailStoreQuestions_Array = [RetailsStoreQuestion(title: "Were wildlife products set-Up in store?", isOn: false),
         RetailsStoreQuestion(title: "Were our products priced?", isOn: false),
         RetailsStoreQuestion(title: "If not, did you ask someone to price them?", isOn: false),
         RetailsStoreQuestion(title: "Were our products displayed correctly?", isOn: false),
         RetailsStoreQuestion(title: "Did you discuss any issues with store personnel?", isOn: false),
         RetailsStoreQuestion(title: "Did you do product training?", isOn: false),
         RetailsStoreQuestion(title: "Did you leave SEP's?", isOn: false),
         RetailsStoreQuestion(title: "Did you work on event?", isOn: false)
        ]
        
        
    }
    
    
}
 
