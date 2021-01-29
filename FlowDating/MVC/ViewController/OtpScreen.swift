//
//  OtpScreen.swift
//  Union
//
//  Created by Ravi on 22/05/20.
//  Copyright © 2020 Union. All rights reserved.
//

import UIKit



class OtpScreen: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var lbl_expireTime: UILabel!
    @IBOutlet weak var btn_save: UIButton!
    @IBOutlet weak var txt_four: UITextField!
    @IBOutlet weak var txt_three: UITextField!
    @IBOutlet weak var txt_two: UITextField!
    @IBOutlet weak var txt_one: UITextField!
    @IBOutlet weak var lbl: UILabel!
    
    var dict : [String:Any] = [:]
    var mobile: String = ""
    var countryCode: String = ""
    var isfromLogin : Bool = false
    var socialData : [String:Any] = [:]
    var timer: Timer?
    var totalTime = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_one.delegate = self
        txt_two.delegate = self
        txt_three.delegate = self
        txt_four.delegate = self
        
        lbl.text = "Please enter 4 digit OTP send to " + "\(countryCode)" + "\(mobile)"
//        self.showAlertWithCompletion(dict["otp"] as! String, action: { (action) in
//            let str = self.dict["otp"] as! String
//            self.txt_one.text = str[0]
//            self.txt_two.text = str[1]
//            self.txt_three.text = str[2]
//            self.txt_four.text = str[3]
//            self.txt_four.becomeFirstResponder()
//
//        })

        self.startOtpTimer()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        self.navigationItem.titleView = self.tabbarTitleView(title:"OTP",color:.white)
        // self.navigationController?.setNavigationBarHidden(true, animated: true)
     
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        //self.btn_mobileNo.cornerRadius =  20.0
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK : Timer
    private func startOtpTimer() {
            self.totalTime = 120
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }

    @objc func updateTimer() {
            print(self.totalTime)
            self.lbl_expireTime.text = self.timeFormatted(self.totalTime) // will show timer
            if totalTime != 0 {
                totalTime -= 1  // decrease counter timer
            } else {
                if let timer = self.timer {
                    timer.invalidate()
                    self.timer = nil
//                    btn_save.isEnabled = false
                    
                }
            }
        }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "Expired in %02d:%02d", minutes, seconds)
    }
    
    @IBAction func actionBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(((textField.text!.count) < 1 ) && (string.count > 0)){
            if(textField  == txt_one){
                txt_two.becomeFirstResponder()
            }
            else if (textField == txt_two){
                txt_three.becomeFirstResponder()
            }
            else if (textField == txt_three){
                txt_four.becomeFirstResponder()
            }
            else if (textField == txt_four){
                txt_four.becomeFirstResponder()
            }
            textField.text = string
            return false
        }
            
        else if(((textField.text!.count) > 0 ) && (string.count > 0)){
            if(textField  == txt_one){
                txt_two.becomeFirstResponder()
            }
            else if (textField == txt_two){
                txt_three.becomeFirstResponder()
            }
            else if (textField == txt_three){
                txt_four.becomeFirstResponder()
            }
            else if (textField == txt_four){
                txt_four.becomeFirstResponder()
            }
            textField.text = string
            return false
        }
            
            
        else if (((textField.text!.count) >= 1) && (string.count == 0)){
            if(textField == txt_two){
                txt_one.becomeFirstResponder()
            }
            else if(textField == txt_three){
                txt_two.becomeFirstResponder()
            }
            else if(textField == txt_four){
                txt_three.becomeFirstResponder()
            }
            else if(textField == txt_one){
                txt_one.becomeFirstResponder()
            }
            textField.text = ""
            return false
        }
        return true
    }
    
    @IBAction func actionResnd(_ sender: Any) {
//        callAPIforOTP()
    }
    
    @IBAction func action_save(_ sender: Any) {
        
        let strOtp = "\(txt_one.text ?? "")\(txt_two.text ?? "")\(txt_three.text ?? "")\(txt_four.text ?? "")"
        
      
        
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

