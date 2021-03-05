//
//  Model.swift
//  FlowDating
//
//  Created by deepti on 11/02/21.
//

import Foundation
import SwiftyJSON


class GetUserProfile{
  
          
        
    var device_type: String!
    var app_version:String!
    var os_version:String!
    var latitude:String!
    var longitude:String!
    var last_activity:String!
  
    var is_pause:Bool!
    var profile_complete:String!
    var age:String!
    var id : String!
    var firebase_id:String!
    var name : String!
    var email : String!
    var mobile: String!
    var gender :  String!
    var zodiac_sign: String!
    var compatibility: String!
    var profile_pic : String!
    var dob : String!
    var about :  String!
    var subscription_plan:Bool!
    var miles: String!
    var status : Bool!
    var is_verified: Bool!
    var photos = [AllPhotos]()
    var prefrence :UserPrefence?
    init() { }
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        
        is_pause = json["is_pause"].boolValue
        device_type = json["device_type"].stringValue
        app_version = json["app_version"].stringValue
        os_version  = json["os_version"].stringValue
        latitude   = json["os_version"].stringValue
        longitude  = json["longitude"].stringValue
        last_activity = json["last_activity"].stringValue
        let arrayPhotos = json["photos"].arrayValue
        id = json["id"].stringValue
        firebase_id = json["firebase_id"].stringValue
        name = json["name"].stringValue
        email = json["email"].stringValue
        mobile = json["mobile"].stringValue
        gender = json["gender"].stringValue
        age = json["age"].stringValue
        zodiac_sign = json["zodiac_sign"].stringValue
        compatibility = json["compatibility"].stringValue
        profile_pic = json["profile_pic"].stringValue
        dob = json["dob"].stringValue
        about = json["about"].stringValue
        subscription_plan = json["subscription_plan"].boolValue
        miles = json["miles"].stringValue
        status = json["status"].boolValue
        is_verified = json["is_verified"].boolValue
        
        
        
        for value in arrayPhotos {
            let sortByData = AllPhotos(fromJson: value)
            self.photos.append(sortByData)
        }
    }
}

class UserPrefence {
    var id:String!
    var user_id:String!
    var interested_in:String!
    var min_age:String!
    var max_age:String!
    var distance_type:String!
    var distance:String!
    var created_at:String!
    var updated_at:String!
    var deleted_at:String!
    init() { }
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].stringValue
        user_id = json["user_id"].stringValue
        interested_in = json["interested_in"].stringValue
        min_age = json["min_age"].stringValue
        max_age = json["max_age"].stringValue
        distance_type = json["distance_type"].stringValue
        
        distance = json["distance"].stringValue
        created_at = json["created_at"].stringValue
        updated_at = json["updated_at"].stringValue
        deleted_at = json["deleted_at"].stringValue
}
}
class AllUserData{
    var id:String!
    var firebase_id:String!
    var name:String!
    var email:String!
    var mobile : String!
    var gender:String!
    var age: String!
    var zodiac_sign:String!
    var compatibility:String!
    var profile_pic:String!
    var dob:String!
    var about:String!
    var subscription_plan:Bool!
    var miles:String!
    var status: Bool!
    var is_verified:Bool!
    var photo_url:String!
    var photos = [AllPhotos]()
    init() { }
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let arrayPhotos = json["photos"].arrayValue
        id = json["id"].stringValue
        firebase_id = json["firebase_id"].stringValue
        name   = json["name"].stringValue
        email = json["name"].stringValue
        mobile = json["mobile"].stringValue
        gender  = json["gender"].stringValue
        age     = json["age"].stringValue
        zodiac_sign  = json["zodiac_sign"].stringValue
        compatibility   = json["compatibility"].stringValue
        profile_pic  = json["profile_pic"].stringValue
        dob = json["dob"].stringValue
        about = json["about"].stringValue
        subscription_plan = json["subscription_plan"].boolValue
        miles = json["miles"].stringValue
        status = json["status"].boolValue
        is_verified = json["is_verified"].boolValue
        photo_url = json["photo_url"].stringValue
        for value in arrayPhotos {
            let sortByData = AllPhotos(fromJson: value)
            self.photos.append(sortByData)
        }
    }
}
class AllPhotos {
    

var user_id:String!
var type: String!
var name:String!
init() { }

init(fromJson json: JSON!){
    if json.isEmpty{
        return
    }
    user_id = json["user_id"].stringValue
    type = json["type"].stringValue
    name = json["name"].stringValue
}
}

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
    var profile_complete:String!
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
        profile_complete    = json["profile_complete"].stringValue
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
