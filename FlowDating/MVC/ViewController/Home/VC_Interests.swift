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


class VC_Interests: UIViewController {
  
  
    @IBOutlet weak var collectionView_InterestingUser: UICollectionView!
    
    var interestInfoArr = NSMutableArray()
    var selectedIndexForView = 0
    var type = "ViewedMe"
    override func viewWillAppear(_ animated: Bool) {
        UiLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        apiCallInterest()
    }
    
    override func viewDidLoad() {
       
        tabBarItem.image = UIImage(named: "bottom_tab_heart")
    }
    @IBAction func swiftchAction(_ sender: UISwitch) {
        if sender.isOn {
            openViewController(controller: HomeVC.self, storyBoard: .mainStoryBoard) { (vc) in

            }
        }
       
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
       
                return 20
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell_InterestingUser", for: indexPath) as! Cell_InterestingUser
          

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
    
    @IBOutlet weak var img_Shadow: UIImageView!
    private var gradient: CAGradientLayer!

    
    
    
    func gradientLayer(){
        gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 1, 0.9, 1]
        img_Shadow.layer.mask = gradient
    }
    
    func cellLoad(Index:Int,lang:String){
       gradientLayer()
    }
}

//MARK:- api calling function

extension VC_Interests{
    
   func apiCallInterest() {
    
    
}
}
