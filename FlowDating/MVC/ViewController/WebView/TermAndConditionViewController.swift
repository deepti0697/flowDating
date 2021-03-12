//
//  TermAndConditionViewController.swift
//  DreamTeam
//
//  Created by Test on 13/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import WebKit
class TermAndConditionViewController: UIViewController,WKNavigationDelegate {
    
    var isBackNavigtn = false
  
    @IBOutlet weak var aWebView: WKWebView!
    override func viewDidLoad() {
            super.viewDidLoad()
        aWebView.navigationDelegate = self
        }
        
         func openWebView() {
            AppManager.init().hudShow()
          
            let url = URL(string: ServiceUrls.webBaseURl + ServiceUrls.termAndCondition )
                if let urlLink = url {
                    let request = URLRequest(url: urlLink)
                    AppManager.init().hudHide()
                    aWebView.load(request)
                }
            }
            
        
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            openWebView()
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            
//            self.navigationController?.isNavigationBarHidden = true
        }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //Show loader
        AppManager.init().hudShow()
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //Hide loader
        AppManager.init().hudHide()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //Hide loader
    }
       
    @IBAction func backButton(_ sender: Any) {
  
            self.navigationController?.popViewController(animated: true)
       
    }
}
