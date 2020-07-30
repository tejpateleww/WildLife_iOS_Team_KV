//
//  HelpVC.swift
//  Wildlife Research Center
//
//  Created by EWW074 - Sj's iMAC on 07/07/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import UIKit
import WebKit

class HelpVC: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        webView.isHidden = false
        
        if WebService.shared.isConnected {
            Utilities.showHud()
            let url = URL(string: "https://www.wildlife.com/app-display-instructions.php")!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        } else {
            webView.isHidden = true
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
            setNavBarWithMenuORBack(Title: "Retail Report", leftButton: "back", IsNeedRightButton: false, isTranslucent: false)
           
       }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Utilities.hideHud()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Utilities.hideHud()
        Utilities.displayErrorAlert(error.localizedDescription)
    }
    

}
