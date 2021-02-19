//
//  ViewController.swift
//  FlowDating
//
//  Created by deepti on 25/01/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var roundedView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
//           self.roundedView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
//        self.roundedView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
           // Call the roundCorners() func right there.
     
       }

   
    @IBAction func signUpAction(_ sender: Any) {
        openViewController(controller: SignupVC.self, storyBoard: .mainStoryBoard) { (vc) in

        }
    }
    @IBAction func loginAction(_ sender: Any) {
        openViewController(controller: LoginVC.self, storyBoard: .mainStoryBoard) { (vc) in

        }
   
    }
  
}

