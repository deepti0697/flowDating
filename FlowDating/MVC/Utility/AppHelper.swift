//
//  AppHelper.swift
//  Panther
//
//  Created by Manish Jangid on 7/27/17.
//  Copyright © 2017 Manish Jangid. All rights reserved.
//

import Foundation
import  UIKit
import SwiftyJSON
var activityIndicator:UIActivityIndicatorView?

class AppHelper: NSObject, UIAlertViewDelegate{
    
    var loadingView: UIView!
    
    // save to user default
    class func setStringForKey (_ value: String? , key: String!) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key! as String)
        defaults.synchronize()
    }
    // get from user default
    class func getStringForKey ( _ key: String?) -> String {
        let defaults = UserDefaults.standard
        let value = defaults.string(forKey: key! as String)
        if (value != nil) {
            return value!
        }
        return ""
    }
    
    class func saveUser(_ data: Data) {
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
            UserDefaults.standard.set(archivedData, forKey: "user")
        } catch { print(error) }
        
        UserDefaults.standard.synchronize()
    }
    class  func saveJSON(json: JSON, key:String) {
       if let jsonString = json.rawString() {
          UserDefaults.standard.setValue(jsonString, forKey: key)
       }
    }

    class  func getJSON(_ key: String)-> JSON? {
        var p = ""
        if let result = UserDefaults.standard.string(forKey: key) {
            p = result
        }
        if p != "" {
            if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    return try JSON(data: json)
                } catch {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    // save to user default
    class func setBoolForKey (_ value: Bool? , key: String!) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key! as String)
        defaults.synchronize()
    }
    // get from user default
    class func getBoolForKey ( _ key: String?) -> Bool{
        let defaults = UserDefaults.standard
        let value = defaults.bool(forKey: key! as String)
        return value
    }
    
    // save to user default
    class func setValueForKey (_ value: AnyObject? , key: String!) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key! as String)
        defaults.synchronize()
    }
    // get from user default
    class func getValueForKey ( _ key: String?) -> AnyObject?{
        let defaults = UserDefaults.standard
        let value = defaults.string(forKey: key! as String)
        if (value != nil) {
            return value! as AnyObject
        }
        return nil
    }
    
    
    // remove from user default
    class  func removeFromUserDefaultForKey(_ key: String!) {
        let defaults = UserDefaults.standard
        let value = defaults.string(forKey: key! as String)
        if (value != nil) {
            defaults.removeObject(forKey: key! as String)
        }
        defaults.synchronize()
        
    }
    
    class func getFont(_ size : CGFloat) -> UIFont {
        return UIFont(name: "Varela Round", size: size)!
    }
   
    //MARK: AlertView
    
    
    //MARK:- Add Delay
    class func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
   
    
   
    
}
