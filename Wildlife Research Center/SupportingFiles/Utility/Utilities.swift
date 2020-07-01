//
//  Utilities.swift
//  Wildlife Research Center
//
//  Created by Satyajit Sharma on 15/05/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class Utilities:NSObject{
    //MARK: - ================================
    //MARK: Device UDID
    //MARK: ==================================
    static let deviceId: String = (UIDevice.current.identifierForVendor?.uuidString)!
    
    //MARK: - ================================
    //MARK: Print Output
    //MARK: ==================================
    static func printOutput(_ items: Any){
        print(items)
    }
    //MARK: - ================================
    //MARK: ALERT MESSAGE
    //MARK: ==================================
    static func displayAlert(_ title: String, message: String, completion:((_ index: Int) -> Void)?, otherTitles: String? ...) {
        
        if message.trimmedString == "" {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if otherTitles.count > 0 {
            var i = 0
            for title in otherTitles {
                
                if let title = title {
                    alert.addAction(UIAlertAction(title: title, style: .default, handler: { (UIAlertAction) in
                        if (completion != nil) {
                            i += 1
                            completion!(i);
                        }
                    }))
                }
            }
        }
        //        else {
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (UIAlertAction) in
            if (completion != nil) {
                completion!(0);
            }
        }))
        //        }
        
        DispatchQueue.main.async {
            AppDelegate.shared.window?.rootViewController!.present(alert, animated: true, completion: nil)
        }
    }
    
    static func displayAlert(_ title: String, message: String, completion:((_ index: Int) -> Void)?, acceptTitle:String, otherTitles: String? ...) {
        if message.trimmedString == "" {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        var i = 0
        if otherTitles.count > 0 {
            for title in otherTitles {
                if let title = title {
                    let action = UIAlertAction(title: title, style: .default) { (action) in
                        if let tag = action.accessibilityAttributedHint?.string {
                            completion!(tag.toInt())
                        }
                    }
                    action.accessibilityAttributedHint = NSMutableAttributedString(string: "\(i+1)")
                    alert.addAction(action)
                    i += 1
                }
            }
        }
        alert.addAction(UIAlertAction(title: acceptTitle, style: .cancel, handler: { (UIAlertAction) in
            if (completion != nil) {
                completion!(0);
            }
        }))
        
        DispatchQueue.main.async {
            AppDelegate.shared.window?.rootViewController!.present(alert, animated: true, completion: nil)
        }
    }
    
    static func displayAlert(_ title: String, message: String) {
        Utilities.displayAlert(title, message: message, completion: nil)
    }
    
    static func displayAlert(_ message: String) {
        Utilities.displayAlert(AppInfo.appName, message: message, completion: nil)
    }
    
    static func displayErrorAlert(_ message: String) {
        Utilities.displayAlert("Error", message: message, completion: nil)
    }
    
    //MARK: - ================================
    //MARK: randomString
    //MARK: ==================================
    static func randomstring(_ n: Int) -> String
    {
        let a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var s = ""
        
        for _ in 0..<n
        {
            let r = Int(arc4random_uniform(UInt32(a.count)))
            
            s += String(a[a.index(a.startIndex, offsetBy: r)])
        }
        
        return s
    }
    //MARK:- =============================================
    //MARK: Time Duration in Time
    //MARK: ==============================================
    static func timeFormatted(_ totalSeconds: Int) -> String {
        
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    
    func isModal(vc: UIViewController) -> Bool {
        
        if let navigationController = vc.navigationController {
            if navigationController.viewControllers.first != vc {
                return false
            }
        }
        
        if vc.presentingViewController != nil {
            return true
        }
        
        if vc.navigationController?.presentingViewController?.presentedViewController == vc.navigationController {
            return true
        }
        
        if vc.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
    
    
    class func TempoFromSeconds(duration: Double, Bpm: Int) -> Double {
        return Double( 1.0 / (Double(Bpm) * 60.0 * 4.0 * duration))
    }
    
    class func ShowAlert(OfMessage : String) {
        let alert = UIAlertController(title: AppInfo.appName, message: OfMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        appDel.window?.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    
    class func showAlert(_ title: String, message: String, vc: UIViewController) -> Void
    {
        let alert = UIAlertController(title:title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        if(vc.presentedViewController != nil)
        {
            vc.dismiss(animated: true, completion: nil)
        }
        //vc will be the view controller on which you will present your alert as you cannot use self because this method is static.
        vc.present(alert, animated: true, completion: nil)
    }
    
    /// Response may be Any Type
    class func showAlertOfAPIResponse(param: Any, vc: UIViewController) {
        
        if let res = param as? String {
            Utilities.showAlert(AppInfo.appName, message: res, vc: vc)
        }
        else if let resDict = param as? NSDictionary {
            if let msg = resDict.object(forKey: "message") as? String {
                Utilities.showAlert(AppInfo.appName, message: msg, vc: vc)
            }
            else if let msg = resDict.object(forKey: "msg") as? String {
                Utilities.showAlert(AppInfo.appName, message: msg, vc: vc)
            }
            else if let msg = resDict.object(forKey: "message") as? [String] {
                Utilities.showAlert(AppInfo.appName, message: msg.first ?? "", vc: vc)
            }
        }
        else if let resAry = param as? NSArray {
            
            if let dictIndxZero = resAry.firstObject as? NSDictionary {
                if let message = dictIndxZero.object(forKey: "message") as? String {
                    Utilities.showAlert(AppInfo.appName, message: message, vc: vc)
                }
                else if let msg = dictIndxZero.object(forKey: "msg") as? String {
                    Utilities.showAlert(AppInfo.appName, message: msg, vc: vc)
                }
                else if let msg = dictIndxZero.object(forKey: "message") as? [String] {
                    Utilities.showAlert(AppInfo.appName, message: msg.first ?? "", vc: vc)
                }
            }
            else if let msg = resAry as? [String] {
                Utilities.showAlert(AppInfo.appName, message: msg.first ?? "", vc: vc)
            }
        }
    }
    
    
    class func showHud()
    {
        let size = CGSize(width: 40, height: 40)
        let activityData = ActivityData(size: size, message: "", messageFont: nil, messageSpacing: nil, type: .lineScale, color: colors.btnColor.value, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.black.withAlphaComponent(0.5), textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
    }
    
    class func hideHud()
    {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    /*
     class func showHUDWithoutLottie(with mainView: UIView?) {
     
     let obj = DataClass.getInstance()
     obj?.viewBackFull = UIView(frame: CGRect(x: 0, y: 0, width: mainView?.frame.size.width ?? 0.0, height: mainView?.frame.size.height ?? 0.0))
     obj?.viewBackFull?.backgroundColor = UIColor.black.withAlphaComponent(0.2)
     let imgGlass = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))//239    115    40
     imgGlass.backgroundColor = UIColor.black.withAlphaComponent(0.0) //UIColor(red: 239/255, green: 115/255, blue: 40/255, alpha: 1.0)//
     //        self._loadAnimationNamed("Loading", view: imgGlass, dataClass: obj)
     imgGlass.center = obj?.viewBackFull?.center ?? CGPoint(x: 0, y: 0)
     imgGlass.layer.cornerRadius = 15.0
     imgGlass.layer.masksToBounds = true
     obj?.viewBackFull?.addSubview(imgGlass)
     mainView?.addSubview(obj?.viewBackFull ?? UIView())
     }
     
     
     class func showHUDWithLottie(with mainView: UIView?) {
     
     let obj = DataClass.getInstance()
     obj?.viewBackFull = UIView(frame: CGRect(x: 0, y: 0, width: mainView?.frame.size.width ?? 0.0, height: mainView?.frame.size.height ?? 0.0))
     obj?.viewBackFull?.backgroundColor = UIColor.black.withAlphaComponent(0.2)
     let imgGlass = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))//239    115    40
     imgGlass.backgroundColor = UIColor.black.withAlphaComponent(0.0) //UIColor(red: 239/255, green: 115/255, blue: 40/255, alpha: 1.0)//
     self._loadAnimationNamed("loadingDog", view: imgGlass, dataClass: obj)
     imgGlass.center = obj?.viewBackFull?.center ?? CGPoint(x: 0, y: 0)
     imgGlass.layer.cornerRadius = 15.0
     imgGlass.layer.masksToBounds = true
     obj?.viewBackFull?.addSubview(imgGlass)
     mainView?.addSubview(obj?.viewBackFull ?? UIView())
     }
     
     class func _loadAnimationNamed(_ named: String?, view mainView: UIView?, dataClass obj: DataClass?) {
     
     obj?.laAnimation = AnimationView(name: named ?? "")
     obj?.laAnimation?.frame = mainView?.frame ?? CGRect(x: 0, y: 0, width: 0, height: 0)//CGRect(x: (mainView?.center.x ?? 0.0) / 2 - 3, y: 20, width: 140, height: 140)
     obj?.laAnimation?.contentMode = .scaleAspectFill
     obj?.laAnimation?.center = mainView?.center ?? CGPoint(x: 0, y: 0)
     obj?.laAnimation?.play(fromProgress: 0,
     toProgress: 1,
     loopMode: LottieLoopMode.loop,
     completion: { (finished) in
     if finished {
     
     } else {
     
     }
     })
     obj?.laAnimation?.layer.masksToBounds = true
     mainView?.setNeedsLayout()
     if let laAnimation = obj?.laAnimation {
     mainView?.addSubview(laAnimation)
     }
     
     }
     
     class func showDataNotFound(text:String,View:UIView,isHidden:Bool) {
     let label = UILabel(frame: CGRect(x:UIScreen.main.bounds.width/2 - 120,y:UIScreen.main.bounds.height/2 - 25,width:240,height: 50))
     label.textAlignment = .center
     label.textColor = .black
     // label.backgroundColor = .yellow
     label.font = UIFont(name:AppExtraBold, size:15.0)
     label.text =  text
     View.addSubview(label)
     View.isHidden = isHidden
     label.isHidden = isHidden
     }
     
     class func hideHUD() {
     let obj = DataClass.getInstance()
     
     DispatchQueue.main.async(execute: {
     obj?.viewBackFull?.removeFromSuperview()
     })
     
     }
     */
    
    //MARK:- Date string format change ========
    class func DateStringChange(Format:String,getFormat:String,dateString:String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Format                // Note: S is fractional second
        let dateFromString = dateFormatter.date(from: dateString)      // "Nov 25, 2015, 4:31 AM" as NSDate
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat =  getFormat//"MMM d, yyyy h:mm a"
        
        let stringFromDate = dateFormatter2.string(from: dateFromString!) // "Nov 25, 2015" as String
        return stringFromDate
    }
    
    class func showAlertWithTwoAction(_ title: String, message: String, _ completion: (() -> ())? = nil) -> Void
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (sct) in
        //
        //        }
        let OkAction = UIAlertAction(title:"OK" , style: .default) { (sct) in
            completion?()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(OkAction)
        alert.addAction(cancelAction)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    
    class func getReadableDate(timeStamp: TimeInterval , isFromTime : Bool) -> String? {
        let date = Date(timeIntervalSinceNow: timeStamp)//Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInTomorrow(date) {
            dateFormatter.dateFormat = "h:mm a"
            return "Tomorrow at \(dateFormatter.string(from: date))"
            
        } else if Calendar.current.isDateInYesterday(date) {
            dateFormatter.dateFormat = "h:mm a"
            return "Yesterday at \(dateFormatter.string(from: date))"
        } else if dateFallsInCurrentWeek(date: date) {
            if Calendar.current.isDateInToday(date) {
                if isFromTime == true{
                    dateFormatter.dateFormat = "h:mm a"
                    return dateFormatter.string(from: date)
                    
                }
                else{
                    dateFormatter.dateFormat = "h:mm a"
                    return "Today at \(dateFormatter.string(from: date))"
                }
                
            } else {
                dateFormatter.dateFormat = "EEEE h:mm a"
                return dateFormatter.string(from: date)
            }
        } else {
            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
            return dateFormatter.string(from: date)
        }
    }
    class func dateFallsInCurrentWeek(date: Date) -> Bool {
        let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
        let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
        return (currentWeek == datesWeek)
    }
    
    //MARK:- Date string format change ========
    class func getDateTimeString(dateString:String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"                 // Note: S is fractional second
        let dateFromString = dateFormatter.date(from: dateString)      // "Nov 25, 2015, 4:31 AM" as NSDate
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd/MM/yyyy"//"MMM d, yyyy h:mm a"
        
        let stringFromDate = dateFormatter2.string(from: dateFromString!) // "Nov 25, 2015" as String
        return stringFromDate
    }
    class func topMostController() -> UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        
        return topController
    }
    
    class func sizePerMB(url: URL?) -> Double {
        guard let filePath = url?.path else {
            return 0.0
        }
        do {
            let attribute = try FileManager.default.attributesOfItem(atPath: filePath)
            if let size = attribute[FileAttributeKey.size] as? NSNumber {
                return size.doubleValue / 1000000.0
            }
        } catch {
            print("Error: \(error)")
        }
        return 0.0
    }
    
    
      //MARK:- Custom Method
    class  func getAudioFromDocumentDirectory(audioStr : String , documentsFolderUrl : URL) -> Data?
        {
            guard let audioUrl = URL(string: audioStr) else { return nil}
            let destinationUrl = documentsFolderUrl.appendingPathComponent(audioUrl.lastPathComponent)
              
            if FileManager().fileExists(atPath: destinationUrl.path)
            {
    //            let assets = AVAsset(url: audioUrl)
    //           print(assets)
                do {
                    let GetAudioFromDirectory = try Data(contentsOf: destinationUrl)
                     print("audio : ", GetAudioFromDirectory)
                    return GetAudioFromDirectory
                }catch(let error){
                    print(error.localizedDescription)
                }
            }
            else{
                print("No Audio Found")
            }
            return nil
        }
    
    class func GetDestinationUrlOfSong(audioStr : String , documentsFolderUrl : URL) -> URL?
    {
        guard let audioUrl = URL(string: audioStr) else { return nil}
        return documentsFolderUrl.appendingPathComponent(audioUrl.lastPathComponent)
        
    }
    
    /*
     var instance: DataClass? = nil
     class DataClass {
     
     var str = ""
     
     var laAnimation: AnimationView?
     var viewBackFull: UIView?
     
     
     class func getInstance() -> DataClass? {
     let lockQueue = DispatchQueue(label: "self")
     lockQueue.sync {
     if instance == nil {
     instance = DataClass()
     }
     }
     return instance
     }
     }
     */
    
    public func formattedNumber(number: String, mask:String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    public func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
}


extension UIImage {
    
    func normalizedImage() -> UIImage {

        if (self.imageOrientation == UIImage.Orientation.up) {
          return self;
      }

      UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
      let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.draw(in: rect)

        let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext();
      return normalizedImage;
    }
    
}
