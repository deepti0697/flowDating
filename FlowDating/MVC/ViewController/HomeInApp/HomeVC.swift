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
let names = ["Adam Gontier","Matt Walst","Brad Walst","Neil Sanderson","Barry Stock","Nicky Patson"]

import UIKit

import SwiftyJSON
class HomeVC: ViewController {
    
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var btnPoke: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var tinderView: UIView!
    var currentLoadedCardsArray = [TinderCard]()
    var allCardsArray = [TinderCard]()
    var currentIndex = 0
//    var valueArray = [ExPloreModel]()
    var currrentPAge : Int = 1
    var total : Int = 0
    var typefav:String = ""
  
    let valueArray : [ExPloreModel] =  {
        var model : [ExPloreModel] = []
        for n in 1...30 {
            model.append(ExPloreModel(name: names[Int(arc4random_uniform(UInt32(names.count)))], num: "\(n)", all: [#imageLiteral(resourceName: "Image -31"),#imageLiteral(resourceName: "Image -18")]))
        }
        return model
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.pageControll.numberOfPages = 2
        //let newCard = createTinderCard(at: 0,value: [:])
        // Do any additional setup after loading the view.
      
    }
    
  
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()

           // Call the roundCorners() func right there.
       
        self.curveView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
       }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
//        self.valueArray.removeAll()
        currentLoadedCardsArray.removeAll()
        allCardsArray.removeAll()
        currrentPAge = 1
        currentIndex = 0
        loadCardValues()
//        callAPIforcandidateProfile()
//        self.callAPIforExplore(reset: false, dict: [:])
//        if  AppDelegate.sharedInstance.isLocationPermissionOn
//        {
//            DispatchQueue.main.async {
//
//            }
//        }else{
//            print("Not Permit")
//            let alert = UIAlertController(title: "Allow Location Access", message: "Turn on Location Services in your device settings.Location use for searching friend near by user. Union app upload your location on server to get precise results.", preferredStyle: UIAlertController.Style.alert)
//
//            // Button to Open Settings
//            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
//                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                    return
//                }
//                if UIApplication.shared.canOpenURL(settingsUrl) {
//                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
//                        print("Settings opened: \(success)")
//                    })
//                }
//            }))
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//            DispatchQueue.main.async {
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
     
        
    }
    
    @IBAction func openProfileVC(_ sender: Any) {
        openViewController(controller: MeVC.self, storyBoard: .homeStoryboard) { (vc) in

        }
    }
    @IBOutlet weak var openprofile: UIImageView!
    func sendDatafilter(reset: Bool, data: NSDictionary) {
        self.callAPIforExplore(reset: reset, dict: data)
    }
    
    @IBAction func btn2Action(_ sender: Any) {
            let dummyCard = currentLoadedCardsArray.first
                          
                    if let imageview = dummyCard?.viewWithTag(1) as? UIImageView{
                        imageview.image = valueArray[1].all[0]
                        self.pageControll.currentPage = 0
                    }
        }
        @IBAction func btnAction(_ sender: Any) {
            let dummyCard = currentLoadedCardsArray.first
                  
            if let imageview = dummyCard?.viewWithTag(1) as? UIImageView{
                imageview.image = valueArray[1].all[1]
                self.pageControll.currentPage = 1
            }
        }
    
    @IBAction func openPageDetailAcrtion(_ sender: Any) {
        
        print("valueArray count ----",valueArray.count)
        print("CurrentIndex ------",currentIndex)
        if valueArray.count > 0{
//            let value = valueArray[currentIndex]
//            let ids = value.num
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let filter = storyboard.instantiateViewController(withIdentifier: "CandidateDetailsVC") as! CandidateDetailsVC
//            filter.personUserid = ids ?? 0
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(filter, animated: false)
            }
            
            
        }
        
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
        
        card?.leftClickAction()
//        let cardInfo = valueArray[currentIndex]
//        self.callforPoke(user:cardInfo.id)
        
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
    
    func createTinderCard(at index: Int , value :ExPloreModel) -> TinderCard {
        
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
        if !sender.isOn {
            appdelegate.setHomeView()
        }
    }
    func loadCardValues() {
        
        if valueArray.count > 0 {
            btnLike.isHidden = false
            btnClose.isHidden = false
            btnPoke.isHidden = false
            
            let capCount = (valueArray.count > MAX_BUFFER_SIZE) ? MAX_BUFFER_SIZE : valueArray.count
            
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
            
            //  if valueArray.count  > 1 {
            animateCardAfterSwiping()
            //  }
            
        }
        else {
            currentLoadedCardsArray.removeAll()
            btnLike.isHidden = true
            btnClose.isHidden = true
            btnPoke.isHidden = true
            
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
        
        //emojiView.rateValue =  2.5
        UIView.animate(withDuration: 0.3) {
            // self.buttonUndo.alpha = 0
        }
        
        print("currentLoadedCardsArray ------",currentLoadedCardsArray.count)
        currentLoadedCardsArray.remove(at: 0)
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
//        self.callforFavourtite(user: cardInfo.id)
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
        
        //emojiView.rateValue =  2.5
        UIView.animate(withDuration: 0.3) {
            // self.buttonUndo.alpha = 0
        }
        
        print("currentLoadedCardsArray ------",currentLoadedCardsArray.count)
        currentLoadedCardsArray.remove(at: 0)
        
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
        //            //  txt_search.text = ""
        //              //userList()
        //          }
        
        
        animateCardAfterSwiping()
    }
    
    
    // MARK: - API call
    func callAPIforExplore(reset:Bool,dict:NSDictionary) {
    
    }
        

    }
    
        
    
    
    
    // MARK : - API call
//    func callAPIforcandidateProfile() {
//
//        let token = CommonMethod().getUserDefaults(key: Constant.key_device_token) as! String
//
//        let userId = CommonMethod().getUserDefaults(key: Constant.key_user_ID) as! Int
//
//        self.activityIndicatorBegin()
//
//        let data  = [
//            "user_id" : userId,
//            "lang" : "en",
//            "apikey" : "union",
//            "device_type" : "iOS",
//            "os_version" : ios_version,
//            "app_version" : "1.0.0",
//            "device_token": token
//
//            ] as [String:Any]
//
//        //let strUrl = AppString.profileDetails\"user_id="+userId
//
//        Apicall.sharedInstance.httpinterctaionwithUrl(strurl: AppString.profileDetails, param: data, isAuth: true, completion: { (result) in
//
//            print("%@",result )
//            let response = result as! [String:Any]
//            self.activityIndicatorEnd()
//            if(response["status"] as! Int == 200 ){
//
//                let repo = response["data"] as! NSDictionary
//                //                           let data = repo["userInfo"] as! NSDictionary
//                let userInfo = repo.removeNullValueFromDict()
//                self.profileDATA = ProfileData().intiDataWithDict(dict: userInfo)
//                CommonMethod().saveUserDefaults(data:self.profileDATA.subcription_plan ?? 0, key: Constant.key_subcription_plan)
//
//
//            }
//
//        }) { (error) in
//
//            self.activityIndicatorEnd()
//
//            print("%@",error )
//
//        }
//
//    }
    
    
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
//    func callforFavourtite(user:Int) {
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
//    }
    
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
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    


extension HomeVC : TinderCardDelegate{
    
    // action called when the card goes to the left.
    func cardGoesUp(card: TinderCard) {
        DispatchQueue.main.async {
            self.removeObjectAndAddNewValuesfromAdded()
        }
    }
    func tapedoncard()  {
        
       
        
    }
    // action called when the card goes to the right.
    func cardGoesDown(card: TinderCard) {
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