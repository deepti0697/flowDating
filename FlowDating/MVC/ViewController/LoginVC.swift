//
//  LoginVC.swift
//  FlowDating
//
//  Created by deepti on 25/01/21.
//

import UIKit
import SwiftyJSON
class LoginVC: UIViewController {

    @IBOutlet weak var txt_Mobile: UITextField!
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
        if  (txt_Mobile.text?.count)! > 7 {
            otpLogin()
        }
        else {
            Common.showAlert(alertMessage: Messages.Valid_NUMBER.rawValue, alertButtons: ["Ok"]) { (bt) in
            }
        }
        
    }
    func otpLogin(){
        var params =  [String : Any]()
       
        params["mobile"] = "91-\(self.txt_Mobile.text ?? "")"
     
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForOTPSend(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let getData = parseData["data"]
                let otp = getData["otp"].stringValue
                self.openViewController(controller: OtpScreen.self, storyBoard: .mainStoryBoard) { (vc) in

                    vc.isComingFromLogin = true
                    vc.mobile = self.txt_Mobile.text ?? ""
                    vc.otp = otp
                }
                }
             else {
                
                guard let dicErr = errorDict?["msg"] as? String else {
                    return
                }
                Common.showAlert(alertMessage: (dicErr), alertButtons: ["Ok"]) { (bt) in
                }
                
                
            }
        })
    }
}
