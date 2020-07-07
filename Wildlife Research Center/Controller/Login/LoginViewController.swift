//
//  LoginViewController.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 23/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreData

class LoginViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    
    //MARK:- Properties
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Testing:
//        txtUserName.text = "mayur"
//        txtPassWord.text = "mayur"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK:- Events
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        guard let userName = txtUserName.text, userName != "" else {
            Utilities.showAlert(AppInfo.appName, message: "Username cannot be empty", vc: self)
            return }
        
        guard let pwd = txtPassWord.text, pwd != "" else {
            Utilities.showAlert(AppInfo.appName, message: "Password cannot be empty", vc: self)
            return
        }
        
        if WebService.shared.isConnected {
            webServiceForLogin()
        } else { // Offline Mode
            
            //check if there are any users in local DB with matching credentials -> if found then we can login using those credentials and save those credentials in singleton and userdefaults.
            
            if let arrUsers_ManagedContext = DataBaseHandler.sharedManager.fetchAllUserData(entityName: "User") {
                
                // if thrs r no users in the managed context
                guard arrUsers_ManagedContext.count > 0 else {
                    Utilities.displayAlert("Internet connection appears to be offline")
                    return
                }
                
                var newUserFound : Bool = false
                var newUser : String = ""
                
                // Match the entered credentials in textfields with each user in db :
                for user in arrUsers_ManagedContext {
                    
                    // username and password match... with user in DB
                    if user.value(forKeyPath: "username") as! String == userName && user.value(forKeyPath: "password") as! String == pwd {
                        
                        //set key for isUserLogin
                        userDefault.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                        userDefault.synchronize()
                        
                        // create the same userDetails modal (and Resprofiledatum inside of it) as it happens on API Call Login and save it to user defaults as well as Singleton class
                        let res = ResProfileDatum(num: (user.value(forKeyPath: "num") as? String)!,
                                                  createdDate: (user.value(forKeyPath: "createdDate") as? String)!,
                                                  createdByUserNum: (user.value(forKeyPath: "createdByUserNum") as? String)!,
                                                  updatedDate: (user.value(forKeyPath: "updatedDate") as? String)!,
                                                  updatedByUserNum: "",
                                                  dragSortOrder: (user.value(forKeyPath: "dragSortOrder") as? String)!,
                                                  username: (user.value(forKeyPath: "username") as? String)!,
                                                  password: (user.value(forKeyPath: "password") as? String)!,
                                                  full_name: (user.value(forKeyPath: "full_name") as? String)!,
                                                  email_address: (user.value(forKeyPath: "email_address") as? String)!,
                                                  rep_group: (user.value(forKeyPath: "rep_group") as? String)! )
                        
                        
                        let userDetails : UserInfo? = UserInfo.init(resProfileDatum: res)
                        
                        let encodedData = try! NSKeyedArchiver.archivedData(withRootObject: userDetails!, requiringSecureCoding: false)
                        userDefault.set(encodedData, forKey:  UserDefaultsKey.userProfile.rawValue)
                        
                        SingletonClass.sharedInstance.LoginRegisterUpdateData? = userDetails!
                        
                        // Make the matched user in DB the current user.
                        user.setValue(true, forKeyPath: "isCurrentUser")
                        newUserFound = true
                        newUser = userName
                        
                    }
                }
                
                // if we have a new current user , make sure no other users are current users.
                if newUserFound {
                    for user in arrUsers_ManagedContext {
                        if !((user.value(forKeyPath: "username") as? String) == newUser) {
                            user.setValue(false, forKeyPath: "isCurrentUser")
                        }
                    }
                }
                
                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  let retailreportvc = storyboard.instantiateViewController(withIdentifier: "RetailReportMainViewController") as! RetailReportMainViewController
                  self.navigationController?.pushViewController(retailreportvc, animated: true)
                
                
            } else { // if no managed context :
                Utilities.displayAlert("No user found")
            }
        }
    }
    
    
    //MARK:- API Calls
    
    func webServiceForLogin() //Online Mode
    {
        guard let userName = txtUserName.text, userName != "" else {
            Utilities.displayAlert("Attention!", message: "Username Can not be empty")
            return
        }
        
        guard let password = txtPassWord.text, password != "" else {
            Utilities.displayAlert("Attention!", message: "Password can not be empty")
            return
        }
        
        WebServiceSubClass.loginApi(userName: userName.trimmedString, passWord: password.trimmedString, showHud: true) { (json, status, resp) in
            
            if json["success"].stringValue == "true" {
                
                // 1. Save a Bool Value in User Defaults if user is logged in.
                userDefault.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                userDefault.synchronize()
                
                // 2. Fill the Local Modal for Current User and save it to user defaults.
                let userDetails = UserInfo(fromJson: json)
                let encodedData = try! NSKeyedArchiver.archivedData(withRootObject: userDetails, requiringSecureCoding: false)
                userDefault.set(encodedData, forKey:  UserDefaultsKey.userProfile.rawValue)
                
                // 3. Fill the userId and userData in Singleton Class used while app is active.
                SingletonClass.sharedInstance.UserId = userDetails.data.num
                SingletonClass.sharedInstance.LoginRegisterUpdateData = userDetails
                
                // 4. Add a user to the DB Only if he doesnt already exist in the DB:
                
                // fetch all users
                let arrOfAllUsers_ManagedObject = DataBaseHandler.sharedManager.fetchAllUserData(entityName: "User")!
                
                // check if user with the user name already exists..
                var userExists_InDB : Bool = false
                for user in arrOfAllUsers_ManagedObject {
                    if (user.value(forKeyPath: "username") as? String) == SingletonClass.sharedInstance.LoginRegisterUpdateData?.data.username {
                        // No need to save the user in the Database, just make its current user value to true
                        userExists_InDB = true
                        user.setValue(true, forKeyPath: "isCurrentUser")
                    } else {
                        // if user doesnt exist in DB -> Set the flag and below will be a func to add a new user to db.
                        userExists_InDB = false
                        user.setValue(false, forKeyPath: "isCurrentUser")
                    }
                }
                
                // if he doesnt exist, add the user into the database
                if !userExists_InDB {
                    //current user data will be fetched from singleton inside the below function and current user will be created in the DB
                    DataBaseHandler.sharedManager.saveCurrentUserInDB()
                }
                
                
                // 0. The OLd Way Before Core Data was Used : the same above process but with a local modal saved in user defaults.
                
                // To Maintain a list of all Users :
                var arr_AppUsers : [AppUser]!
                
                let arrAppUsers_Data = userDefault.object(forKey: UserDefaultsKey.appUsers.rawValue) as? Data
                if arrAppUsers_Data != nil {
                    arr_AppUsers = try! PropertyListDecoder().decode(Array<AppUser>.self, from: arrAppUsers_Data!)
                } else {
                    arr_AppUsers = []
                }
                
                var existingUser : Bool = false
                for i in 0..<arr_AppUsers.count {
                    if arr_AppUsers[i].emailID == userDetails.data.username {
                        existingUser = true
                    } else {
                        existingUser = false
                    }
                }
                
                // Append the new user to our app users array
                if !existingUser {
                    arr_AppUsers.append(AppUser(user_Email: userDetails.data.username, arr_OfflineReports: []))
                }
                
                // save the user in defaults
                let finalData = try? PropertyListEncoder().encode(arr_AppUsers)
                userDefault.set(finalData, forKey: UserDefaultsKey.appUsers.rawValue)
                
                
                
                // 6 In the End:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let retailreportvc = storyboard.instantiateViewController(withIdentifier: "RetailReportMainViewController") as! RetailReportMainViewController
                self.navigationController?.pushViewController(retailreportvc, animated: true)
            }
            else
            {
                Utilities.displayAlert("Error", message: json["message"].string!)
            }
        }
        
    }
    
    
    
    //MARK:- Methods
    
    func validation() -> Bool
    {
        let checkEmail = txtUserName.validatedText(validationType: ValidatorType.email)
        let checkPassword = txtPassWord.validatedText(validationType: ValidatorType.password)
        
        if(!checkEmail.0)
        {
            Utilities.displayAlert(checkEmail.1)
            return checkEmail.0
        }
        else  if(!checkPassword.0)
        {
            Utilities.displayAlert(checkPassword.1)
            return checkPassword.0
        }
        
        return true
    }
}
