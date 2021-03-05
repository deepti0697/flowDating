//
//  CompleteypuProfileVC4.swift
//  FlowDating
//
//  Created by deepti on 28/01/21.
//

import UIKit

class CompleteypuProfileVC4: UIViewController {

    @IBOutlet weak var baseview2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()

           // Call the roundCorners() func right there.
     
        self.baseview2.roundCorners(corners: [.topLeft, .topRight], radius: 30)
       }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    @IBAction func backButttonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func latterACtion(_ sender: Any) {
//        appDelegate.setHomeView()
//        openViewController(controller: HomeVC.self, storyBoard: .mainStoryBoard) { (vc) in
//
//        }
        appdelegate.setHomeVC()
    }
    
    @IBAction func openSurveyVcAction(_ sender: Any) {
        openViewController(controller: SurveyVC.self, storyBoard: .mainStoryBoard) { (vc) in
            vc.isComingFromRegistration = true
//            vc.backButtonOutlt.isHidden = false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
