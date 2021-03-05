//
//  SignupVC.swift
//  FlowDating
//
//  Created by deepti on 25/01/21.
//

import UIKit
import SwiftyJSON
import CoreLocation
import  GoogleSignIn
class SignupVC: UIViewController {

    @IBOutlet weak var appleImageView: UIImageView!
    @IBOutlet weak var txt_mobile: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var latitude = 0.0
    var longitude = 0.0
    let locationManager = CLLocationManager()
    @IBAction func openloginVC(_ sender: Any) {
        openViewController(controller: LoginVC.self, storyBoard: .mainStoryBoard) { (vc) in

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Location()
        setupLoginWithAppleButton()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func Location(){
        let locStatus = CLLocationManager.authorizationStatus()
          switch locStatus {
             case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
//            location()
             return
             case .denied, .restricted:
                let alert = UIAlertController(title: "Location Services are disabled", message: "Please enable Location Services in your Settings", preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                               return
                           }

                           if UIApplication.shared.canOpenURL(settingsUrl) {
                               UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                   print("Settings opened: \(success)") // Prints true
                               })
                           }
                })))
                present(alert, animated: true, completion: nil)
               
//                location()
             return
             case .authorizedAlways, .authorizedWhenInUse:
//                location()
             break
          @unknown default:
            locationManager.requestWhenInUseAuthorization()
        
          break
            
          }
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupAction(_ sender: Any) {
        if Validate.shared.validateLogin(vc: self) {
            if ( txt_mobile.text?.count)! >= 7  {
                self.otpLogin()
            }
            else {
                
                Common.showAlert(alertMessage: "Please enter atleast 7 digits Number", alertButtons: ["Ok"]) { (bt) in
                }
               
            }
          
        }
    }
    @IBAction func faceBookloginAction(_ sender: Any) {
        SocialLoginHelper.shared.handleLogInWithFacebookButtonPress()
                SocialLoginHelper.shared.completionHandler = { (token, userinfo) in
                    print(userinfo)
                    let params = [ "social_type":"facebook",
                                  "social_id":userinfo["id"],
                                  "device_type":"iOS",
                                  "device_token" : AppHelper.getStringForKey(ServiceKeys.device_token),
                                  "app_version":build_Version,
                                  "os_version": ios_version,
                                  "latitude" : self.latitude,
                                  "longitude" : self.longitude]
//                    [String:Any]
                    self.socialLogin(param: params as [String : Any])
//                    self.socialLoginFromServer(userInfo: userinfo)
                }
    }
    private func setupLoginWithAppleButton() {
            if #available(iOS 13.0, *) {
                self.appleImageView.isHidden = false
                //Show sign-in with apple button. Create button here via code if you need.
            } else {
                self.appleImageView.isHidden = true
                // Fallback on earlier versions
                //Hide your sign in with apple button here.
            }
        }
    @IBAction func googleLogin(_ sender: Any) {
        handleGoogleAuthentication()
    }
    @IBAction func appleLoginAction(_ sender: Any) {
        if #available(iOS 13.0, *) {
            SocialLoginHelper.shared.handleLogInWithAppleIDButtonPress()
            SocialLoginHelper.shared.completionHandler = { (token, userinfo) in
                print(userinfo)
                let params = [ "social_type":"apple",
                              "social_id":userinfo["id"],
                              "device_type":"iOS",
                              "device_token" : AppHelper.getStringForKey(ServiceKeys.device_token),
                              "app_version":build_Version,
                              "os_version": ios_version,
                              "latitude" : self.latitude,
                              "longitude" : self.longitude]
//                    [String:Any]
                self.socialLogin(param: params as [String : Any])
            }
        } else {
            // Fallback on earlier versions
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
extension SignupVC {
//    social Login
    func socialLogin(param:[String:Any]){
   
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForServerLogin(param, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let getData = parseData["data"]
               
                let user = User(fromJson:getData)
                print(user)
                
                AppHelper.setStringForKey(user.api_token, key: ServiceKeys.token)
               AppHelper.setStringForKey(user.email, key: ServiceKeys.email)
                AppHelper.setStringForKey(user.profile_complete, key: ServiceKeys.profile_Screen)
          
                AppHelper.setStringForKey(user.id, key: ServiceKeys.user_id)
             
                if user.profile_complete == "0" {
                    appdelegate.setHomeVC()
                }
                if user.profile_complete == "1"{
                    self.openViewController(controller: CompleteProfile1VC.self, storyBoard: .mainStoryBoard) { (vc) in
                        vc.isComingFromRegistration = true
                        vc.backButtonOutlt.isHidden = true
                    }
                }
                else {
                self.openViewController(controller: CompleteProfile2VC.self, storyBoard: .mainStoryBoard) { (vc) in
                }
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

// Google Login
extension SignupVC : GIDSignInDelegate {
    
    /// Our custom functions
    private func handleGoogleAuthentication() {
        GIDSignIn.sharedInstance()?.clientID = "542877390026-35qkmgl7dav6oj65452hpm3urbvj7mc9.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            let fullName = user.profile.name
            let email = user.profile.email
            print(user ?? "")
            //  let image = user.profile.imageURL(withDimension: 100)
            let dict = ["email": email ?? "",
                        "name": fullName ?? "",
                        "social_type":"google",
                        "image":  "",
                        "device_type":"iOS",
                        "device_token" : AppHelper.getStringForKey(ServiceKeys.device_token),
                        "app_version":build_Version,
                        "os_version": ios_version,
                        "latitude" : self.latitude,
                        "longitude" : self.longitude,
                        "social_id" : user.userID ?? ""] as [String : Any]
         
//            self.socialLoginAction(parm: dict as NSDictionary)
            socialLogin(param: dict)
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    
}
extension SignupVC:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
    }
}
