//
//  HomeVC.swift
//  Union
//
//  Created by Ravi on 25/05/20.
//  Copyright © 2020 Union. All rights reserved.
//


var  MAX_BUFFER_SIZE = 3;
let  SEPERATOR_DISTANCE = 8;
let  TOPYAXIS = 75;

import UIKit
import SwiftyJSON
class HomeVC: ViewController {
    
    var iscomingFromCompleteProfile4 = true
        
    
    var surveyPop:SurveypopUPView?
    @IBOutlet weak var switchOutlt: UISwitch!
    @IBOutlet weak var bottomViewC: UIView!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnPoke: UIButton!
    @IBOutlet weak var openprofile: UIImageView!
    var dislikeArray =  [AllUserData]()
    @IBOutlet weak var tinderView: UIView!
    var currentLoadedCardsArray = [TinderCard]()
    var currentPhotos = 0
    var allCardsArray = [TinderCard]()
    var currentIndex = 0
    var valueArray = [AllUserData]()
    var currrentPAge : Int = 1
    var total : Int = 0
    var typefav:String = ""
    var isRewind = false
    var tempArray = [AllUserData]()
    var comingfromDetail = false
    override func viewDidLoad() {
        
        super.viewDidLoad()
        currentLoadedCardsArray.removeAll()
        allCardsArray.removeAll()
        currrentPAge = 1
        currentIndex = 0
        loadCardValues()
        switchOutlt.tintColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
        switchOutlt.onTintColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        if #available(iOS 13.0, *) {
            switchOutlt.subviews[0].subviews[0].backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
        } else if #available(iOS 12.0, *) {
            self.switchOutlt.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
        }
        
        DispatchQueue.main.async {
            self.callAPIforExplore(reset: false, dict: [:])
        }
        }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.curveView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        if iscomingFromCompleteProfile4 {
            poploanInfoView()
        }
         
        
//        self.tabBarController?.hidesBottomBarWhenPushed = true
        //        self.valueArray.removeAll()
