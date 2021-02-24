//
//  ServiceClass.swift
//  TradeInYourLease
//
//  Created by Ajay Vyas on 10/2/17.
//  Copyright © 2017 Ajay Vyas. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class ServiceClass: NSObject {

    static let sharedInstance = ServiceClass()
 
    enum ResponseType : Int {
        case   kResponseTypeFail = 0
        case  kresponseTypeSuccess
    }
    
    typealias completionBlockType = (ResponseType, JSON, AnyObject?) ->Void
    
    
    func hudShow()  {
           SVProgressHUD.setDefaultMaskType(.clear)
           SVProgressHUD.show()
       }
       func hudHide()  {
           SVProgressHUD.dismiss()
       }
    
    
  //MARK:- Common Get Webservice calling Method using SwiftyJSON and Alamofire
        func hitServiceWithUrlString( urlString:String, parameters:[String:AnyObject],headers:HTTPHeaders,completion:@escaping completionBlockType)
        {
            if Reachability.forInternetConnection()!.isReachable()
            {
                print(headers)
                print(urlString)
                print(parameters)
                hudShow()
                AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers : headers)
                    .responseJSON { response in
                        self.hudHide()
                        guard case .success(let rawJSON) = response.result else {
                            print("SomeThing wrong")
                            
                            var errorDict:[String:Any] = [String:Any]()
                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                            errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong"
                            completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                            return
                        }
                        if rawJSON is [String: Any] {
                            let json = JSON(rawJSON)
                            print(json)
                            
                            if  json["status"].intValue == 200 {
                                completion(ResponseType.kresponseTypeSuccess,json,nil)
                            }
                            else {
                                var errorDict:[String:Any] = [String:Any]()
                                errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                errorDict[ServiceKeys.keyErrorMessage] = json["message"].stringValue
                                errorDict[ServiceKeys.keyErrorDic] = json["errors"].dictionary
                                
                                print(json["error_code"].stringValue)
                                
                                if json["error_code"].stringValue == "delete_user"{
                                    SVProgressHUD.dismiss()
                                }
                                else {
                                    completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                                }
                            }
                        }
                }
            }
            else {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let errorDict = NSMutableDictionary()
                    errorDict.setObject(ErrorCodes.errorCodeInternetProblem, forKey: ServiceKeys.keyErrorCode as NSCopying)
                    errorDict.setObject("Check your internet connectivity", forKey: ServiceKeys.keyErrorMessage as NSCopying)
                    completion(ResponseType.kResponseTypeFail,JSON(),errorDict as NSDictionary)
                }
                
            }
            
        }
        
        
        func hitServiceWithUrlStringWithErrorList( urlString:String, parameters:[String:AnyObject],headers:HTTPHeaders,completion:@escaping completionBlockType)
          {
              if Reachability.forInternetConnection()!.isReachable()
              {
                  print(headers)
                  print(urlString)
                  print(parameters)
                   hudShow()
                  AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers : headers)
                      .responseJSON { response in
                        self.hudHide()
                          guard case .success(let rawJSON) = response.result else {
                              print("SomeThing wrong")
                              
                              var errorDict:[String:Any] = [String:Any]()
                              errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                              errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong"
                              completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                              return
                          }
                          if rawJSON is [String: Any] {
                              let json = JSON(rawJSON)
                              print(json)
                              if  json["status"] == true {
                                  completion(ResponseType.kresponseTypeSuccess,json,nil)
                              }
                              else {
                                  var errorDict:[String:Any] = [String:Any]()
                                  errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                  errorDict[ServiceKeys.keyErrorMessage] = json["message"].string
                                    errorDict[ServiceKeys.keyErrorDic] = json["errors"].dictionary
                                
                                  print(json["error_code"].dictionary)
                                   completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                                  
                                  
                                  
                              }
                          }
                  }
              }
              else {
                  
                  DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                      let errorDict = NSMutableDictionary()
                      errorDict.setObject(ErrorCodes.errorCodeInternetProblem, forKey: ServiceKeys.keyErrorCode as NSCopying)
                      errorDict.setObject("Check your internet connectivity", forKey: ServiceKeys.keyErrorMessage as NSCopying)
                      completion(ResponseType.kResponseTypeFail,JSON(),errorDict as NSDictionary)
                  }
                  
              }
              
          }
        
        func hitGetServiceWithUrlString( urlString:String, parameters:[String:Any],headers:HTTPHeaders,completion:@escaping completionBlockType)
        {
            if Reachability.forInternetConnection()!.isReachable()
            {
                            hudShow()
                let updatedUrl = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                let url = URL(string: updatedUrl!)!
                print("URL \(url)")
                print("PARAMETERS: \(parameters)")
                
            
                
                AF.request(url, method: .get , encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON { response in
                    
                    self.hudHide()
                    guard case .success(let rawJSON) = response.result else {
                        print("SomeThing wrong")
                        
                        print(response.result)
                        
                        var errorDict:[String:Any] = [String:Any]()
                        errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                        errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong"
                        
                        completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                        return
                    }
                    if rawJSON is [String: Any] {
                        
                        let json = JSON(rawJSON)
                        print(json)
                        if json["status"].intValue == 200 {
                            completion(ResponseType.kresponseTypeSuccess,json,nil)
                        }
                        else {
                            var errorDict:[String:Any] = [String:Any]()
                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                            errorDict[ServiceKeys.keyErrorMessage] = json["message"].stringValue
                            print(json["error_code"].stringValue)
                            
                            
                            if json["error_code"].stringValue == "delete_user"{
                                SVProgressHUD.dismiss()
                                
                            }
                            else {
                                completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                            }
                            
                            
                        }
                    }
             
                }
            }
                
            else  {
     
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let errorDict = NSMutableDictionary()
                    errorDict.setObject(ErrorCodes.errorCodeInternetProblem, forKey: ServiceKeys.keyErrorCode as NSCopying)
                    errorDict.setObject("Check your internet connectivity", forKey: ServiceKeys.keyErrorMessage as NSCopying)
                    completion(ResponseType.kResponseTypeFail,JSON(),errorDict as NSDictionary)
                }
            }
        }
        
        func hitGetServiceWithUrlParams( urlString:String, parameters:[String:Any],headers:HTTPHeaders,completion:@escaping completionBlockType)
           {
            
               if Reachability.forInternetConnection()!.isReachable()
               {
                   hudShow()
                   let updatedUrl = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                   let url = URL(string: updatedUrl!)!
                   print("URL \(url)")
                   print("PARAMETERS: \(parameters)")
                   
               
                   
                   AF.request(url, method: .get,parameters: parameters  , encoding: URLEncoding.default, headers: headers).responseJSON { response in
                       
                    self.hudHide()
                       guard case .success(let rawJSON) = response.result else {
                           print("SomeThing wrong")
                           
                           print(response.result)
                           
                           var errorDict:[String:Any] = [String:Any]()
                           errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                           errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong"
                           
                           completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                           return
                       }
                       if rawJSON is [String: Any] {
                           
                           let json = JSON(rawJSON)
                           print(json)
                           if  json["status"] == true {
                               completion(ResponseType.kresponseTypeSuccess,json,nil)
                           }
                           else {
                               var errorDict:[String:Any] = [String:Any]()
                               errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                               errorDict[ServiceKeys.keyErrorMessage] = json["message"].stringValue
                               print(json["error_code"].stringValue)
                               
                               
                               if json["error_code"].stringValue == "delete_user"{
                                   SVProgressHUD.dismiss()
                                   
                               }
                               else {
                                   completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                               }
                               
                               
                           }
                       }
                
                   }
               }
                   
               else  {
        
                   DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                       let errorDict = NSMutableDictionary()
                       errorDict.setObject(ErrorCodes.errorCodeInternetProblem, forKey: ServiceKeys.keyErrorCode as NSCopying)
                       errorDict.setObject("Check your internet connectivity", forKey: ServiceKeys.keyErrorMessage as NSCopying)
                       completion(ResponseType.kResponseTypeFail,JSON(),errorDict as NSDictionary)
                   }
               }
           }
        
    func imageUpload(_ urlString:String, params:[String : Any],data : Data?,doc:Data?,imageKey:String,fileName: String?,
        pathExtension: String?, headers:HTTPHeaders, completion:@escaping completionBlockType){
            
            print(urlString)
    //        print(params)
    //        AF.upload(multipartFormData:{ multipartFormData in
    ////            if let data1 = data {
    //            multipartFormData.append(data ?? Data() , withName: imageKey, fileName: "file.jpg", mimeType: "image/jpg")
    ////            }
                hudShow()
                                
                    AF.upload(multipartFormData: { multipartFormData in
    //                           if let data1 = data {
    //                            multipartFormData.append(data1 , withName:  imageKey, fileName: "attachment", mimeType: "image/jpg")
    //
                        if let data = doc {
                            multipartFormData.append(data, withName: "verificationId", fileName: "pdfDocuments.\(pathExtension!)", mimeType: "pdfDocuments.\(pathExtension!)")
                        }
                    
                        if let data = data {
                            multipartFormData.append(data, withName: "image", fileName: "\(fileName!).\(pathExtension!)", mimeType: "\(fileName!)/\(pathExtension!)")
                        }
                                   
    //                    multipartFormData.append(data ?? Data() , withName:  "identified", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
                                    
                                    for (key, value) in params {
                                   
                                            let str = "\(value)"
                                            multipartFormData.append(((str as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                                    }
                       }, to: urlString, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
                           print("Upload Progress: \(progress.fractionCompleted)")
                       }).responseJSON(completionHandler: { data in
                           print("upload finished: \(data)")
                       }).response { (response) in
                        self.hudHide()
                        switch response.result {
                        case .success(let _):
                            
                                guard case .success(let rawJSON) = response.result else {
                                    var errorDict:[String:Any] = [String:Any]()
                                    errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                    errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong" + urlString
                                    
                                    completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                                    
                                    return
                                }
                            
                                print(rawJSON ?? "")
                
                                if let rawJSN = rawJSON {
                                    let json = try? JSON(data: rawJSN)
                                   
                                    if  json?["success"] == false{
                                        
                                        let errorData = json?["errors"]
                                        for obj in json!["errors"].arrayValue {
                                            var errorDict:[String:Any] = [String:Any]()
                                            
                                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                            errorDict[ServiceKeys.keyErrorMessage] = obj["msg"].stringValue
                                            
                                            completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                                            return
                                        }
//                                        print(errorData?["msg"].stringValue)
                                       
                                    }
                                    
                                    else {
                                        completion(ResponseType.kresponseTypeSuccess,json ?? JSON(),nil)
                                    }
                                
                            }
                        case .failure(let encodingError):
                            print(encodingError)
                        }
                    }

        }
        
        
        //multiple images upload
        func multipleImageUpload(_ urlString:String, params:[String : Any],data: [Data],headers:HTTPHeaders, completion:@escaping completionBlockType){
             
             print(urlString)
             print(params)
             print(data)
            
            hudShow()
            AF.upload(multipartFormData: { multipartFormData in
                      for imgData in data {
                                          multipartFormData.append(imgData , withName:  "images[]", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
                                      }
                           
                           
                            for (key, value) in params {
                           
                                    let str = "\(value)"
                                    multipartFormData.append(((str as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                            }
               }, to: urlString, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
                   print("Upload Progress: \(progress.fractionCompleted)")
               }).responseJSON(completionHandler: { data in
                   print("upload finished: \(data)")
               }).response { (response) in
                self.hudHide()
                switch response.result {
                case .success(let _):
                    
                        guard case .success(let rawJSON) = response.result else {
                            var errorDict:[String:Any] = [String:Any]()
                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                            errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong" + urlString
                            
                            completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                            
                            return
                        }
                        print(rawJSON ?? "")
        
                        if let rawJSN = rawJSON {
                            let json = try? JSON(data: rawJSN)
                            
                            if  json?["status"] == "error"{
                                var errorDict:[String:Any] = [String:Any]()
                                
                                errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                errorDict[ServiceKeys.keyErrorMessage] = json?["message"].stringValue
                                
                                completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                            }
                            else {
                                completion(ResponseType.kresponseTypeSuccess,json ?? JSON(),nil)
                            }
                        
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }

             
         }
     
       //MARK:- EmailLogin
     
  
    
    //MARK:- Survey
    func hitServiceMultipleImage(_ params:[String : Any],data: [Data], completion:@escaping completionBlockType)
    {
        let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.upload_Photos)"
        let headers: HTTPHeaders = ["Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token)]
            self.multipleImageUpload(urlString, params: params, data: data, headers: headers, completion: completion)
    }
    func hitServiceForOTPSend(_ params:[String : Any], completion:@escaping completionBlockType)
        {
            let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.send_OTP)"
           
        let headers: HTTPHeaders = [:]
            self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
        }
    //MARK:- OTP Send
    func hitServiceForCompleteSurvey(_ params:[String : Any], completion:@escaping completionBlockType)
        {
            let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.hitSurvey)"
           
        let headers: HTTPHeaders = [ "os" : OS,"version":ios_version, "Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token)]
            self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
        }
    func hitServiceForCompleteProfile(_ params:[String : Any], completion:@escaping completionBlockType)
        {
            let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.complete_profile)"
           
        let headers: HTTPHeaders = [ "os" : OS,"version":ios_version, "Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token)]
            self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
        }
    func hitServicesForPRefrenceUSer(_ params:[String : Any], completion:@escaping completionBlockType)
        {
            let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.prefrence_User)"
           
        let headers: HTTPHeaders = [ "os" : OS,"version":ios_version, "Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token)]
            self.hitGetServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
        }
    func hitServiceForCompleteProfile2(_ params:[String : Any], completion:@escaping completionBlockType)
        {
            let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.complete_profile_prefrence)"
           
        let headers: HTTPHeaders = [ "os" : OS,"version":ios_version, "Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token)]
            self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
        }
    func hitServiceForSignupOTPSend(_ params:[String : Any], completion:@escaping completionBlockType)
        {
            let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.sign_up_Otp)"
           
        let headers: HTTPHeaders = [:]
            self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
        }
    func hitServiceForSignupLogin(_ params:[String : Any], completion:@escaping completionBlockType)
        {
            let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.sign_up_Email)"
           
        let headers: HTTPHeaders = [:]
            self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
        }
    
    func hitServiceForServerLogin(_ params:[String : Any], completion:@escaping completionBlockType)
        {
            let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.signup_Social)"
           
        let headers: HTTPHeaders = [:]
            self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
        }
    func hitServiceForLogin(_ params:[String : Any], completion:@escaping completionBlockType)
        {
            let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.login)"
           
        let headers: HTTPHeaders = [:]
            self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
        }
    
 
    
    // For SignUp
    
    func hitServiceForlogin(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.login)"
        let headers: HTTPHeaders = [:]
       
        self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    

    

}

