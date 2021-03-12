//
//  VC_Interests.swift
//  SugarOrDate
//
//  Created by Diwakar Tak on 04/09/20.
//  Copyright © 2020 Sunil Pradhan. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import SwiftyJSON

class VC_Interests: UIViewController {
  
    var getMysteryUSer = [AllUserData](){
        didSet {
            collectionView_InterestingUser.reloadData()
        }
    }
    @IBOutlet weak var collectionView_InterestingUser: UICollectionView!
    
    var interestInfoArr = NSMutableArray()
    
    var selectedIndexForView = 0
    var type = "ViewedMe"
    override func viewWillAppear(_ animated: Bool) {
        UiLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    
        MysteryUser()
    }
    
    override func viewDidLoad() {
       
        tabBarItem.image = UIImage(named: "bottom_tab_heart")
    }
    @IBAction func openProfileAction(_ sender: Any) {
        openViewController(controller: MeVC.self, storyBoard: .homeStoryboard) { (vc) in

        }
    }
    @IBAction func swiftchAction(_ sender: UISwitch) {
//        if !sender.isOn {
//            openViewController(controller: HomeVC.self, storyBoard: .mainStoryBoard) { (vc) in
//
//            }
//        }
        appdelegate.setHomeVC()
       
    }
    
    func UiLoad(){
       
        
        collectionView_InterestingUser.delegate = self
        collectionView_InterestingUser.dataSource = self

    }
   
}

//MARK:- collection view delegates and data source

extension VC_Interests:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        
            return CGSize(width: collectionView_InterestingUser.frame.width/2, height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return getMysteryUSer.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell_InterestingUser", for: indexPath) as! Cell_InterestingUser
        cell.configureCell(response: getMysteryUSer[indexPath.row])

            return cell
        }
        
        
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
}


// MARK:_collection cell

// MARK:_table cell

class Cell_InterestingUser: UICollectionViewCell {
    @IBOutlet weak var img_Profile: UIImageView!
    @IBOutlet weak var lbl_NameAndAge: UILabel!
    @IBOutlet weak var lbl_AddressAnddistance: UILabel!
    @IBOutlet weak var lbl_ImagesCount: UILabel!
    
    @IBOutlet weak var matchedLbl: UILabel!
    @IBOutlet weak var img_Shadow: UIImageView!
    private var gradient: CAGradientLayer!

    
    let layerg = CAGradientLayer()
    override  func awakeFromNib() {
        superview?.awakeFromNib()
      
       
        
   
    }
    override func layoutSubviews() {
        
        let gradient2: CAGradientLayer = CAGradientLayer()
        gradient2.frame =  CGRect(x: 0.0, y: 0.0, width: self.img_Profile.frame.size.width, height: self.img_Profile.frame.size.height)
        gradient2.colors = [UIColor.black.cgColor,UIColor.clear.cgColor,UIColor.clear.cgColor]
        gradient2.locations = [0.0,0.0 ,1.0]
        
        img_Profile.layer.insertSublayer(gradient2, at: 0)
//        layerg.frame = CGRect(x: 0.0, y: 0.0, width: self.img_Profile.frame.size.width, height: self.img_Profile.frame.size.height)
    }
    
    func configureCell(response:AllUserData){
        matchedLbl.text =   "\(response.compatibility ?? "") Matched"
    }
//    func gradientLayer(){
//        gradient = CAGradientLayer()
//        gradient.frame = self.bounds
//        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
//        gradient.locations = [0, 1, 0.9, 1]
//        img_Shadow.layer.mask = gradient
//    }
//
    func cellLoad(Index:Int,lang:String){
//       gradientLayer()
    }
}

//MARK:- api calling function

extension VC_Interests{
    
    func MysteryUser(){
        let param = [String:Any]()
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForGetSavedUser(param, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                self.getMysteryUSer.removeAll()
                for obj in parseData["data"].arrayValue {
                   let comObj = AllUserData(fromJson:obj)
                    self.getMysteryUSer.append(comObj)
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
