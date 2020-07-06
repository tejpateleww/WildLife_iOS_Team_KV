//
//  UIViewController+Extention.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 24/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    func setNavBarWithMenuORBack(Title:String, leftButton : String, IsNeedRightButton:Bool, isTranslucent : Bool, isRounded: Bool = false, TintColour : UIColor = UIColor.white)
        {
            
            let shadowLayer = CAShapeLayer()
            let shadowView = UIView(frame: CGRect(x: 0, y: 20,
            width: (self.navigationController?.navigationBar.bounds.width)!,
            height: (self.navigationController?.navigationBar.bounds.height)! ))
              
            self.navigationItem.title = Title//.uppercased()
            
            self.navigationController?.isNavigationBarHidden = false
            //    self.navigationController?.navigationBar.isOpaque = false
            self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.7452868819, blue: 0, alpha: 1)
            self.navigationController?.navigationBar.tintColor = TintColour
            self.navigationController?.navigationBar.isTranslucent = isTranslucent
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white , NSAttributedString.Key.font : FontBook.AileronBold.staticFont(size: FontSize.size20.rawValue)]
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
            if leftButton == "back" {
                let button = UIButton(type: UIButton.ButtonType.custom)
                button.setImage(#imageLiteral(resourceName: "BackArrow"), for:.normal)
                button.addTarget(self, action: #selector(btnBackAction), for:.touchUpInside)
                button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                let barButton = UIBarButtonItem(customView: button)
                self.navigationItem.leftBarButtonItem = nil
                self.navigationItem.leftBarButtonItem = barButton
            }
            else if leftButton == "menu" {
                let button = UIButton(type: UIButton.ButtonType.custom)
                button.setImage(#imageLiteral(resourceName: "menu"), for:.normal)
                button.addTarget(self, action: #selector(MenuBtnAction), for:.touchUpInside)
                button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                let barButton = UIBarButtonItem(customView: button)
                self.navigationItem.leftBarButtonItem = nil
                self.navigationItem.leftBarButtonItem = barButton
            }
            
            if IsNeedRightButton == true
            {
                let button = UIButton(type: UIButton.ButtonType.custom)
                button.setImage(#imageLiteral(resourceName: "logout"), for:.normal)
                button.addTarget(self, action: #selector(RightBtnAction), for:.touchUpInside)
                button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                let barButton = UIBarButtonItem(customView: button)
                self.navigationItem.rightBarButtonItem = nil
                self.navigationItem.rightBarButtonItem = barButton
            }
            
            if isRounded {
                navigationSetup(shadowLayer: shadowLayer, shadowView: shadowView)
            } else {
                
                shadowLayer.removeFromSuperlayer()
                shadowView.removeFromSuperview()
            }
    }
    
    // MARK:- Navigation Bar Button Action Methods
    
    @objc func RightBtnAction() {
        
        let alert = UIAlertController(title: AppInfo.appName, message: "Are you sure you want to log out?", preferredStyle: UIAlertController.Style.alert)
               
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            userDefault.removeObject(forKey: UserDefaultsKey.userProfile.rawValue)
                    userDefault.set(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
                    
                    userDefault.removeObject(forKey: UserDefaultsKey.storeInfo.rawValue)
                    userDefault.removeObject(forKey: UserDefaultsKey.isStoreSelected.rawValue)
                    
                    userDefault.removeObject(forKey: UserDefaultsKey.brandArr.rawValue)
                    userDefault.removeObject(forKey: UserDefaultsKey.brandData.rawValue)
                    
                    
                    // no need to clear..
            //        userDefault.removeObject(forKey: UserDefaultsKey.submitsToSync.rawValue)
                    
                    // set root window to login vc...
                    
                    let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    
                    let navigationController = UINavigationController(rootViewController: loginVC)
                    
                    navigationController.isNavigationBarHidden = true // or not, your choice.
                    UIApplication.shared.windows.first?.rootViewController = navigationController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
        let cancleAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancleAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func MenuBtnAction(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReportListViewController") as! ReportListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
       
    @objc func btnBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigationSetup(shadowLayer: CAShapeLayer,shadowView: UIView) {
        let hw: CGFloat = 18
            //4. Add shadow and cirner radius to navbar
            
            shadowView.backgroundColor = UIColor.white
            self.navigationController?.navigationBar.insertSubview(shadowView, at: -1)
    //        self.navigationController?.navigationBar.insertSubview(shadowView, below: self.navigationController?.navigationBar)
            self.navigationController?.navigationBar.insertSubview(shadowView, belowSubview: (self.navigationController?.view!)!)

            
            shadowLayer.path = UIBezierPath(roundedRect: shadowView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: hw, height: hw)).cgPath

            shadowLayer.fillColor = #colorLiteral(red: 1, green: 0.7452868819, blue: 0, alpha: 1)
            shadowLayer.shadowColor = UIColor.lightGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
            shadowView.layer.insertSublayer(shadowLayer, at: 0)
    //        shadowView.layer.insertSublayer(shadowLayer, below: self.navigationController?.navigationBar.layer)
            shadowView.layer.zPosition = -1
            
        }
}


extension UINavigationController {

    func getReference<ViewController: UIViewController>(to viewController: ViewController.Type) -> ViewController? {
        return viewControllers.first { $0 is ViewController } as? ViewController
    }
}
