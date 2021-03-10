//
//  MatchesVC.swift
//  FlowDating
//
//  Created by deepti on 28/01/21.
//

import UIKit
import SwiftyJSON
class MatchesVC: UIViewController {
    
    @IBOutlet weak var tableView_messages: UITableView!
    
    var getSavedUserData = [AllUserData](){
        didSet {
            tableView_messages.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedUserApi()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    @IBAction func swiftchAction(_ sender: UISwitch) {

    appdelegate.setHomeVC()
       
    }
    
    @IBAction func openProfileAction(_ sender: Any) {
        openViewController(controller: MeVC.self, storyBoard: .homeStoryboard) { (vc) in

        }
    }
}

extension MatchesVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getSavedUserData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "MatchesTableViewCell") as! MatchesTableViewCell
       
        cell.configureCell(user: getSavedUserData[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
      
            //            let value = valueArray[currentIndex]
            //            let ids = value.num
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let filter = storyboard.instantiateViewController(withIdentifier: "CandidateDetailsVC") as! CandidateDetailsVC
        filter.userDetail = self.getSavedUserData[indexPath.row]
        filter.isComingFromHome = false
//            filter.delegate = self
            //            filter.personUserid = ids ?? 0
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(filter, animated: false)
            }
        
}
    func savedUserApi(){
        let param = [String:Any]()
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForGetSavedUser(param, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                self.getSavedUserData.removeAll()
                for obj in parseData["data"].arrayValue {
                   let comObj = AllUserData(fromJson:obj)
                    self.getSavedUserData.append(comObj)
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
