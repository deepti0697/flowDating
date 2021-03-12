//
//  FQsViewController.swift
//  DreamTeam
//
//  Created by Test on 28/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import WebKit
class FQsViewController: UIViewController,WKNavigationDelegate{
   
    @IBOutlet weak var aWebView: WKWebView!
     override func viewDidLoad() {
            super.viewDidLoad()
            openWebView()
        aWebView.navigationDelegate = self
        }
        
        private func openWebView() {
      
            let url = URL(string: ServiceUrls.webBaseURl + ServiceUrls.FAQUrl)
            if let urlLink = url {
                let request = URLRequest(url: urlLink)
                aWebView.load(request)
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(true, animated: false)
//            http://14.98.110.246:9020/faq/en
        }

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    }
