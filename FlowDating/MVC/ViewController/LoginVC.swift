//
//  LoginVC.swift
//  FlowDating
//
//  Created by deepti on 25/01/21.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func opensignupVC(_ sender: Any) {
        openViewController(controller: SignupVC.self, storyBoard: .mainStoryBoard) { (vc) in

        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        openViewController(controller: OtpScreen.self, storyBoard: .mainStoryBoard) { (vc) in

        }
    }
}
