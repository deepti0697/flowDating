//
//  VC_Messages.swift
//  SugarOrDate
//
//  Created by Diwakar Tak on 04/09/20.
//  Copyright © 2020 Sunil Pradhan. All rights reserved.
//

import UIKit


class VC_Messages: UIViewController {
    
    @IBOutlet weak var tableView_messages: UITableView!
   
    

    var users = NSMutableArray()
    var searchActive = Bool()
   // var searchArr: Array<ChatRoom> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Constants.refs.databaseChats.child("170_211").child("group_member").child("211").updateChildValues(["is_online" : 1])
    }
    
    
    func UiLoad(){
//        tabBarItem.title = "TabMessages".localized(lang)
//        tabBarItem.image = UIImage(named: "bottom_tab_chat")
        tableView_messages.delegate = self
        tableView_messages.dataSource = self
        
    }
    
    @IBAction func openProfileAction(_ sender: Any) {
        openViewController(controller: MeVC.self, storyBoard: .homeStoryboard) { (vc) in

        }
    }
    @IBAction func swiftchAction(_ sender: UISwitch) {
//        if !sender.isOn {
//
//        openViewController(controller: HomeVC.self, storyBoard: .mainStoryBoard) { (vc) in
        appdelegate.setHomeVC()
//            }
//        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func getFirebaseChat(){
        
    }
    
    @IBAction func btn_ShowArchivedChatList(_ sender: Any) {
      
    
}
}

extension VC_Messages : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell_Message") as! Cell_Message
       
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//
//            //Code I want to do here Delete
//
//
//
//
//
//
//    }
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
        
//        let chatVC = storyBoardTabBar.instantiateViewController(withIdentifier: "chat") as! ChatHistoryVC
}
}
class Cell_Message: UITableViewCell {
    
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var lbl_About: UILabel!
    @IBOutlet weak var lbl_newmessagesCount: UILabel!
    @IBOutlet weak var img_Picture: UIImageView!
    @IBOutlet weak var img_MessageType: UIImageView!
    @IBOutlet weak var view_Online: UIView!
    @IBOutlet weak var lbl_LastOnline: UILabel!
    
    func cellLoad(Index: Int,lang:String){
        lbl_newmessagesCount.layer.cornerRadius = lbl_newmessagesCount.frame.height/2
        lbl_newmessagesCount.clipsToBounds = true
        img_Picture.layer.borderColor = UIColor.init(red: 161/255.0, green: 7/255.0, blue: 32/255.0, alpha: 1.0).cgColor
        img_Picture.layer.borderWidth = 2
        img_Picture.layer.borderColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1).cgColor
        
    }
}

extension VC_Messages {
    func apiCallChatDelete(node:String){
       
    }
    
   /* func apiCallChatArchived(node:String){
        
        let Param:Parameters = ["user_id":node,
                                "lang":lang,
                                "type":"block",
                                "apikey":appDelegate.apiKey,
                                "device_type":"iOS",
                                "device_token":appDelegate.deviceToken,
                                "app_version":appDelegate.appVersion,
                                "os_version":appDelegate.osVersion]
        print(Param)
        self.showHud()
        Apicall.sharedInstance.makeRequest(forStringUrl: apiIsArchived, method: .post, parameters: Param) { [unowned self] (response, error) in
            self.dismissHud()
            if(response == nil && error == nil){
                //show internet alert
            }else if(error != nil){
                
                //show alert
                
            }else if let responseJSON = response?.value as? [String : Any] {
                let responseDic =  responseJSON as NSDictionary
                let Data = responseDic.value(forKey: "data") as? NSDictionary
                let status = responseDic.value(forKey: "status") as? Int
                let msg = responseDic.value(forKey: "msg") as? String
                
                if status == successStatusCode {
                    // self.getFirebaseChat()
                }else if status == tokenExpired{
                    self.logoutTokenExpired()
                }
                else{
                    self.showAlert(title: "AppName".localized(self.lang), message: msg ?? "")
                }
            }
        }
    }
    */
    
}
extension VC_Messages:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
   
      /*  if searchBar.text != ""{
            for  dict in self.chatListUnArchived{
                self.users = dict.group_member
                
                for user in self.users {
                    let strName = (user as! RoomUser).user_name ?? ""
                    if strName == searchBar.text! {
                        if (user as! RoomUser).user_id != String(userID) {
                            self.searchArr.append(dict)
                        }
                    }
                    
                    
                }
            }
            searchActive = true
            self.tableView_messages.reloadData()

        }else{
           // origional array
            searchActive = false

        }
     
   */ }
}
