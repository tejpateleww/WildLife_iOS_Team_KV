//
//  SearchVC.swift
//  Wildlife Research Center
//
//  Created by EWW074 - Sj's iMAC on 22/07/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var vw_Top: UIView!
    @IBOutlet weak var vw_Search: UIView!
    @IBOutlet weak var btn_cancel: UIButton!
    @IBOutlet weak var btn_Add: UIButton!
    
    @IBOutlet weak var txtField_Search: UITextField!
    @IBOutlet weak var tblView_Search: UITableView!
    
    var list : [String] = []
    var arr_Searched : [String] = []
    var tag : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_Add.isHidden = true
        txtField_Search.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewDidLayoutSubviews() {
        self.vw_Search.layer.cornerRadius = self.vw_Search.frame.height / 2
        
    }
    
    // Events :
    
    @IBAction func CancelBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBtnAction(_ sender: UIButton) {
        
        let pre : UINavigationController = presentingViewController as! UINavigationController
        let lastvc = pre.viewControllers.last
        
        if let presenter = lastvc as? SelectStoreViewController {
            presenter.selectedValue_3 = txtField_Search.text!
            
            self.dismiss(animated: true) {
                presenter.refreshValues()
            }
        }
        
    }
    
    // Textfield Delegate
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.txtField_Search.text?.count == 0 {
            self.arr_Searched = []
            tblView_Search.reloadData()
        } else {
            self.arr_Searched = list.filter { $0.lowercased().contains(textField.text!.lowercased())}
            
            if arr_Searched.isEmpty && tag == 3 {
                //
                btn_Add.isHidden = false
            }
            
            tblView_Search.reloadData()
        }
    }
    
    
    //Tableview Delegate and Datsource ..
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if txtField_Search.text?.count == 0 {
            return list.count
        } else {
            return arr_Searched.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTblViewCell", for: indexPath) as! searchTblViewCell
        
        
        if txtField_Search.text!.count == 0 {
            cell.lbl_title.text = list[indexPath.row]
        } else {
            cell.lbl_title.text = arr_Searched[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let pre : UINavigationController = presentingViewController as! UINavigationController
        let lastvc = pre.viewControllers.last
        
        if let presenter = lastvc as? SelectStoreViewController {
            
            if txtField_Search.text?.count == 0 {
                switch tag {
                case 1:
                    presenter.selectedValue_1 = self.list[indexPath.row]
                case 2:
                    presenter.selectedValue_2 = self.list[indexPath.row]
                case 3:
                    presenter.selectedValue_3 = self.list[indexPath.row]
                case 4:
                    presenter.selectedValue_4 = self.list[indexPath.row]
                case 5:
                    presenter.selectedValue_5 = self.list[indexPath.row]
                default:
                    print("defualt")
                }
            } else {
                switch tag {
                case 1:
                    presenter.selectedValue_1 = self.arr_Searched[indexPath.row]
                case 2:
                    presenter.selectedValue_2 = self.arr_Searched[indexPath.row]
                case 3:
                    presenter.selectedValue_3 = self.arr_Searched[indexPath.row]
                case 4:
                    presenter.selectedValue_4 = self.arr_Searched[indexPath.row]
                case 5:
                    presenter.selectedValue_5 = self.arr_Searched[indexPath.row]
                default:
                    print("defualt")
                }
            }
            
            self.dismiss(animated: true) {
                presenter.refreshValues()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    

}

