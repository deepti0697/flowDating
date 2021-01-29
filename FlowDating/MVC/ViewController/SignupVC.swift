//
//  SignupVC.swift
//  FlowDating
//
//  Created by deepti on 25/01/21.
//

import UIKit

class SignupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openloginVC(_ sender: Any) {
        openViewController(controller: LoginVC.self, storyBoard: .mainStoryBoard) { (vc) in

        }
        
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupAction(_ sender: Any) {
        openViewController(controller: OtpScreen.self, storyBoard: .mainStoryBoard) { (vc) in

        }
    }
}
