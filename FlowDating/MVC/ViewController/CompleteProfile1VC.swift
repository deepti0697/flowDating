//
//  CompleteProfile1VC.swift
//  FlowDating
//
//  Created by deepti on 27/01/21.
//

import UIKit

class CompleteProfile1VC: UIViewController {
   
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
        // Do any additional setup after loading the view.
    }
 
       let toolbar = UIToolbar()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.baseView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        self.baseview2.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()

           // Call the roundCorners() func right there.
       
        self.baseview2.roundCorners(corners: [.topLeft, .topRight], radius: 30)
       }
    func setupDatePicker() {
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
          formatter.dateFormat = "dd-MMM-yyyy"
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
        sender.setImage(#imageLiteral(resourceName: "man-3"), for: .normal)
        femaleBtn.setImage(#imageLiteral(resourceName: "woman"), for: .normal)
        sender.setTitleColor(UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1), for: .normal)
        sender.layer.borderColor = UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1).cgColor
        femaleBtn.layer.borderColor = UIColor.lightGray.cgColor
        femaleBtn.setTitleColor(.lightGray, for: .normal)
//        femaleBtn.normalbtn()
        
    }
   
    @IBAction func femaleAction(_ sender: UIButton) {
//        sender.selectedbtn()
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
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
extension CompleteProfile1VC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == displayNameTxt {
           textField.resignFirstResponder()
        return true
      }
        return  true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
}

