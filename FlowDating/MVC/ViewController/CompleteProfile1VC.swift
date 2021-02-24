//
//  CompleteProfile1VC.swift
//  FlowDating
//
//  Created by deepti on 27/01/21.
//

import UIKit
import  SwiftyJSON
class CompleteProfile1VC: UIViewController,UITextViewDelegate {
   
    let placeholderLabel = UILabel()
    var isMaleSelected  = true
    @IBOutlet weak var setScrollView: UIScrollView!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var displayNameTxt: UITextField!
    let datePicker = UIDatePicker()
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var baseview2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayNameTxt.delegate = self
        txtDob.inputAccessoryView = toolbar
        txtDob.inputView = datePicker
        setupDatePicker()
        self.txtDob.RightViewImage(#imageLiteral(resourceName: "Union -3"))
      
        self.descriptionTxtView.delegate = self
        placeholderLabel.text = "Short Description (Optional)"
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (descriptionTxtView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        descriptionTxtView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (descriptionTxtView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !descriptionTxtView.text.isEmpty
        self.descriptionTxtView.delegate = self
        // Do any additional setup after loading the view.
    }
 
       let toolbar = UIToolbar()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.baseView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        self.setScrollView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        self.baseview2.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()

           // Call the roundCorners() func right there.
       
        self.baseview2.roundCorners(corners: [.topLeft, .topRight], radius: 30)
       }
    func textViewDidBeginEditing(_ textView: UITextView) {

        if descriptionTxtView.textColor == UIColor.lightGray {
            descriptionTxtView.text = ""
            descriptionTxtView.textColor = UIColor.black
        }
    }
    func setupDatePicker() {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
        toolbar.sizeToFit()
        let calendar = Calendar.current
        var components = DateComponents()
        components.calendar = calendar
        components.year = -18
        let maxDate = calendar.date(byAdding: components, to: Date())
        datePicker.maximumDate = maxDate
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    }
    @objc func donedatePicker(){
          let formatter = DateFormatter()
          formatter.dateFormat = "dd MMM yyyy"
        txtDob.text = formatter.string(from: datePicker.date)
        txtDob.resignFirstResponder()
      }
      @objc func cancelDatePicker(){
          self.view.endEditing(true)
      }
    @IBAction func birthDateAction(_ sender: Any) {
//        showDatePicker()
    }
    @IBAction func maleAction(_ sender: UIButton) {
//        sender.selectedbtn()
        isMaleSelected = true
        sender.setImage(#imageLiteral(resourceName: "man"), for: .normal)
        femaleBtn.setImage(#imageLiteral(resourceName: "woman"), for: .normal)
        sender.setTitleColor(UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1), for: .normal)
        sender.layer.borderColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1).cgColor
        femaleBtn.layer.borderColor = UIColor.lightGray.cgColor
        femaleBtn.setTitleColor(.lightGray, for: .normal)
//        femaleBtn.normalbtn()
        
    }
   
    @IBAction func saveAndContinueAction(_ sender: Any) {
        if Validate.shared.validateCompletePrfoile(vc:self){
            self.completeUserProfile1()
        }
    }
    @IBAction func femaleAction(_ sender: UIButton) {
//        sender.selectedbtn()
        isMaleSelected = false
        maleBtn.setImage(#imageLiteral(resourceName: "man-1"), for: .normal)
        sender.setImage(#imageLiteral(resourceName: "woman-2"), for: .normal)
        sender.setTitleColor(UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1), for: .normal)
        sender.layer.borderColor = UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1).cgColor
        maleBtn.layer.borderColor = UIColor.lightGray.cgColor
        maleBtn.setTitleColor(.lightGray, for: .normal)
//        maleBtn.normalbtn()
    }
    
}
extension UIView {
   
}
extension CompleteProfile1VC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == displayNameTxt {
           textField.resignFirstResponder()
        return true
      }
        return  true
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if (string == " ") {
//            return false
//        }
//        return true
//    }
    func completeUserProfile1(){
        var params =  [String : Any]()
        
        params["name"] = self.displayNameTxt.text
        params["dob"] = self.txtDob.text ?? ""
        params["about"] = self.descriptionTxtView.text
        if isMaleSelected {
        params["gender"] = "male"
        }
        else {
            params["gender"] = "female"
        }
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForCompleteProfile(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                AppHelper.setStringForKey("2", key: ServiceKeys.profile_Screen)
                self.openViewController(controller: CompleteProfile2VC.self, storyBoard: .mainStoryBoard) { (vc) in
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
    func textViewDidChange(_ textView: UITextView) {
          placeholderLabel.isHidden = !descriptionTxtView.text.isEmpty
      }
}

