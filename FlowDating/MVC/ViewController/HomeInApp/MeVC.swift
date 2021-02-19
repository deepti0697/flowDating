//
//  MeVC.swift
//  Union
//
//  Created by Ravi on 29/05/20.
//  Copyright © 2020 Union. All rights reserved.
//

import UIKit

class MeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var loctaion: UILabel!
    @IBOutlet weak var nm: UILabel!
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    var imgArray = ["Path -7","Path 440-1","Teleportation","shooting-star","survey","Group 47"]
    var valueArray = ["My Profile","My Preferences","Teleportion","Survey","Membership","Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.delegate = self
        tbl.dataSource = self
        
        imgProfile.contentMode = .scaleToFill
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openProfiuleAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
      
        
        //loctaion.text = user
//        imgProfile.sd_setImage(with: URL.init(string: user.image ?? ""), completed: nil)
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        tap.numberOfTapsRequired = 1
//        imgProfile.isUserInteractionEnabled = true
//        imgProfile.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
         guard let getTag = sender.view?.tag else { return }
//       let user = getUser()
//
//     let storyboard = UIStoryboard(name: "TabStoryboard", bundle: nil)
//     let imageView = storyboard.instantiateViewController(withIdentifier: "CommonImageVC") as! CommonImageVC
//     imageView.isModalInPresentation = true
//     imageView.imagUrl = user.image ?? ""
//     self.present(imageView, animated: true, completion: nil)
//        print("getTag == \(getTag)")
    }
    @IBAction func action_edit(_ sender: Any) {
//        var mainView: UIStoryboard!
//        mainView = UIStoryboard(name: "Profile", bundle: nil)
//        let viewcontroller : ProfileVC = mainView.instantiateViewController(withIdentifier: "Profilemaster") as! ProfileVC
//        viewcontroller.isedit = true
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return valueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cellMatch = tbl.dequeueReusableCell(withIdentifier: "MECELL", for:  indexPath as IndexPath) as! DetailsCell
        cellMatch.img1.image = UIImage.init(named: imgArray[indexPath.row]) 
        cellMatch.lbl1.text = valueArray[indexPath.row]
        cellMatch.selectionStyle = UITableViewCell.SelectionStyle.none
        return cellMatch
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if indexPath.row == 6{
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let filter = storyboard.instantiateViewController(withIdentifier: "VC_Setting") as! VC_Setting
            
            self.navigationController?.pushViewController(filter, animated: true)
        }
//        if indexPath.row == 2{
//            let storyboard = UIStoryboard(name: "TabStoryboard", bundle: nil)
//            let filter = storyboard.instantiateViewController(withIdentifier: "matual") as! MatualFriendVc
//            filter.frommatual = false
//            // filter.isModalInPresentation = true
//            self.navigationController?.pushViewController(filter, animated: true)
//            
//        }
//        if indexPath.row == 1{
//            let storyboard = UIStoryboard(name: "TabStoryboard", bundle: nil)
//            let filter = storyboard.instantiateViewController(withIdentifier: "matual") as! MatualFriendVc
//            filter.frommatual = true
//            // filter.isModalInPresentation = true
//            self.navigationController?.pushViewController(filter, animated: true)
//        }
//        if indexPath.row == 3{
//            let storyboard = UIStoryboard(name: "TabStoryboard", bundle: nil)
//            let filter = storyboard.instantiateViewController(withIdentifier: "subcription") as! SubcriptionVC
//            
//            // filter.isModalInPresentation = true
//            self.navigationController?.pushViewController(filter, animated: true)
//        }
//        if indexPath.row == 4{
//            let storyboard = UIStoryboard(name: "TabStoryboard", bundle: nil)
//            let filter = storyboard.instantiateViewController(withIdentifier: "notification") as! NotificationListVC
//            
//           // filter.isfromSetting = false
//            self.navigationController?.pushViewController(filter, animated: true)
//        }
//        if indexPath.row == 5{
//            let storyboard = UIStoryboard(name: "TabStoryboard", bundle: nil)
//            let filter = storyboard.instantiateViewController(withIdentifier: "notification") as! NotificationListVC
//            
//            filter.isfromSetting = true
//            self.navigationController?.pushViewController(filter, animated: true)
//        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = imgProfile.bounds
        gradient.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradient.locations = [0.5, 1.0]
        
        imgProfile.layer.insertSublayer(gradient, at: 0)
        
        
        let gradient2: CAGradientLayer = CAGradientLayer()
        gradient2.frame = imgProfile.bounds
        gradient2.colors = [UIColor.black.cgColor,UIColor.clear.cgColor,UIColor.clear.cgColor]
        gradient2.locations = [0.0,0.0 ,1.0]
        
        imgProfile.layer.insertSublayer(gradient2, at: 0)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imgProfile.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}