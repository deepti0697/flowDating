//
//  LoginVC.swift
//  FlowDating
//
//  Created by deepti on 25/01/21.
//

import UIKit
import SwiftyJSON
import  GoogleSignIn
import CoreLocation
class LoginVC: UIViewController {

    @IBOutlet weak var appleLoginImageView: UIImageView!
    @IBOutlet weak var appleIDButton: UIButton!
    @IBOutlet weak var txt_Mobile: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var latitude = 0.0
    var longitude = 0.0
    let locationManager = CLLocationManager()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        Location()
        setupLoginWithAppleButton()
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                           return
                       }

                       if UIApplication.shared.canOpenURL(settingsUrl) {
                           UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                               print("Settings opened: \(success)") // Prints true
                           })
                       }
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
    private func setupLoginWithAppleButton() {
            if #available(iOS 13.0, *) {
                self.appleLoginImageView.isHidden = false
                //Show sign-in with apple button. Create button here via code if you need.
            } else {
                // Fallback on earlier versions
                //Hide your sign in with apple button here.
                self.appleLoginImageView.isHidden = true
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
    
    @available(iOS 13.0, *)
    @IBAction func appleLoginAction(_ sender: Any) {
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
    }
    @IBAction func opensignupVC(_ sender: Any) {
        openViewController(controller: SignupVC.self, storyBoard: .mainStoryBoard) { (vc) in

        }
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        handleGoogleAuthentication()
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
extension LoginVC: GIDSignInDelegate {
    
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
            print(user)
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
}

extension LoginVC:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
    }
}
