//
//  RetailReportThirdViewController.swift
//  Wildlife Research Center
//
//  Created by EWW074 on 24/04/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import SwiftyJSON

class RetailReportThirdViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnTakePicture: ThemeButton!
    @IBOutlet weak var btnTakeFromGallary: ThemeButton!
    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var vwForCollection_HeightConstraint: NSLayoutConstraint!
    
    
    
    //MARK:- Properties
    var aryData = ["","","","","",""]
    var arr_OfImages : [UIImage] = []
    var arr_PhotoModal : [PhotoModal] = []
    
    var apiCallCount: Int = 0
    
    var photo1_Name : String = ""
    var photo2_Name : String = ""
    var photo3_Name : String = ""
    var photo4_Name : String = ""
    var photo5_Name : String = ""
    var photo6_Name : String = ""
    
    var wildlife_product_set_up = false
    var wildlife_product_displayed_correctly = false
    var discuss_any_issues = false
    var product_training = false
    var did_you_work_an_event = false
    var did_you_leave_seps = false
    var were_our_products_priced = false
    var ask_someone_to_price = false
    
    var brandname1 = ""
    var scent_elimination_facings1 = ""
    var scent_elimination_pallet_displays1 = ""
    var scent_and_dispenser_facings1 = ""
    var scent_and_dispenser_pallet_facings1 = ""
    var exclusive_end_cap_1 = ""
    
    var brandname2 = ""
    var scent_elimination_facings2 = ""
    var scent_elimination_pallet_displays2 = ""
    var scent_and_dispenser_facings2 = ""
    var scent_and_dispenser_pallet_facings2 = ""
    var exclusive_end_cap_2 = ""
    
    var brandname3 = ""
    var scent_elimination_facings3 = ""
    var scent_elimination_pallet_displays3 = ""
    var scent_and_dispenser_facings3 = ""
    var scent_and_dispenser_pallet_facings3 = ""
    var exclusive_end_cap_3 = ""
    
    var brandname4 = ""
    var scent_elimination_facings4 = ""
    var scent_elimination_pallet_displays4 = ""
    var scent_and_dispenser_facings4 = ""
    var scent_and_dispenser_pallet_facings4 = ""
    var exclusive_end_cap_4 = ""
    
    var brandname5 = ""
    var scent_elimination_facings5 = ""
    var scent_elimination_pallet_displays5 = ""
    var scent_and_dispenser_facings5 = ""
    var scent_and_dispenser_pallet_facings5 = ""
    var exclusive_end_cap_5 = ""
    
    var brandname6 = ""
    var scent_elimination_facings6 = ""
    var scent_elimination_pallet_displays6 = ""
    var scent_and_dispenser_facings6 = ""
    var scent_and_dispenser_pallet_facings6 = ""
    var exclusive_end_cap_6 = ""
    
    var brandname7 = ""
    var scent_elimination_facings7 = ""
    var scent_elimination_pallet_displays7 = ""
    var scent_and_dispenser_facings7 = ""
    var scent_and_dispenser_pallet_facings7 = ""
    var exclusive_end_cap_7 = ""
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         setNavBarWithMenuORBack(Title: "Retail Report", leftButton: "back", IsNeedRightButton: true, isTranslucent: false)
        
    }
    
    
    //MARK:- Events
    @IBAction func takePictureFromCamera(_ sender: ThemeButton) {
        
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.delegate = self
            present(vc, animated: true)
    }
    
    @IBAction func takePictureFromLibrary(_ sender: ThemeButton) {
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 1
        
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset :
            
        }, deselect: { (asset) in
            // User deselected an asset
        }, cancel: { (assets) in
            // User canceled selection
        }, finish: { (assets) in
            // User finished selection assets
            // targetSize: PHImageManagerMaximumSize
        
            
            var img : UIImage?
            assets.forEach { (asset) in
                PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: nil) { (image, info) in
                    //added to Img Arr
                    img = image!
                }
            }
            
            self.arr_OfImages.append(img!)
            self.collectionView.reloadData()
            
            if WebService.shared.isConnected { // Added to Modal
                
                //Save the server path from api call into arrPhotoModal
                self.webServiceCallToUploadASingleImage(img: self.arr_OfImages.last!)
                
            } else {
                
                // Save the image as PNG DATA into the arrPhotomodal
                let id = self.arr_PhotoModal.count
                let imgData = self.arr_OfImages.last!.pngData()
                
                let newModal = PhotoModal(id: id, type: "img", serverPath: nil, img_inDataForm: imgData!)
                self.arr_PhotoModal.append(newModal)
            }
            
        })
    }
    
    
    @IBAction func submitBtnClicked(_ sender: ThemeButton) {
        webServiceSubmit()
    }
}


