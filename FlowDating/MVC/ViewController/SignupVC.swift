//
//  SignupVC.swift
//  FlowDating
//
//  Created by deepti on 25/01/21.
//

import UIKit
import SwiftyJSON
class SignupVC: UIViewController {

    @IBOutlet weak var txt_mobile: UITextField!
    @IBOutlet weak var txt_email: UITextField!
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
        if Validate.shared.validateLogin(vc: self) {
            self.otpLogin()
        }
    }
    func otpLogin(){
        var params =  [String : Any]()
       
        params["email"]  = self.txt_email.text ?? ""
        params["mobile"] = "91-\(self.txt_mobile.text ?? "")"
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForSignupOTPSend(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let getData = parseData["data"]
                let otp = getData["otp"].stringValue
                self.openViewController(controller: OtpScreen.self, storyBoard: .mainStoryBoard) { (vc) in

                    vc.isComingFromLogin = false
                    vc.email = self.txt_email.text ?? ""
                    vc.otp = otp
                    vc.mobile = self.txt_mobile.text ?? ""
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
