//
//  Defines.swift
//  Panther
//
//  Created by Manish Jangid on 7/27/17.
//  Copyright © 2017 Manish Jangid. All rights reserved.
//

import Foundation
import UIKit




// MARK : GLOBAL Functions
func print_debug <T> (_ object:T)
{
    print(object)
}

let DateFormat_yyyy_mm_dd_hh_mm_ss_sss = "yyyy-MM-dd HH:mm:ss"

let DateFormat_yyyy_mm_dd_hh_mm_ss_0000 = "yyyy-MM-dd HH:mm:ss +0000"
let output_format_HH_mm_ss = "HH:mm:ss  MMM dd yyy"
let DateFormat_dd_mm_yyyy = "dd-MM-yyyy"
let DateFormat_dd_MM_yyyy = "yyyy-MM-dd"
let time_Format = "HH:mm"
let time_Format_S = "hh:mm:ss"
let appDelegate = UIApplication.shared.delegate as! AppDelegate



//MARK:- Service Keys

struct ServiceKeys{
    
    static let user_id = "user_id"
    static let vendor_id = "vendor_id"
    static let isFirstTime = "isFirstTime"
    static let full_name = "full_name"
    static let total_followers = "total_followers"
    static let total_following = "total_following"
    
    static let device_token = "device_token"
    static let token = "token"
    static let user_name = "user_name"
    static let email = "email"
    
    static let profile_image = "profile_image"
    static let phone_no = "phone_no"
    
    static let accout_type = "accout_type"
    static let dateFormat = "dateFormat"
    static let  timeFormat = "timeFormat"
    static let receiptNo  = "receiptNo"
    static let dob  = "dob"
    static let keyLatLong = "LatLon"
     static let keyAddressClient = "AddressClient"
   
      static let languageType = "languageType"
    
    static let keyContactNumber = "contact_number"
    static let keyProfileImage = "image_url"
   
    static let keyErrorCode = "errorCode"
    static let keyErrorMessage = "msg"
    static let keyUserType = "user_type"
    static let keyErrorDic = "errorDic"
    static let langId = "langId"
    
    
   
   
    
  
    static let keyStatus =  "status"
    static let KeyAccountName = "account_name"
    static let KeyPushNotificationDeviceToken = "KeyPushNotificationDeviceToken"
   

}

struct ServiceUrls
{
//    static let baseUrl = "http://34.238.160.251:3002/register_user"

    
    static let baseUrl = "http://192.168.1.115/flow_dating_app/public/api/"
    static let home = "explore"
    static let regiser_New_User = "/auth/register"
    static let check_Mobile_Registered = "/auth/email-mobile-exists"
//    static let login = "v1/login"
    static let login = "apiLogin"

 
    static let hitSurvey = "complete_questionnaire"
    static let send_OTP = "send_login_otp"
    static let sign_up_Otp = "send_otp"
  
    static let sign_up_Email = "mobileRegistration"
    static let complete_profile = "complete_profile"
    static let complete_profile_prefrence = "complete_profile_preference"
   


    

}
struct ErrorCodes
{
    static let    errorCodeInternetProblem = -1 //Unable to update use
    
    static let    errorCodeSuccess = 1 // 'Process successfully.'
    static let    errorCodeFailed = 2 // 'Process failed.
}


struct CustomColor{
    
   
    static let darkBlueColor = UIColor(red: 10.0/255.0, green: 211.0/255.0, blue: 225.0/255.0, alpha: 1.0)
      static let lightBlueColor = UIColor(red: 4/255.0, green: 167/255.0, blue: 191/255.0, alpha: 1.0)
    static let selectedtabColor = UIColor(red: 236/255.0, green: 36.0/255.0, blue: 143.0/255.0, alpha: 0.8)
     static let backgroundColor = UIColor(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1.0)
     //236,66,143
}


struct CustomFont {
    static let boldfont13 = UIFont(name: "GlacialIndifference-Bold", size: 13)!
    static let boldfont18 =  UIFont(name: "GlacialIndifference-Bold", size: 18)!
    static let boldfont14 =  UIFont(name: "GlacialIndifference-Bold", size: 14)!
    static let regularfont17 =  UIFont(name: "GlacialIndifference-Regular", size: 17)!
    static let regularfont16 =  UIFont(name: "GlacialIndifference-Regular", size: 16)!
    static let regularfont14 =  UIFont(name: "GlacialIndifference-Regular", size: 14)!
    static let regularfont18 =  UIFont(name: "GlacialIndifference-Regular", size: 18)!
    static let regularfont15 =  UIFont(name: "GlacialIndifference-Regular", size: 15)!
    static let boldfont15 =  UIFont(name: "GlacialIndifference-Bold", size: 15)!
}






