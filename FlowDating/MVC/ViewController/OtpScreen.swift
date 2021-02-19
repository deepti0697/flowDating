//
//  OtpScreen.swift
//  Union
//
//  Created by Ravi on 22/05/20.
//  Copyright © 2020 Union. All rights reserved.
//

import UIKit

import SwiftyJSON
import CoreLocation
class OtpScreen: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var lbl_mbl: UILabel!
    @IBOutlet weak var lbl_expireTime: UILabel!
    @IBOutlet weak var btn_save: UIButton!
    @IBOutlet weak var txt_four: UITextField!
    @IBOutlet weak var txt_three: UITextField!
    @IBOutlet weak var txt_two: UITextField!
    @IBOutlet weak var txt_one: UITextField!
    @IBOutlet weak var lbl: UILabel!
    
    var latitude = 0.0
    var longitude = 0.0
    let locationManager = CLLocationManager()
    var email:String?
    var otp:String?
    var dict : [String:Any] = [:]
    var mobile: String = ""
    var countryCode: String = "91"
    var isfromLogin : Bool = false
    var socialData : [String:Any] = [:]
    var timer: Timer?
    var totalTime = 120
    var isComingFromLogin = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_one.delegate = self
        txt_two.delegate = self
        txt_three.delegate = self
        txt_four.delegate = self
        
        lbl.text = "Please enter 4 digit OTP send to"
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        self.navigationItem.titleView = self.tabbarTitleView(title:"OTP",color:.white)
        // self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.lbl_mbl.text =  "+\(countryCode)  \(self.mobile)"
        self.startOtpTimer()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        //self.btn_mobileNo.cornerRadius =  20.0
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        timer?.invalidate()
        self.navigationController?.popViewController(animated: true)
    }
    // MARK : Timer
    private func startOtpTimer() {
            self.totalTime = 120
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }

    @objc func updateTimer() {
            print(self.totalTime)
            self.lbl_expireTime.text = self.timeFormatted(self.totalTime) // will show timer
            if totalTime != 0 {
                totalTime -= 1  // decrease counter timer
            } else {
                if let timer = self.timer {
                    timer.invalidate()
                    self.timer = nil
//                    btn_save.isEnabled = false
                    
                }
            }
        }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "Expired in %02d:%02d", minutes, seconds)
    }
    
    @IBAction func actionBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(((textField.text!.count) < 1 ) && (string.count > 0)){
            if(textField  == txt_one){
                txt_two.becomeFirstResponder()
            }
            else if (textField == txt_two){
                txt_three.becomeFirstResponder()
            }
            else if (textField == txt_three){
                txt_four.becomeFirstResponder()
            }
            else if (textField == txt_four){
                txt_four.becomeFirstResponder()
            }
            textField.text = string
            return false
        }
            
        else if(((textField.text!.count) > 0 ) && (string.count > 0)){
            if(textField  == txt_one){
                txt_two.becomeFirstResponder()
            }
            else if (textField == txt_two){
                txt_three.becomeFirstResponder()
            }
            else if (textField == txt_three){
                txt_four.becomeFirstResponder()
            }
            else if (textField == txt_four){
                txt_four.becomeFirstResponder()
            }
            textField.text = string
            return false
        }
            
            
        else if (((textField.text!.count) >= 1) && (string.count == 0)){
            if(textField == txt_two){
                txt_one.becomeFirstResponder()
            }
            else if(textField == txt_three){
                txt_two.becomeFirstResponder()
            }
            else if(textField == txt_four){
                txt_three.becomeFirstResponder()
            }
            else if(textField == txt_one){
                txt_one.becomeFirstResponder()
            }
            textField.text = ""
            return false
        }
        return true
    }
    
    @IBAction func actionResnd(_ sender: Any) {
//        callAPIforOTP()
        if isComingFromLogin {
            self.ResendotpLogin()
        }
        else{
            self.ResendotpSignup()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    @IBAction func action_save(_ sender: Any) {
        if ((timer?.isValid) != nil) {
        timer?.invalidate()
//        let strOtp = "\(txt_one.text ?? "")\(txt_two.text ?? "")\(txt_three.text ?? "")\(txt_four.text ?? "")"
        var params = [String:Any]()
        params["mobile"] = "91-\(self.mobile)"
        params["device_type"] = OS
        params["device_token"] = AppHelper.getStringForKey(ServiceKeys.device_token)
        params["app_version"] = build_Version
        params["os_version"] = ios_version
        params["latitude"] = self.latitude
        params["longitude"] = self.longitude
        if isComingFromLogin {
            params["password"] = otp
            
            otpLogin(pamaters: params)
        }
        else {
            params["email"] =  self.email
      
            params["social_type"] = "phone"
            params["social_id"] =  ""
        
        params["otp"] =  otp
     
        otpSignup(pamaters: params)
        
    }
        }
        else {
            AppManager.init().showAlertSingle(kAppName, message:  "Your OTP is Expire now, Please Resend Otp again.", buttonTitle: "Ok") {

                        }
        }
    }
 
    
    func otpSignup(pamaters:[String:Any]){
     
       
       
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForSignupLogin(pamaters, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let getData = parseData["data"]
               
                let user = User(fromJson:getData)
                print(user)
                self.timer?.invalidate()
                AppHelper.setStringForKey(user.api_token, key: ServiceKeys.token)
               AppHelper.setStringForKey(user.email, key: ServiceKeys.email)
               
                AppHelper.setStringForKey(user.id, key: ServiceKeys.user_id)
             
                self.openViewController(controller: CompleteProfile1VC.self, storyBoard: .mainStoryBoard) { (vc) in

                    
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
    func otpLogin(pamaters:[String:Any]){
     
       
       
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForLogin(pamaters, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let getData = parseData["data"]
               
                let user = User(fromJson:getData)
                print(user)
                self.timer?.invalidate()
                AppHelper.setStringForKey(user.api_token, key: ServiceKeys.token)
               AppHelper.setStringForKey(user.email, key: ServiceKeys.email)
               
                AppHelper.setStringForKey(user.id, key: ServiceKeys.user_id)
//                self.openViewController(controller: CompleteProfile1VC.self, storyBoard: .mainStoryBoard) { (vc) in
                    appdelegate.setHomeView()
                    
//                }
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
    func ResendotpLogin(){
        var params =  [String : Any]()
       
        params["mobile"] = "91-\(self.mobile)"
     
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForOTPSend(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let getData = parseData["data"]
                let otp = getData["otp"].stringValue
              
                self.otp = otp
                self.startOtpTimer()
                Common.showAlert(alertMessage: parseData["message"].stringValue, alertButtons: ["Ok"]) { (bt) in
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
    func ResendotpSignup(){
        var params =  [String : Any]()
       
        params["email"]  = self.email
        params["mobile"] = "91-\(self.mobile)"
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForSignupOTPSend(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let getData = parseData["data"]
                let otp = getData["otp"].stringValue
            
                        self.otp = otp
                self.startOtpTimer()
                Common.showAlert(alertMessage:parseData["message"].stringValue, alertButtons: ["Ok"]) { (bt) in
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

extension OtpScreen:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
    }
}