//        if !comingfromDetail {
       
        
    }
    
    fileprivate func poploanInfoView() {
        
        if surveyPop == nil {
            //               self.view.isUserInteractionEnabled = false
            surveyPop = Bundle.main.loadNibNamed("SurveypopUPView", owner: self, options: nil)?.first as? SurveypopUPView
            surveyPop?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
          
            surveyPop?.closeButtonClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.removeChangePassView()
                }
            }
            appdelegate.window?.addSubview(surveyPop!)
           
        }
        
    }
    fileprivate func removeChangePassView() {
      
        surveyPop?.removeFromSuperview()
        surveyPop = nil
        
    }
    
    @IBAction func openProfileVC(_ sender: Any) {
        openViewController(controller: MeVC.self, storyBoard: .homeStoryboard) { (vc) in
            
            
        }
    }
    
    @IBAction func openUserDetailVC(_ sender: Any) {
        print("valueArray count ----",valueArray.count)
        print("CurrentIndex ------",currentIndex)
        if valueArray.count > 0{
            //            let value = valueArray[currentIndex]
            //            let ids = value.num
            openViewController(controller: CandidateDetailsVC.self, storyBoard: .homeStoryboard) { (vc) in
                vc.userDetail = self.tempArray[0]
                vc.delegate = self
                vc.isComingFromHome = true
            }
           
        }
        
    }
    
  
    
    @IBAction func btnretryAction(_ sender: Any) {
        if dislikeArray.count > 0 {
        self.isRewind = true
        currentIndex = 0
        loadCardValues()
    }
    }
    func sendDatafilter(reset: Bool, data: NSDictionary) {
        self.callAPIforExplore(reset: reset, dict: data)
    }
    
    
    @IBAction func btn2Action(_ sender: Any) {
        let dummyCard = currentLoadedCardsArray.first
        //du
        let total_photos = dummyCard?.totalPhotosCount
        if total_photos! > 1 &&  currentPhotos <= total_photos! - 1 {
            if currentPhotos > 0 {
                
                currentPhotos = currentPhotos - 1
                if let uiview = dummyCard?.viewWithTag(2) as? TinderbottomView {
                    uiview.pageControl.currentPage = currentPhotos
                }
                if let imageview = dummyCard?.viewWithTag(1) as? UIImageView{
                    if let imageStr =  tempArray[0].photos[currentPhotos].name{
                        print(imageStr)
                        
                        let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        let imageUrl = URL(string: urlString ?? "")
                        imageview.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Image -18"), options: .continueInBackground) { (img, err, cacheType, url) in
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func btnAction(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func action_filter(_ sender: Any) {
        //        let subcription_plan = CommonMethod().getUserDefaults(key: Constant.key_subcription_plan) as! Int
        //        if subcription_plan == 0{
        //            self.showAlert("Please purchase subscription plan for filter")
        //        }else{
        //            let storyboard = UIStoryboard(name: "TabStoryboard", bundle: nil)
        //            let filter = storyboard.instantiateViewController(withIdentifier: "filter") as! filterVC
        //            filter.delegate = self
        //            filter.isModalInPresentation = true
        //            self.present(filter, animated: true, completion: nil)
        //        }
        
    }
    
    @IBAction func action_notification(_ sender: Any) {
        
        //        let storyboard = UIStoryboard(name: "TabStoryboard", bundle: nil)
        //        let filter = storyboard.instantiateViewController(withIdentifier: "notification") as! NotificationListVC
        //        // filter.modalPresentationStyle = .fullScreen
        //        self.navigationController?.pushViewController(filter, animated: true)
        //        // self.present(filter, animated: true, completion: nil)
    }
    
    @IBAction func actionPoke(_ sender: Any) {
        let card = currentLoadedCardsArray.first
        card?.cardGoesUp()
        
        
    }
    @IBAction func actionLike(_ sender: Any) {
        
    }
    
    @IBAction func actionFav(_ sender: Any) {
        let card = currentLoadedCardsArray.first
        card?.rightClickAction()
        //let user = valueArray as!
        // self.callforFavourtite(user: card)
    }
    
    @IBAction func action_close(_ sender: Any) {
        let card = currentLoadedCardsArray.first
        
        card?.leftClickAction()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func createTinderCard(at index: Int , value :AllUserData) -> TinderCard {
        
        let card = TinderCard(frame: CGRect(x: 0, y: 0, width: tinderView.frame.size.width , height: tinderView.frame.size.height) ,value : value)
        card.delegate = self
        return card
        
    }
    
    @objc func loadInitialDummyAnimation() {
        
        let dummyCard = currentLoadedCardsArray.first
        
        dummyCard?.shakeAnimationCard()
        
    }
    
    func animateCardAfterSwiping() {
        DispatchQueue.main.async {
            for (i,card) in self.currentLoadedCardsArray.enumerated() {
                UIView.animate(withDuration: 0.3, animations: {
                    if i == 0 {
                        card.isUserInteractionEnabled = true
                    }
                    var frame = card.frame
                    frame.origin.y = CGFloat(i * SEPERATOR_DISTANCE)
                    card.frame = frame
                })
            }
        }
        
    }
    
    
    
    @IBAction func switchONOFFAC(_ sender: UISwitch) {
        if sender.isOn {
            appdelegate.setHomeView()
        }
    }
    
    func loadCardValues() {
        
        if valueArray.count > 0 {
            //            btnLike.isHidden = false
            //            btnClose.isHidden = false
            //            btnPoke.isHidden = false
            
            let capCount = (valueArray.count > MAX_BUFFER_SIZE) ? MAX_BUFFER_SIZE : valueArray.count
            if isRewind {
                
                //                            for (i,value) in dislikeArray.enumerated() {
                isRewind = false
                if dislikeArray.count > 1 {
                    let newCard1 = createTinderCard(at: dislikeArray.count - 2,value:dislikeArray[dislikeArray.count - 2])
                    allCardsArray.append(newCard1)
                    currentLoadedCardsArray.insert(newCard1, at: 0)
                    tinderView.addSubview(currentLoadedCardsArray[0])
                    let newCard = createTinderCard(at: dislikeArray.count - 1,value:dislikeArray[dislikeArray.count - 1])
                    allCardsArray.append(newCard)
                    currentLoadedCardsArray.insert(newCard, at: 1)
//                    tinderView.insertSubview(currentLoadedCardsArray[1], at: 1)
                    tinderView.insertSubview(newCard, belowSubview: currentLoadedCardsArray[0])
                   
                    dislikeArray.removeAll()
                }
                else {
                    let newCard = createTinderCard(at: dislikeArray.count - 1,value:dislikeArray[dislikeArray.count - 1])
                    allCardsArray.append(newCard)
                    currentLoadedCardsArray.insert(newCard, at: 0)
                    tinderView.addSubview(currentLoadedCardsArray[0])
                    dislikeArray.removeAll()
                    
                }
//                for (i,_) in currentLoadedCardsArray.enumerated() {
//                    //                    if i > 0 {
//                    ////                        if dislikeArray == 1 {
//                    ////
//                    ////                        }
//                    //                       // tinderView.insertSubview(currentLoadedCardsArray[i], at: 0)
//                    //                        tinderView.insertSubview(currentLoadedCardsArray[i], belowSubview: currentLoadedCardsArray[i - 1])
//                    //                    }else {
//                    //                        tinderView.insertSubview(currentLoadedCardsArray[i], at: 0)
//                    //                    }
//
//                }
                
            }
            else {
                for (i,value) in valueArray.enumerated() {
                    let newCard = createTinderCard(at: i,value:value)
                    allCardsArray.append(newCard)
                    
                    if i < capCount {
                        currentLoadedCardsArray.append(newCard)
                    }
                }
                for (i,_) in currentLoadedCardsArray.enumerated() {
                    if i > 0 {
                        tinderView.insertSubview(currentLoadedCardsArray[i], belowSubview: currentLoadedCardsArray[i - 1])
                    }else {
                        tinderView.addSubview(currentLoadedCardsArray[i])
                    }
                }
            }
            
            
            
            //  if valueArray.count  > 1 {
            animateCardAfterSwiping()
            //  }
            
        }
        else {
            currentLoadedCardsArray.removeAll()
            //            btnLike.isHidden = true
            //            btnClose.isHidden = true
            //            btnPoke.isHidden = true
            
            for card in tinderView.subviews{
                card.removeFromSuperview()
            }
            
            //            self.noRecordFound(str: "No found here!")
            
            //btnLike.isHidden = true
            // btnDislike.isHidden = true
            // self.lbl_found.text = "No user found"
        }
    }
    
    func removeObjectAndAddNewValues() {
        currentPhotos = 0
        //emojiView.rateValue =  2.5
        UIView.animate(withDuration: 0.3) {
            // self.buttonUndo.alpha = 0
        }
        
        print("currentLoadedCardsArray ------",currentLoadedCardsArray.count)
        currentLoadedCardsArray.remove(at: 0)
        if tempArray.count > 0 {
        tempArray.remove(at: 0)
        }
        //  comp_user_id = (valueArray[currentIndex] as! NSDictionary).value(forKey: "user_id") as? String ?? ""
        // if (txt_search.text?.count ?? 0 == 0){
        // currentIndex = currentIndex + 1
        
        // currentIndex = currentIndex + 1
        
        //        if (currentIndex + currentLoadedCardsArray.count) < allCardsArray.count {
        //            let card = allCardsArray[currentIndex + currentLoadedCardsArray.count]
        //            var frame = card.frame
        //            frame.origin.y = CGFloat(MAX_BUFFER_SIZE * SEPERATOR_DISTANCE)
        //            card.frame = frame
        //            currentLoadedCardsArray.append(card)
        //            tinderView.insertSubview(currentLoadedCardsArray[MAX_BUFFER_SIZE - 1], belowSubview: currentLoadedCardsArray[MAX_BUFFER_SIZE - 2])
        //        }
        // }
        print(currentIndex)
        //typefav = "favourite"
        let cardInfo = valueArray[currentIndex]
        currentIndex = currentIndex + 1
//        dislikeArray.append(cardInfo)
        self.callAPIforcandidateProfile(status: "liked", userID: cardInfo.id)
        if (currentIndex == valueArray.count) {
            if total > currrentPAge {
                // btnLike.isHidden = false
                // btnDislike.isHidden = false
                currentIndex = 0
                currrentPAge = currrentPAge + 1
                DispatchQueue.main.async {
                    self.callAPIforExplore(reset: false, dict: [:])
                }
            }
            
        }
        
        
        animateCardAfterSwiping()
    }
    func removeObjectAndAddNewValuesForSuperLike() {
        currentPhotos = 0
        //emojiView.rateValue =  2.5
        UIView.animate(withDuration: 0.3) {
            // self.buttonUndo.alpha = 0
        }
        
        print("currentLoadedCardsArray ------",currentLoadedCardsArray.count)
        currentLoadedCardsArray.remove(at: 0)
        if tempArray.count > 0 {
        tempArray.remove(at: 0)
        }
        //  comp_user_id = (valueArray[currentIndex] as! NSDictionary).value(forKey: "user_id") as? String ?? ""
        // if (txt_search.text?.count ?? 0 == 0){
        // currentIndex = currentIndex + 1
        
        // currentIndex = currentIndex + 1
        
        //        if (currentIndex + currentLoadedCardsArray.count) < allCardsArray.count {
        //            let card = allCardsArray[currentIndex + currentLoadedCardsArray.count]
        //            var frame = card.frame
        //            frame.origin.y = CGFloat(MAX_BUFFER_SIZE * SEPERATOR_DISTANCE)
        //            card.frame = frame
        //            currentLoadedCardsArray.append(card)
        //            tinderView.insertSubview(currentLoadedCardsArray[MAX_BUFFER_SIZE - 1], belowSubview: currentLoadedCardsArray[MAX_BUFFER_SIZE - 2])
        //        }
        // }
        print(currentIndex)
        //typefav = "favourite"
        let cardInfo = valueArray[currentIndex]
        currentIndex = currentIndex + 1
//        dislikeArray.append(cardInfo)
        self.callAPIforSuperLike(userID: cardInfo.id)
        if (currentIndex == valueArray.count) {
            if total > currrentPAge {
                // btnLike.isHidden = false
                // btnDislike.isHidden = false
                currentIndex = 0
                currrentPAge = currrentPAge + 1
                DispatchQueue.main.async {
                    self.callAPIforExplore(reset: false, dict: [:])
                }
            }
            
        }
        
        
        animateCardAfterSwiping()
    }
    
    
    
    func removeObjectAndAddNewValuesfromAdded() {
        currentPhotos = 0
        //emojiView.rateValue =  2.5
        UIView.animate(withDuration: 0.3) {
            // self.buttonUndo.alpha = 0
        }
        
        print("currentLoadedCardsArray ------",currentLoadedCardsArray.count)
        currentLoadedCardsArray.remove(at: 0)
        if tempArray.count > 0 {
        tempArray.remove(at: 0)
        }
        // currentLoadedCardsArray.remove(at: 0)
        //  print("allCardsArray----",allCardsArray.count )
        //   print("currentLoadedCardsArray----",currentLoadedCardsArray.count )
        //   print("Current Index----",currentIndex )
        //currentIndex = currentIndex + 1
        
        //          if (currentIndex + currentLoadedCardsArray.count) < allCardsArray.count {
        //              let card = allCardsArray[currentIndex + currentLoadedCardsArray.count]
        //              var frame = card.frame
        //              frame.origin.y = CGFloat(MAX_BUFFER_SIZE * SEPERATOR_DISTANCE)
        //              card.frame = frame
        //              currentLoadedCardsArray.append(card)
        //              tinderView.insertSubview(currentLoadedCardsArray[MAX_BUFFER_SIZE - 1], belowSubview: currentLoadedCardsArray[MAX_BUFFER_SIZE - 2])
        //          }
        
        //   print("Sumit----1",currentIndex)
        //    print("Sumit2",valueArray.count)
        //  typefav = "unfavourite"
        let cardInfo = valueArray[currentIndex]
        currentIndex = currentIndex + 1
        //    print("sumit",cardInfo.id)
        //        self.callforBlock(user: cardInfo.id)
        dislikeArray.append(cardInfo)
        self.callAPIforcandidateProfile(status: "disliked", userID: cardInfo.id)
        if (currentIndex == valueArray.count) {
            if total > currrentPAge {
                currentIndex = 0
                currrentPAge = currrentPAge + 1
                DispatchQueue.main.async {
                    self.callAPIforExplore(reset: false, dict: [:])
                }
                
            }
            
        }
        
        
        //          if currentLoadedCardsArray.count == 0 && txt_search.text?.count ?? 0 > 0 {
        //             //  txt_search.text = ""
        //              //userList()
        //          }
        
        
        animateCardAfterSwiping()
    }
    
    
    // MARK: - API call
    func callAPIforExplore(reset:Bool,dict:NSDictionary) {
        var params =  [String : Any]()
        params["page"] = String(currrentPAge)
        
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServicesForPRefrenceUSer(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                //
                let page = parseData["pagination"]
                self.total = page["total_pages"].intValue
                self.valueArray.removeAll()
                for obj in parseData["data"].arrayValue {
                    let comObj = AllUserData(fromJson:obj)
                    self.valueArray.append(comObj)
                    self.tempArray.append(comObj)
                    
                }
                
                if self.valueArray.count > 0 {
                    MAX_BUFFER_SIZE = self.valueArray.count
                }
                //                print("Value array load")
                
                else{
                    self.valueArray.removeAll()
                    self.noRecordFound(str: "Not found here!")
                }
                
                DispatchQueue.main.async {
                    print("loadCardValues")
                    self.loadCardValues()
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
    
    
    
    func noRecordFound(str:String) {
        
        if let foundView = view.viewWithTag(99999999) {
            foundView.removeFromSuperview()
        }
        let lbl:UILabel = UILabel(frame: CGRect(x: 10, y: (SCREEN_HEIGHT/2)-20, width: SCREEN_WIDTH - 20, height: 40))
        lbl.text = str
        lbl.textColor = UIColor.white
        lbl.backgroundColor = .clear
        lbl.textAlignment = .center
        lbl.font = UIFont(name: AppFontRegular, size: 12)
        lbl.tag = 99999999
        self.view.insertSubview(lbl, at: 0)
    }
    
    
    
    
    // MARK : - API call
    func callAPIforcandidateProfile(status:String,userID:String) {
        var params =  [String : Any]()
        params["status"] = status
        params["user_id"] = userID
        
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServicesForLikeAndDislikeUsers(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                //
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
    func callAPIforSuperLike(userID:String) {
        var params =  [String : Any]()
        params["status"] = "requested"
        params["user_id"] = userID
        params["type"] =  "invite"
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServicesForsuperLike(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                //
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
    
    func callAPIforRequestedUser(status:String,userID:String) {
        var params =  [String : Any]()
        params["type"] = "invite"
        params["user_id"] = userID
        params["requested"] = "requested"
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServicesForLikeAndDislikeUsers(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                //
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
    
    
    
    
    // MARK : - API call
    //    func callforPoke(user:Int) {
    //
    //        let token = CommonMethod().getUserDefaults(key: Constant.key_device_token) as! String
    //
    //        //  let userId = CommonMethod().getUserDefaults(key: Constant.key_user_ID) as! String
    //
    //        //Constant.key_user_ID) as! String
    //
    //        self.activityIndicatorBegin()
    //
    //        let data  = [
    //            "user_id" : user,
    //            "lang" : "en",
    //            "apikey" : "union",
    //            "device_type" : "iOS",
    //            "os_version" : ios_version,
    //            "app_version" : "1.0.0",
    //            "device_token": token
    //
    //            ] as [String:Any]
    //        //let strUrl = AppString.profileDetails\"user_id="+userId
    //
    //        Apicall.sharedInstance.httpinterctaionwithUrl(strurl: AppString.poke, param: data, isAuth: true, completion: { (result) in
    //
    //            print("%@",result)
    //            let response = result as! [String:Any]
    //            self.activityIndicatorEnd()
    //            if(response["status"] as! Int == 200 ){
    //                self.showAlert(response["msg"] as! String)
    //            }else{
    //                self.showAlert(response["msg"] as! String)
    //            }
    //        }) { (error) in
    //
    //            self.activityIndicatorEnd()
    //
    //            print("%@",error)
    //
    //        }
    //
    //    }
    // MARK : - API call
    func callforFavourtite(user:Int) {
        //
        //        let token = CommonMethod().getUserDefaults(key: Constant.key_device_token) as! String
        //
        //        //Constant.key_user_ID) as! String
        //
        //        self.activityIndicatorBegin()
        //
        //        let data  = [
        //            "favourite_user_id":user,
        //            "device_type":"iOS",
        //            "app_version":ios_version,
        //            "os_version":"1.0.0",
        //            "apikey":"union",
        //            "type":"favourite",
        //            "lang" : "en",
        //            "device_token": token,
        //            ] as [String:Any]
        //
        //        //let strUrl = AppString.profileDetails\"user_id="+userId
        //
        //        Apicall.sharedInstance.httpinterctaionwithUrl(strurl: AppString.isFavourite, param: data, isAuth: true, completion: { (result) in
        //
        //            print("%@",result)
        //            let response = result as! [String:Any]
        //            self.activityIndicatorEnd()
        //            if(response["status"] as! Int == 200 ){
        //
        //            }else{
        //                self.showAlert(response["msg"] as! String)
        //            }
        //        }) { (error) in
        //
        //            self.activityIndicatorEnd()
        //
        //            print("%@",error)
        //
        //        }
        //
    }
    
    // MARK : - API call
    //    func callforBlock(user:Int) {
    //
    //        let token = CommonMethod().getUserDefaults(key: Constant.key_device_token) as! String
    //
    //        //Constant.key_user_ID) as! String
    //
    //        self.activityIndicatorBegin()
    //
    //        let data  = [
    //            "user_id":user,
    //            "device_type":"iOS",
    //            "app_version":ios_version,
    //            "os_version":"1.0.0",
    //            "apikey":"union",
    //            "type":"block",
    //            "lang" : "en",
    //            "device_token": token,
    //            ] as [String:Any]
    //
    //        //let strUrl = AppString.profileDetails\"user_id="+userId
    //
    //        Apicall.sharedInstance.httpinterctaionwithUrl(strurl: AppString.isBlock, param: data, isAuth: true, completion: { (result) in
    //
    //            print("%@",result)
    //            let response = result as! [String:Any]
    //            self.activityIndicatorEnd()
    //            if(response["status"] as! Int == 200 ){
    //
    //            }else{
    //                self.showAlert(response["msg"] as! String)
    //            }
    //        }) { (error) in
    //
    //            self.activityIndicatorEnd()
    //
    //            print("%@",error)
    //
    //        }
    //
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */



extension HomeVC : TinderCardDelegate{
    func cardGoesUP(card: TinderCard) {
        DispatchQueue.main.async {
            self.removeObjectAndAddNewValuesForSuperLike()
        }
    }
    
    func leftMethodTapped() {
        if tempArray.count > 0 {
        let dummyCard = currentLoadedCardsArray.first
        //du
        let total_photos = dummyCard?.totalPhotosCount
        if total_photos! > 1 &&  currentPhotos <= total_photos! - 1 {
            if currentPhotos > 0 {
                
                currentPhotos = currentPhotos - 1
                if let uiview = dummyCard?.viewWithTag(2) as? TinderbottomView {
                    uiview.pageControl.currentPage = currentPhotos
                }
                if let imageview = dummyCard?.viewWithTag(1) as? UIImageView{
                    if let imageStr =  tempArray[0].photos[currentPhotos].name{
                        print(imageStr)
                        
                        let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        let imageUrl = URL(string: urlString ?? "")
                        imageview.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Image -18"), options: .continueInBackground) { (img, err, cacheType, url) in
                        }
                    }
                }
            }
        }
        }
    }
    
    func rightMethodTapped() {
        if tempArray.count > 0 {
        let dummyCard = currentLoadedCardsArray.first
        //du
        let total_photos = dummyCard?.totalPhotosCount
        if total_photos ?? 0 > 1 && currentPhotos <= total_photos ?? 0 - 1 {
            if currentPhotos != total_photos! - 1 {
                currentPhotos = currentPhotos + 1
                if let uiview = dummyCard?.viewWithTag(2) as? TinderbottomView {
                    uiview.pageControl.currentPage = currentPhotos
                }
                if let imageview = dummyCard?.viewWithTag(1) as? UIImageView{
                    if let imageStr =  tempArray[0].photos[currentPhotos].name{
                        print(imageStr)
                        
                        let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        let imageUrl = URL(string: urlString ?? "")
                        imageview.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Image -18"), options: .continueInBackground) { (img, err, cacheType, url) in
                        }
                    }
                    
                }
                
            }
        }
        }
    }
    
    
    // action called when the card goes to the left.
    func cardGoesleft(card: TinderCard) {
        DispatchQueue.main.async {
            self.removeObjectAndAddNewValuesfromAdded()
        }
    }
    func tapedoncard()  {
        
        
        
    }
    // action called when the card goes to the right.
    func cardGoesRight(card: TinderCard) {
        DispatchQueue.main.async {
            self.removeObjectAndAddNewValues()
        }
    }
    func currentCardStatus(card: TinderCard, distance: CGFloat) {
        
        
        //        let card = currentLoadedCardsArray.first
        //        card?.rightClickAction()
        //        if distance == 0 {
        //            emojiView.rateValue =  2.5
        //        }else{
        //            let value = Float(min(abs(distance/100), 1.0) * 5)
        //            let sorted = distance > 0  ? 2.5 + (value * 5) / 10  : 2.5 - (value * 5) / 10
        //            emojiView.rateValue =  sorted
        //        }
        
        
    }
    
    
}
extension HomeVC:userActions{
    func openChat() {
        
    }
    
    func dislikeUser() {
        let card = currentLoadedCardsArray.first
        card?.leftClickAction()
    }
    
    func superLikeUser() {
        let card = currentLoadedCardsArray.first
        card?.cardGoesUp()
    }
    
    func giveHurtToUser() {
        let card = currentLoadedCardsArray.first
        card?.rightClickAction()
    }
    
    
}