// Collectionview For images uploaded
extension RetailReportThirdViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return arr_OfImages.isEmpty ? aryData.count : arr_OfImages.count
        
        if arr_OfImages.count > 0 {
            self.vwForCollection_HeightConstraint.constant = 160
        } else {
            self.vwForCollection_HeightConstraint.constant = 0
        }
        return arr_OfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RetailReportThirdCollectionViewCell", for: indexPath) as! RetailReportThirdCollectionViewCell
    
        if arr_OfImages.isEmpty {
//            cell.imgPicked.image = UIImage(named: "Logo")
            self.vwForCollection_HeightConstraint.constant = 0
        }
        else {
            cell.imgPicked.image = arr_OfImages[indexPath.row]
        }
        
        cell.isRemoved = {
            if self.arr_OfImages.isEmpty {
//                guard self.aryData.count != 0 else {return}
//
//                self.aryData.remove(at: indexPath.row)
//                self.collectionView.reloadData()
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    if self.aryData.count == 0 {
//                        self.aryData = ["","","","","",""]
//                        self.collectionView.reloadData()
//                    }
//                }
                
                // Collection view constraint change...
                
                self.vwForCollection_HeightConstraint.constant = 0
            }
            else {
                self.arr_OfImages.remove(at: indexPath.row)
                if self.arr_OfImages.isEmpty {
                    self.aryData = ["","","","","",""]
                }
                self.collectionView.reloadData()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = collectionView.frame.width / 3 // 100
        let height: CGFloat = width

        return CGSize(width: width, height: height)
    }
    
}


// Image picker delegate just for Taking picture from camera
extension RetailReportThirdViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        print(image.size)
        //added to arr of imgs
        arr_OfImages.append(image)
        self.collectionView.reloadData()
        
        
        if WebService.shared.isConnected {
            //Save the server path from api call into arrPhotoModal
            webServiceCallToUploadASingleImage(img: image)
            
        } else {
            
            // Save the image as PNG DATA into the arrPhotomodal
            let id = self.arr_PhotoModal.count
            let imgData = image.pngData()
            
            let newModal = PhotoModal(id: id, type: "img", serverPath: nil, img_inDataForm: imgData!)
            self.arr_PhotoModal.append(newModal)
        }
    }
    
    // Called on 2 places : When an image is selected from gallery in custom picker view delegate and take picture from camera .. native pickerview delegate.
    func webServiceCallToUploadASingleImage(img: UIImage) {
        
        WebServiceSubClass.imageUploadAPI(image: img, showhud: true) { (json, success, resp) in
            
            if success {
                
                let id = self.arr_OfImages.count
                let path = json["result"].stringValue
                
                let newModal = PhotoModal(id: id, type: "path", serverPath: path, img_inDataForm: nil)
                self.arr_PhotoModal.append(newModal)
                
                print(self.arr_PhotoModal.count)
                
//                self.photo1_Name = json["result"].stringValue
            } else {
                Utilities.displayAlert(json["message"].stringValue)
            }
        }
    }
    
    
    
    // Below function is Called when submit report button is pressed. WE collect all the data from these different modals
    // UserInfo (Submodals : ResProfileDatum)
    // StoreInfo (Submodal : RetailStoreQuestion)
    // BrandData (Submodal : ScentData)
    
    func webServiceSubmit() {
        
        var params : [String:Any] = [:]
        
        
        //User Information
        let data = userDefault.value(forKey: UserDefaultsKey.userProfile.rawValue) as? Data
        let userModal = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as? UserInfo
        
        params["createdByUserNum"] = (userModal?.data.createdByUserNum ?? "") as Any
        params["submitedby"] = (userModal?.data.full_name ?? "") as Any
        params["email"] = (userModal?.data.email_address ?? "") as Any
        params["rep_group"] = (userModal?.data.rep_group ?? "") as Any
        
        //Store Information
        let storeData = userDefault.object(forKey: UserDefaultsKey.storeInfo.rawValue) as? Data
        let storeinfo = try? PropertyListDecoder().decode(StoreInfo.self, from: storeData!)
        
        storeinfo?.retailStoreQuestions_Arr.forEach({ (eachSetOfData) in
            switch eachSetOfData.Title!
            {
            case "Were wildlife products set-Up in store?" :
                self.wildlife_product_set_up = eachSetOfData.isOn
            case "Were our products priced?" :
                self.were_our_products_priced = eachSetOfData.isOn
            case "If not, did you ask someone to price them?" :
                self.ask_someone_to_price = eachSetOfData.isOn
            case "Were our products displayed correctly?" :
                self.wildlife_product_displayed_correctly = eachSetOfData.isOn
            case "Did you discuss any issues with store personnel?" :
                self.discuss_any_issues = eachSetOfData.isOn
            case "Did you do product training?" :
                self.product_training = eachSetOfData.isOn
            case "Did you leave SEP's?" :
                self.did_you_leave_seps = eachSetOfData.isOn
            case "Did you work on event?" :
                self.did_you_work_an_event = eachSetOfData.isOn
            default :
                print("s")
            }
        })
        
        params["store_name"] = (storeinfo?.storeName ?? "") as Any
        params["store_state"] = (storeinfo?.stateName ?? "") as Any
        params["store_city"] = (storeinfo?.cityName ?? "") as Any
        
        params["wildlife_product_set_up"] = wildlife_product_set_up as Any
        params["were_our_products_priced"] = were_our_products_priced as Any
        params["ask_someone_to_price"] = ask_someone_to_price as Any
        params["wildlife_product_displayed_correctly"] = wildlife_product_displayed_correctly as Any
        params["discuss_any_issues"] = discuss_any_issues as Any
        params["product_training"] = product_training as Any
        params["did_you_leave_seps"] = did_you_leave_seps as Any
        params["did_you_work_an_event"] = did_you_work_an_event as Any
        
        
        //Brand Information
        let brandArrdata = userDefault.object(forKey: UserDefaultsKey.brandArr.rawValue) as? Data
        let brandinfo = try? PropertyListDecoder().decode(Array<BrandData>.self, from: brandArrdata!)
        
        brandinfo?.forEach({ (brand) in
            switch brand.brandName
            {
            case "Wildlife Research Center" :
                brandname1 = brand.brandName
                scent_elimination_facings1 = "\(brand.scentData.scent_Elimination_Facings ?? 0)"
                scent_elimination_pallet_displays1 = "\(brand.scentData.scent_Elimination_Pallet_Displays ?? 0)"
                scent_and_dispenser_facings1 = "\(brand.scentData.scent_And_Dispenser_Facings ?? 0)"
                scent_and_dispenser_pallet_facings1 = "\(brand.scentData.scent_And_Dispenser_Pallet_Displays ?? 0)"
                exclusive_end_cap_1 = "\(brand.scentData.does_this_Brand_have_An_Exclusive_EndCap ?? 0)"
                
            case "Tink's / Dead Down Wind" :
                brandname2 = brand.brandName
                scent_elimination_facings2 = "\(brand.scentData.scent_Elimination_Facings ?? 0)"
                scent_elimination_pallet_displays2 = "\(brand.scentData.scent_Elimination_Pallet_Displays ?? 0)"
                scent_and_dispenser_facings2 = "\(brand.scentData.scent_And_Dispenser_Facings ?? 0)"
                scent_and_dispenser_pallet_facings2 = "\(brand.scentData.scent_And_Dispenser_Pallet_Displays ?? 0)"
                exclusive_end_cap_2 = "\(brand.scentData.does_this_Brand_have_An_Exclusive_EndCap ?? 0)"
                
            case "Hunter's Specialties/ Buck Bomb" :
                brandname3 = brand.brandName
                scent_elimination_facings3 = "\(brand.scentData.scent_Elimination_Facings ?? 0)"
                scent_elimination_pallet_displays3 = "\(brand.scentData.scent_Elimination_Pallet_Displays ?? 0)"
                scent_and_dispenser_facings3 = "\(brand.scentData.scent_And_Dispenser_Facings ?? 0)"
                scent_and_dispenser_pallet_facings3 = "\(brand.scentData.scent_And_Dispenser_Pallet_Displays ?? 0)"
                exclusive_end_cap_3 = "\(brand.scentData.does_this_Brand_have_An_Exclusive_EndCap ?? 0)"
                
            case "Code Blue" :
                brandname4 = brand.brandName
                scent_elimination_facings4 = "\(brand.scentData.scent_Elimination_Facings ?? 0)"
                scent_elimination_pallet_displays4 = "\(brand.scentData.scent_Elimination_Pallet_Displays ?? 0)"
                scent_and_dispenser_facings4 = "\(brand.scentData.scent_And_Dispenser_Facings ?? 0)"
                scent_and_dispenser_pallet_facings4 = "\(brand.scentData.scent_And_Dispenser_Pallet_Displays ?? 0)"
                exclusive_end_cap_4 = "\(brand.scentData.does_this_Brand_have_An_Exclusive_EndCap ?? 0)"
                
            case "Conquest" :
                brandname5 = brand.brandName
                scent_elimination_facings5 = "\(brand.scentData.scent_Elimination_Facings ?? 0)"
                scent_elimination_pallet_displays5 = "\(brand.scentData.scent_Elimination_Pallet_Displays ?? 0)"
                scent_and_dispenser_facings5 = "\(brand.scentData.scent_And_Dispenser_Facings ?? 0)"
                scent_and_dispenser_pallet_facings5 = "\(brand.scentData.scent_And_Dispenser_Pallet_Displays ?? 0)"
                exclusive_end_cap_5 = "\(brand.scentData.does_this_Brand_have_An_Exclusive_EndCap ?? 0)"
                
            case "Nose Jammer" :
                brandname6 = brand.brandName
                scent_elimination_facings6 = "\(brand.scentData.scent_Elimination_Facings ?? 0)"
                scent_elimination_pallet_displays6 = "\(brand.scentData.scent_Elimination_Pallet_Displays ?? 0)"
                scent_and_dispenser_facings6 = "\(brand.scentData.scent_And_Dispenser_Facings ?? 0)"
                scent_and_dispenser_pallet_facings6 = "\(brand.scentData.scent_And_Dispenser_Pallet_Displays ?? 0)"
                exclusive_end_cap_6 = "\(brand.scentData.does_this_Brand_have_An_Exclusive_EndCap ?? 0)"
                
            case "Other" :
                brandname7 = brand.brandName
                scent_elimination_facings7 = "\(brand.scentData.scent_Elimination_Facings ?? 0)"
                scent_elimination_pallet_displays7 = "\(brand.scentData.scent_Elimination_Pallet_Displays ?? 0)"
                scent_and_dispenser_facings7 = "\(brand.scentData.scent_And_Dispenser_Facings ?? 0)"
                scent_and_dispenser_pallet_facings7 = "\(brand.scentData.scent_And_Dispenser_Pallet_Displays ?? 0)"
                exclusive_end_cap_7 = "\(brand.scentData.does_this_Brand_have_An_Exclusive_EndCap ?? 0)"
                
            default :
                print("default case")
            }
        })
        
        
        brandinfo?.forEach({ (brand) in
            
            let id = brand.id
            let name = brand.brandName
            let scentData = brand.scentData
            
            let key1 = "brandname\(id!)"
            let key2 = "scent_elimination_facings\(id!)"
            let key3 = "scent_elimination_pallet_displays\(id!)"
            let key4 = "scent_and_dispenser_facings\(id!)"
            let key5 = "scent_and_dispenser_pallet_facings\(id!)"
            let key6 = "exclusive_end_cap_\(id!)"
            
            params[key1] = name! as Any
            params[key2] = (scentData?.scent_Elimination_Facings ?? 0) as Any
            params[key3] = (scentData?.scent_Elimination_Pallet_Displays ?? 0) as Any
            params[key4] = (scentData?.scent_And_Dispenser_Facings ?? 0) as Any
            params[key5] = (scentData?.scent_And_Dispenser_Pallet_Displays ?? 0) as Any
            params[key6] = (scentData?.does_this_Brand_have_An_Exclusive_EndCap ?? 0) as Any
            
        })
        
        
        // Image Uploaded Information :
        
        var arr_Of_ImgData_ToReportListVC : [PhotoModal] = []
        
        arr_PhotoModal.forEach { (modal) in
            
            if modal.type == "path" {
                
                let key = "photos_\(modal.id)"
                params[key] = modal.img_ServerPAth
                
            } else {
                
                arr_Of_ImgData_ToReportListVC.append(modal)
            }
            
        }
        
        self.arr_PhotoModal = arr_Of_ImgData_ToReportListVC
            
        //Comment from local Textview
        
        var commentTxt = txtView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if commentTxt == "Please add your comment" {
            commentTxt = ""
        }
        
        params["comments"] = commentTxt.trimmedString
        
        
        
        print(params)
        
        if WebService.shared.isConnected {
            
            WebServiceSubClass.submit(params: params as Any, showhud: true) { (json, success, resp) in
                if success {
                    //make a toast and reset everything.
                    userDefault.removeObject(forKey: UserDefaultsKey.storeInfo.rawValue)
                    userDefault.set(false, forKey: UserDefaultsKey.isStoreSelected.rawValue)
                    
                    userDefault.removeObject(forKey: UserDefaultsKey.brandArr.rawValue)
                    userDefault.removeObject(forKey: UserDefaultsKey.brandData.rawValue)
                    
                    
                    Utilities.displayAlert("Report submitted Successfully")
                    
                    let alert = UIAlertController(title: AppInfo.appName, message: "Report submitted successfully", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        guard let mainVC = self.navigationController?.getReference(to: RetailReportMainViewController.self) else { return }
                        mainVC.comesAfterSubmission = true
                        self.navigationController?.popToViewController(mainVC, animated: true)
                    }
                    
                    alert.addAction(okAction)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    
                    
                } else {
                    let alert = UIAlertController(title: AppInfo.appName, message: json["message"].stringValue, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        } else {
            
            //if offline :
            let alert = UIAlertController(title: "Save this report?", message: "You can not edit this report once it is saved", preferredStyle: .alert)
            
            let keepEditingAction = UIAlertAction(title: "Keep Editing", style: .default, handler: nil)
            
            let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
                
                
                // 1. Fetch the Array of APP Users
                var arr_AppUsers : [AppUser]?
                
                let appUser_Data = userDefault.object(forKey: UserDefaultsKey.appUsers.rawValue) as? Data
                if appUser_Data != nil {
                    arr_AppUsers = try? PropertyListDecoder().decode(Array<AppUser>.self, from: appUser_Data!)
                } else {
                    arr_AppUsers = []
                }
                
                // 2. Create an offline Report Modal using current Params and Img Arr Maintained on this VC ( Note: We save the params as Data)
                let params_Data = try? JSONSerialization.data(withJSONObject: params)
                let new_offline_Report = OfflineReportModal(paramsDict: params_Data!, imgArr: self.arr_PhotoModal)
                
                
                // 3. Add the newly created Offline Report to -> the Array of offline reports OF -> The Current User (Matched using Email)
                for i in 0..<arr_AppUsers!.count {
                    if arr_AppUsers![i].emailID == userModal?.data.email_address {
                        arr_AppUsers![i].arr_OfflineReports.append(new_offline_Report)
                    }
                }
                
                // 4. Save the updated Array of APP USERs back to user Defaults
                let arrAppUsers_data = try? PropertyListEncoder().encode(arr_AppUsers)
                userDefault.set(arrAppUsers_data, forKey: UserDefaultsKey.appUsers.rawValue)

                //Clear all other user defaults ..
                userDefault.removeObject(forKey: UserDefaultsKey.storeInfo.rawValue)
                userDefault.set(false, forKey: UserDefaultsKey.isStoreSelected.rawValue)
                userDefault.removeObject(forKey: UserDefaultsKey.brandArr.rawValue)
                userDefault.removeObject(forKey: UserDefaultsKey.brandData.rawValue)
                
                Utilities.displayAlert("Report Saved! You can synchronize your report later")
                
                guard let mainVC = self.navigationController?.getReference(to: RetailReportMainViewController.self) else { return }
                mainVC.comesAfterSubmission = true
                self.navigationController?.popToViewController(mainVC, animated: true)
                
            
            }
            
            alert.addAction(keepEditingAction)
            alert.addAction(saveAction)
            
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func saveImageInUserDefault(img:UIImage, key:String) {
        UserDefaults.standard.set(img.pngData(), forKey: key)
    }

    func getImageFromUserDefault(key:String) -> UIImage? {
        let imageData = UserDefaults.standard.object(forKey: key) as? Data
        var image: UIImage? = nil
        if let imageData = imageData {
            image = UIImage(data: imageData)
        }
        return image
    }
    
}



extension RetailReportThirdViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Please add your comment" {
            txtView.text = ""
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            txtView.text = "Please add your comment"
        }
    }
    
}
