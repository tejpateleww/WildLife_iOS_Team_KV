//
//  ReportListViewController.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 24/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit

class ReportListViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var constantHeightOfTableView: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_No_Reports_Available_To_Sync: UILabel!
    @IBOutlet weak var btnSync: ThemeButton!
    
    //MARK:- Properties
    var arr_AppUsers : [AppUser] = []
    
    var arr_CurrentUser_OfflineReports : [OfflineReportModal] = []
    
    var submitsToSync_Arr : [SubmitMaster]?
    var apiCallCount = 0
    
    let addStoreManually_DispatchGroup = DispatchGroup()
    
    let imgWaitingTime_DispatchGroup = DispatchGroup()
    let imgUploads_DispatchGroup = DispatchGroup()
    let submit_DispatchGroup = DispatchGroup()
   
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.sizeToFit()
        tableView.reloadData()
        
        // 1. Fetch the Array of APP USERS from the user defaults
        let arrAppUsers_Data = userDefault.object(forKey: UserDefaultsKey.appUsers.rawValue) as? Data
        if arrAppUsers_Data != nil {
            arr_AppUsers = try! PropertyListDecoder().decode(Array<AppUser>.self, from: arrAppUsers_Data!)
        } else {
            arr_AppUsers = []
        }
        
        // 2. Fetch the current user Data -> Match the current user with the arr of All users and then fetch offline reports for the current user by matching email address and store them in a local variable
        let data = userDefault.value(forKey: UserDefaultsKey.userProfile.rawValue) as? Data
        let userModal = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as? UserInfo
        
        for i in 0..<arr_AppUsers.count {
            if arr_AppUsers[i].emailID == userModal?.data.username {
                arr_CurrentUser_OfflineReports = arr_AppUsers[i].arr_OfflineReports
            }
        }
        
        tableView.reloadData()
        
        // Hide Show Tableview
        if arr_CurrentUser_OfflineReports.count == 0 {
            tableView.isHidden = true
            btnSync.isHidden = true
            lbl_No_Reports_Available_To_Sync.isHidden = false
        } else {
            tableView.isHidden = false
            btnSync.isHidden = false
            lbl_No_Reports_Available_To_Sync.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBarWithMenuORBack(Title: "Report List", leftButton: "back", IsNeedRightButton: false, isTranslucent: false)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
           self.constantHeightOfTableView.constant = self.tableView.contentSize.height
        }
    }
    
    
    //MARK:- Events:
    
    @IBAction func syncBtnPressed(_ sender: Any) {
        
        if WebService.shared.isConnected {
            
            let alert = UIAlertController(title: "Synchronize all reports?", message: "You cannot undo this operation once it starts synchronizing", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Yes", style: .default) { (action) in
//                self.uploadImages()
                
                self.uploadAllStore()
            }
            
            let cancleAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            
            alert.addAction(okAction)
            alert.addAction(cancleAction)
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
//            Utilities.displayAlert("Internet Connectivity unavailable")
            
            Utilities.showAlert(AppInfo.appName, message: "Internet connection appears to be offline", vc: self)
        }
    }
    
}

extension ReportListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if arr_CurrentUser_OfflineReports != nil {
//            return arr_CurrentUser_OfflineReports.count
//        } else {
//            return 0
//        }
        return arr_CurrentUser_OfflineReports.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportListTableViewCell", for: indexPath) as! ReportListTableViewCell
        cell.selectionStyle = .none
//        cell.setup(submitMaster: submitsToSync_Arr![indexPath.row])
        
        // 1. Take the params Data for each offline report.
        let params_Data = arr_CurrentUser_OfflineReports[indexPath.row].paramsDict
        
