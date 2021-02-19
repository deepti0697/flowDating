//
//  Model.swift
//  FlowDating
//
//  Created by deepti on 11/02/21.
//

import Foundation
import SwiftyJSON

//class AllUserData{
//    var id:String!
//    var firebase_id:String!
//    var name:String!
//    var email:String!
//    var mobile: :String!
//    var gender:
//                "age": 32,
//                "zodiac_sign": "Aquarius",
//                "compatibility": "74%",
//                "profile_pic": "http://192.168.1.115/flow_dating_app/public/uploads/users/161304269071.jpeg",
//                "dob": "1989-02-01",
//                "about": "",
//                "subscription_plan": false,
//                "miles": 0,
//                "status": true,
//                "photo_url": "http://192.168.1.115/flow_dating_app/public/uploads/users/2",
//                "photos": [
//                    {
//                        "id": 1,
//                        "user_id": 2,
//                        "type": 0,
//                        "name": "161363803567.jpg",
//                        "created_at": "2021-02-18T08:47:15.000000Z",
//                        "updated_at": "2021-02-18T08:47:15.000000Z",
//                        "deleted_at": null
//}
class CompleteProfile {
    
    var id   : String!
    var firebase_id:String!
    var profile_pic:String!
    var dob:String!
    var subscription_plan:Bool!
    var name:String!
    var gender:String!
    var mobile:String!
    var age:String!
    var email:String!
    var about:String!
    var zodiac_sign: String!
    var compatibility:String!
    var miles:String!
    var status:Bool!
    var is_verified:Bool!
    init() { }
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
       
        age                 = json["age"].stringValue
        about               = json["about"].stringValue
        status              = json["status"].boolValue
        is_verified         = json["is_verified"].boolValue
        
        firebase_id         = json["firebase_id"].stringValue
      
        profile_pic         = json["profile_pic"].stringValue
        dob                 = json["dob"].stringValue
      
        subscription_plan   = json["subscription_plan"].boolValue
        email               = json["email"].stringValue
       
        mobile              = json["mobile"].stringValue
       
        name                = json["name"].stringValue
     
        
        gender              = json["gender"].stringValue
        
        
        id                  = json["id"].stringValue
      
    }
}
class User{
    
    var firebase_id:String!
    var api_token:String!
    var profile_pic:String!
    var dob:String!
    var subscription_plan:Bool!
    var name:String!
    var gender:String!
 
    var id   : String!
    var email:String!
    var status:String!
    var latitude:String!
    var deleted_at:String!
    var created_at:String!
    var last_activity:String!
    var app_version:String!
    var about:String!
//    var device_type:String
    var age:String!
    var is_email_verified:Bool!
    var is_verified:Bool!
    var social_type:String!
    var mobile:String!
    var updated_at:String!
   
    var social_id:String!
    var os_version:String!
    var longitude:String!
    
    init() { }
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        updated_at          = json["updated_at"].stringValue
        latitude            = json["latitude"].stringValue
//        device_type         = json["device_type"].stringValue
        longitude           = json["longitude"].stringValue
        os_version          = json["os_version"].stringValue
        social_id           = json["social_id"].stringValue
        social_type        = json["social_type"].stringValue
        is_verified        = json["is_verified"].boolValue
        is_email_verified  = json["is_email_verified"].boolValue
        age                 = json["age"].stringValue
       
        about               = json["about"].stringValue
        app_version         = json["app_version"].stringValue
        last_activity        = json["last_activity"].stringValue
        created_at          =  json["created_at"].stringValue
        deleted_at          = json["deleted_at"].stringValue
        
        firebase_id         = json["firebase_id"].stringValue
        api_token           = json["api_token"].stringValue
        profile_pic         = json["profile_pic"].stringValue
        dob                 = json["dob"].stringValue
      
        subscription_plan   = json["subscription_plan"].boolValue
        email               = json["email"].stringValue
        status              = json["status"].stringValue
        mobile              = json["mobile"].stringValue
       
        name                = json["name"].stringValue
     
        
        gender              = json["gender"].stringValue
        
        
        id                  = json["id"].stringValue
      
    }
}