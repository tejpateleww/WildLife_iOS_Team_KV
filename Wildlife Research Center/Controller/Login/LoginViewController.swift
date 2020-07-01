//
//  LoginViewController.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 23/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class LoginViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        txtUserName.text = ""
//        txtPassWord.text = ""
        
        webserviceCallForInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK:- Events
    
    @IBAction func loginBtnPressed(_ sender: Any) {
//        if(validation())
//        {
        
        guard let userName = txtUserName.text, userName != "" else {
//            showAlert()
            Utilities.showAlert(AppInfo.appName, message: "Username cannot be empty", vc: self)
            return }
        
        guard let pwd = txtPassWord.text, pwd != "" else {
//            showAlert()
            Utilities.showAlert(AppInfo.appName, message: "Password cannot be empty", vc: self)
            return
        }
        
            webServiceForLogin()
//        }
    }
    
    func showAlert()
    {
        let alert = UIAlertController(title: AppInfo.appName, message: "Username or Password can not be empty", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK:- API Calls
    
    func webserviceCallForInit()
    {
        let strUrl = "app_version=\(AppInfo.appVersion)&type=IOS"
        
        guard WebService.shared.isConnected == true else {
            return
        }
        
        WebServiceSubClass.initApi(strParams: strUrl, showHud: true) { (json, status, response) in
            
            guard status == true else { return }
            
            _ = ResposneInitClass.init(fromJson: json)
            if ((json["update"].bool) != nil) {
                if ((json["update"].bool) == false){     // update - false means update is not compulsory hense later action
                    let alert = UIAlertController(title: AppInfo.appName,
                                                  message: json["message"].string ?? "New app is available on App Store",
                                                  preferredStyle: UIAlertController.Style.alert)
                    
                    let okAction = UIAlertAction(title: "Update", style: .default, handler: { (action) in
                        
                        if let url = URL(string: AppInfo.appUrl) {
                            UIApplication.shared.open(url)
                            self.present(alert, animated: true, completion: nil)
                        }
                    })
                    
                    let LaterAction = UIAlertAction(title: "Later", style: .default, handler: { (action) in
                        
                        alert.dismiss(animated: true) {
                            //self.setup()
                        }
                    })
                    
                    alert.addAction(okAction)
                    alert.addAction(LaterAction)
                    
                    self.present(alert, animated: true, completion: nil)
                }
                else if((json["update"].boolValue) == true)
                {
                    let alert = UIAlertController(title: AppInfo.appName,
                                                  message: json["message"].string ?? "New app is available on App Store",
                                                  preferredStyle: UIAlertController.Style.alert)
                    
                    let okAction = UIAlertAction(title: "Update", style: .default, handler: { (action) in
                        if let url = URL(string: AppInfo.appUrl) {
                            UIApplication.shared.open(url)
                            self.present(alert, animated: true, completion: nil)
                        }
                    })
                    
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        
    }
    
    
    func webServiceForLogin()
    {
        
        guard let userName = txtUserName.text, userName != "" else {
            Utilities.displayAlert("Attention!", message: "Username Can not be empty")
            return
        }
        
        guard let password = txtPassWord.text, password != "" else {
            Utilities.displayAlert("Attention!", message: "Password can not be empty")
            return
        }
        
        
        if WebService.shared.isConnected {
            
              WebServiceSubClass.loginApi(userName: userName.trimmedString, passWord: password.trimmedString, showHud: true) { (json, status, resp) in
                                    
                        if json["success"].stringValue == "true" {
                            
                            
                            userDefault.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                            print(userDefault.value(forKey: UserDefaultsKey.isUserLogin.rawValue) as! Bool)
                            userDefault.synchronize()
                            
                            // Old Developer code:
                            let userDetails = UserInfo(fromJson: json)
            //                UserDefaults.standard.set(loginModelDetails.data.num , forKey: UserDefaultsKey.X_API_KEY.rawValue)
                            
                            SingletonClass.sharedInstance.UserId = userDetails.data.num
        
                            let encodedData = try! NSKeyedArchiver.archivedData(withRootObject: userDetails, requiringSecureCoding: false)
                            userDefault.set(encodedData, forKey:  UserDefaultsKey.userProfile.rawValue)
                            
                            SingletonClass.sharedInstance.LoginRegisterUpdateData = userDetails
                            
                            // to Maintain a list of all Users :
                            var arr_AppUsers : [AppUser]!
                            
                            let arrAppUsers_Data = userDefault.object(forKey: UserDefaultsKey.appUsers.rawValue) as? Data
                            if arrAppUsers_Data != nil {
                                arr_AppUsers = try! PropertyListDecoder().decode(Array<AppUser>.self, from: arrAppUsers_Data!)
                            } else {
                                arr_AppUsers = []
                            }
                            
                            var existingUser : Bool = false
                            
                            for i in 0..<arr_AppUsers.count {
                                if arr_AppUsers[i].emailID == userDetails.data.email_address {
                                    existingUser = true
                                } else {
                                    
                                    existingUser = false
                                }
                            }
                            
                            // Append the new user to our app users array
                            if !existingUser {
                                arr_AppUsers.append(AppUser(user_Email: userDetails.data.email_address, arr_OfflineReports: []))
                            }
                            
                            // save the user
                            let finalData = try? PropertyListEncoder().encode(arr_AppUsers)
                            userDefault.set(finalData, forKey: UserDefaultsKey.appUsers.rawValue)
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let retailreportvc = storyboard.instantiateViewController(withIdentifier: "RetailReportMainViewController") as! RetailReportMainViewController
                            self.navigationController?.pushViewController(retailreportvc, animated: true)
                        }
                        else
                        {
            //                Utilities.displayErrorAlert(json["message"].string ?? "Something went wrong")
                            
                            Utilities.displayAlert("Error", message: json["message"].string!)
                            
                            
                        }
                    }
            
        } else {
            Utilities.showAlert("Attention!", message: "No Internet Connectivity", vc: self)
//            Utilities.displayAlert("Attention!", message: "No Internet Connectivity")
            
            
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


