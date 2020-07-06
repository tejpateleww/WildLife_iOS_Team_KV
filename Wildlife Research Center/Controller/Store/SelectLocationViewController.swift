//
//  SelectLocationViewController.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 19/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class SelectLocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView_Stores: UITableView!
    
    var storeList : [StoreList] = []
    var storeModal : StoreInfo!
    
    var state : String = ""
    var store : String = ""
    
    var listManagedContext : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let storeData = userDefault.object(forKey: UserDefaultsKey.storeInfo.rawValue) as? Data else { return }
        guard let storeinfo = try? PropertyListDecoder().decode(StoreInfo.self, from: storeData) else { return }
        
        if WebService.shared.isConnected {
            self.webServiceForStoreLists(storeName: store, state: state)
        } else {
            fetchStoreDataFromDB()
        }
        
        tblView_Stores.allowsSelection = false
    }
    
    func fetchStoreDataFromDB() {
        let data = DataBaseHandler.sharedManager.fetchListBasedOnPredicate(state: state, store: store)
        
        guard data != nil else {
            self.showAlert(msg: "List not available")
            return
        }
        
        
        for eachdata in data! {
            
            let title = eachdata.value(forKeyPath: "title") as? String
            let add = eachdata.value(forKeyPath: "address") as? String
            let city = eachdata.value(forKeyPath: "city") as? String
            let state = eachdata.value(forKeyPath: "state") as? String
            let zip = eachdata.value(forKeyPath: "zip") as? String
            
            let store = StoreList(title: title!, address: add!, city: city!, state: state!, zip: zip!)
            
            self.storeList.append(store)
            
        }
        
        if storeList.count < 1 {
            self.tblView_Stores.isHidden = true
        } else {
            self.tblView_Stores.isHidden = false
        }
        
        self.tblView_Stores.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated
        )
        setNavBarWithMenuORBack(Title: "Select Location", leftButton: "back", IsNeedRightButton: false, isTranslucent: false, isRounded: false)
    }
    

    //MARK:- Tblview delegate and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectStoreTableViewCell", for: indexPath) as! SelectStoreTableViewCell
        
        let storeAtIndex = storeList[indexPath.row]
        
        cell.storeAt = storeAtIndex
        cell.delegate = self
        
        cell.lblStoreAddress.text = "\(storeAtIndex.title ?? ""), \(storeAtIndex.address ?? ""), \(storeAtIndex.city ?? ""), \(storeAtIndex.state ?? ""), \(storeAtIndex.zip ?? "") "
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
    }
    
    
    //MARK:- Api Call
    
    func webServiceForStoreLists(storeName: String, state: String) {

        if WebService.shared.isConnected {
            WebServiceSubClass.storeListForStatesAPI(title: storeName, state: state, showhud: true) { (json, success, resp) in

                if success {
                    json["result"].arrayValue.forEach { (eachdict) in
                        self.storeList.append(StoreList(json: eachdict))
                    }

                    if self.storeList.count == 0 {
                        self.tblView_Stores.isHidden = true
                    } else {
                        self.tblView_Stores.isHidden = false
                        self.tblView_Stores.reloadData()
                    }
                } else {
                    // if fails

                    self.showAlert(msg: "No Store Found")

                }
            }
        } else {
                self.showAlert(msg: "Internet Not Available")
        }

    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: AppInfo.appName, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK:- Cell Select button action is handled here: Save the Details in user defaults and redirect
extension SelectLocationViewController: SelectStoreTableViewCellDelegate {
    
    func selectStoreTblViewCell(_ selectStoreTblViewCell: SelectStoreTableViewCell, selectBtnTappedFor StoreList: StoreList) {
        
        guard let storeData = userDefault.object(forKey: UserDefaultsKey.storeInfo.rawValue) as? Data else { return }
        guard let storeinf = try? PropertyListDecoder().decode(StoreInfo.self, from: storeData) else { return }
        
        
        //Save Store info to Modal
        let storeinfo = StoreInfo(store: StoreList.title, state: StoreList.state, city: StoreList.city, retailStoreQuestions_Arr: storeinf.retailStoreQuestions_Arr ,isStoreAddedManually: false)
        
        let data = try? PropertyListEncoder().encode(storeinfo)
        userDefault.set(data, forKey: UserDefaultsKey.storeInfo.rawValue)
        
        //Store is selected.
        userDefault.set(true, forKey: UserDefaultsKey.isStoreSelected.rawValue)
        
        guard let mainVC = self.navigationController?.getReference(to: RetailReportMainViewController.self) else { return }
        self.navigationController?.popToViewController(mainVC, animated: true)
        
    }
    
}

//Modal Store Lists :

struct StoreList: Codable {
    var num : String!
    var createdDate: String!
    var createdByUserNum: String!
    var updatedDate: String!
    var updatedByUserNum: String!
    var dragSortOrder: String!
    var title: String!
    var address: String!
    var city: String!
    var state: String!
    var zip: String!
    var phone: String!
    var website: String!
    var latitude: String!
    var longitude: String!
    var store: String!
    var _tableName: String!
    
    init(json: JSON) {
        self.num = json["num"].stringValue
        self.createdDate = json["createdDate"].stringValue
        self.createdByUserNum = json["createdByUserNum"].stringValue
        self.updatedDate = json["updatedDate"].stringValue
        self.updatedByUserNum = json["updatedByUserNum"].stringValue
        self.dragSortOrder = json["dragSortOrder"].stringValue
        self.title = json["title"].stringValue
        self.address = json["address"].stringValue
        self.city = json["city"].stringValue
        self.state = json["state"].stringValue
        self.zip = json["zip"].stringValue
        self.phone = json["phone"].stringValue
        self.website = json["website"].stringValue
        self.latitude = json["latitude"].stringValue
        self.longitude = json["longitude"].stringValue
        self.store = json["store"].stringValue
        self._tableName = json["_tableName"].stringValue
    }
    
    init(title : String, address : String, city: String, state: String, zip: String) {
        self.title = title
        self.address = address
        self.city = city
        self.state = state
        self.zip = zip
    }
}