        // 2. Convert the Data into dictionary and pass it to the Cell for Setup
        let dict = try? JSONSerialization.jsonObject(with: params_Data!, options: []) as? [String : Any]
        cell.setup1(offlineReport_ParamsDict: dict!)
        
        
        cell.isRemoved = {
            guard self.submitsToSync_Arr?.count != 0 else { return }
            
            let alert = UIAlertController(title: AppInfo.appName, message: "Once report will be removed then you can not retrieve it later. Are you sure you want to remove this report?", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                
                //Remove from the Array
                self.arr_CurrentUser_OfflineReports.remove(at: indexPath.row)
                
                //Save the array in the app users modal.
                
                let data = userDefault.value(forKey: UserDefaultsKey.userProfile.rawValue) as? Data
                let userModal = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as? UserInfo
                
                for i in 0..<self.arr_AppUsers.count {
                    if self.arr_AppUsers[i].emailID == userModal?.data.email_address {
                        self.arr_AppUsers[i].arr_OfflineReports = self.arr_CurrentUser_OfflineReports
                    }
                }
                
                //Save the Array of All users to user defaults.
                let appUsersData = try? PropertyListEncoder().encode(self.arr_AppUsers)
                userDefault.set(appUsersData, forKey: UserDefaultsKey.appUsers.rawValue)
                
                if self.arr_AppUsers.count == 0 {
//                    self.lbl_No_Reports_Available_To_Sync.isHidden = false
                }
                
                self.tableView.reloadData()
            }
            
            let cancleAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            
            alert.addAction(okAction)
            alert.addAction(cancleAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



//MARK: API CALLs:
extension ReportListViewController {
    
    func uploadAllStore() {
        
        Utilities.showHud()
        
        for i in 0..<arr_CurrentUser_OfflineReports.count {
            
            self.addStoreManually_DispatchGroup.enter()
            
            let paramData = arr_CurrentUser_OfflineReports[i].paramsDict
            let paramDict = try? JSONSerialization.jsonObject(with: paramData!, options: []) as? [String : Any]
            let isNewStore = paramDict!["new_store"] as! Int   // added manually.
            
            if isNewStore == 1 {
                // we need to call the api ..
                let store = paramDict!["store_name"] as! String
                let state = paramDict!["store_state"] as! String
                let city = paramDict!["store_city"] as! String
                
                webService_AddStoreManually(store: store, state: state, city: city)
            } else {
                self.addStoreManually_DispatchGroup.leave()
            }
            
        }
        
        addStoreManually_DispatchGroup.notify(queue: DispatchQueue.main, execute: {
            print("All Manual Stores added")
            
            self.uploadImages()
        })
        
    }
    
    
    func uploadImages() {
        
        for i in 0..<arr_CurrentUser_OfflineReports.count {
            
            imgWaitingTime_DispatchGroup.enter()
            
            if arr_CurrentUser_OfflineReports[i].imgArr.count > 0 {
                
                let paramData = arr_CurrentUser_OfflineReports[i].paramsDict
                var paramDict = try? JSONSerialization.jsonObject(with: paramData!, options: []) as? [String : Any]
                
                var imgStrArray : [String] = []
                
                for j in 0..<arr_CurrentUser_OfflineReports[i].imgArr.count {
                    imgUploads_DispatchGroup.enter()
                    // WebService Call
                    WebServiceSubClass.imageUploadAPI(image: UIImage(data: arr_CurrentUser_OfflineReports[i].imgArr[j].img_inDataForm!)!, showhud: false) { (json, success, resp) in
                        if success {
                            //json["result"].stringValue
                            
                            imgStrArray.append(json["result"].stringValue)
                            self.imgUploads_DispatchGroup.leave()
                        }
                    }
                }
                
                let finalString = imgStrArray.joined(separator: ",")
                paramDict!["photos"] = finalString
                
                let params_Data = try? JSONSerialization.data(withJSONObject: paramDict!)
                self.arr_CurrentUser_OfflineReports[i].paramsDict = params_Data!
                
                
                //                let params_Data = try? JSONSerialization.data(withJSONObject: paramDict!)
                //                arr_CurrentUser_OfflineReports[i].paramsDict = params_Data!
                
                imgWaitingTime_DispatchGroup.leave()
                
            } else {// imgUploads_DispatchGroup.leave()
                
            }
        }
        
        imgUploads_DispatchGroup.notify(queue: DispatchQueue.main, execute: {
            print("images uploaded")
            
            self.syncSubmitReports()
        })
    }
    
    func syncSubmitReports() {
        
        self.arr_CurrentUser_OfflineReports.forEach({ (offlineReport) in
            submit_DispatchGroup.enter()
            
            let paramData = offlineReport.paramsDict
            let paramDict = try? JSONSerialization.jsonObject(with: paramData!, options: []) as? [String : Any]
            
            submitAPI(paramModal: paramDict!)
            
        })
        
        submit_DispatchGroup.notify(queue: DispatchQueue.main, execute: {
            
            
            
            //            clear all the reports Data for the current user.
            
            //            self.btnSync.isHidden = true
            //
            //                                       if self.arr_CurrentUser_OfflineReports.count == 0 {
            //                                           self.tableView.isHidden = false
            //                                       } else {
            //                                           self.tableView.isHidden = true
            //                                       }
            
            
            Utilities.showAlert(AppInfo.appName, message: "All Reports Submitted", vc: self)
            
            
            //            Utilities.displayAlert("All Reports Submitted")
            //
            //            Utilities.showAlert(AppInfo.appName, message: "All Reports Submitted", vc: self)
            
            
            
            //            print("All Reports Submitted")
        })
        
    }
    
    //MARK:- Helper Functions: API:
    
    
    func submitAPI(paramModal: [String:Any] ) {
        
        WebServiceSubClass.submit(params: paramModal as Any, showhud: false) { (json, success, resp) in
            
            if success {
                
                Utilities.hideHud()
                //clear modal stored in submit master ... and user defaults
                
                let data = userDefault.value(forKey: UserDefaultsKey.userProfile.rawValue) as? Data
                let userModal = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as? UserInfo
                
                
                for i in 0..<self.arr_AppUsers.count {
                    if self.arr_AppUsers[i].emailID == userModal?.data.username! {
                        self.arr_AppUsers[i].arr_OfflineReports = []
                    }
                }
                
                let finalData = try? PropertyListEncoder().encode(self.arr_AppUsers)
                userDefault.set(finalData, forKey: UserDefaultsKey.appUsers.rawValue)
                
                self.arr_CurrentUser_OfflineReports.removeAll()
                self.tableView.reloadData()
                
                //            self.lbl_No_Reports_Available_To_Sync.isHidden = false
                
                self.btnSync.isHidden = true
                self.lbl_No_Reports_Available_To_Sync.isHidden = false
                
                if self.arr_CurrentUser_OfflineReports.count == 0 {
                    self.tableView.isHidden = true
                } else {
                    self.tableView.isHidden = false
                }
                
                
                
            }
            self.submit_DispatchGroup.leave()
        }
        
    }
    
    
    
    
    func webService_AddStoreManually(store: String, state: String, city: String) {
           
           WebServiceSubClass.addStoreManually(store: store, state: state, city: city, showhud: true) { (json, success, resp) in
               if success {
                
                self.addStoreManually_DispatchGroup.leave()
                
               } else {
//                   self.showAlert(msg: json["message"].stringValue)
               }
           }
           
       }
}

