//
//  CompleteProfile2VC.swift
//  FlowDating
//
//  Created by deepti on 27/01/21.
//

import UIKit
import CoreLocation
import SwiftyJSON
import RangeSeekSlider
class CompleteProfile2VC: UIViewController {
    var lbl_Distance = UIButton()
    var genderSelected = 1
    var x:Int?
    var isSwitchOn = true
    var distance_lbl_Txt:Int?
    var maximumValue = 100
    @IBOutlet weak var baseview2: UIView!
    @IBOutlet weak var distanceSwitch: UISwitch!
    @IBOutlet weak var distanceRangeSlider: UISlider!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var bothBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    
    @IBOutlet weak var ageRangeSlider: RangeSeekSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SliderLabels()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()

           // Call the roundCorners() func right there.
     
        self.baseview2.roundCorners(corners: [.topLeft, .topRight], radius: 30)
       }
    override func viewWillAppear(_ animated: Bool) {
        distanceRangeSlider.minimumValue = 0
        distanceRangeSlider.maximumValue = 100
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func SliderLabels() {
//        lbl_Distance.backgroundColor = UIColor(red: 37/255, green: 193/255, blue: 255/255, alpha: 1)
        lbl_Distance.frame = CGRect(x: 0,y: 32,width: 100,height: 12)
        lbl_Distance.setTitleColor(.lightGray, for: .normal)
//        lbl_Distance.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lbl_Distance.setTitle("0" + " Months", for: .normal)
        lbl_Distance.center = setUISliderThumbValueWithLabel(slider: distanceRangeSlider.self)
        distanceRangeSlider.addSubview(lbl_Distance)
        lbl_Distance.isHidden = true

        
    }
    
    @IBAction func distancesSliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        print(currentValue)
        self.lbl_Distance.isHidden = false
         x = Int(round(sender.value))
        if isSwitchOn {
            lbl_Distance.setTitle("\(x ?? 0) Km.", for: .normal)
        }
        else {
            lbl_Distance.setTitle("\(x ?? 0) miles.", for: .normal)
        }
        
        self.distance_lbl_Txt = (x)
        lbl_Distance.center = setUISliderThumbValueWithLabel(slider: sender)
//        setupEMI()

    }
    func setUISliderThumbValueWithLabel(slider: UISlider) -> CGPoint {
        let slidertTrack : CGRect = slider.trackRect(forBounds: slider.bounds)
        let sliderFrm : CGRect = slider .thumbRect(forBounds: slider.bounds, trackRect: slidertTrack, value: slider.value)
        return CGPoint(x: sliderFrm.origin.x + slider.frame.origin.x + 16, y: slider.frame.origin.y + 35)
    }

    @IBAction func nextButtonAction(_ sender: Any) {
        completeUserProfile1()
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            distanceRangeSlider.minimumValue = 0
            distanceRangeSlider.maximumValue = 100
            isSwitchOn = true
            lbl_Distance.setTitle("\(x ?? 0) Km.", for: .normal)
          
             
            
//            distanceRangeSlider.m
            
        }
        else {
            isSwitchOn = false
            distanceRangeSlider.minimumValue = 0
            distanceRangeSlider.maximumValue = 62.1371
            lbl_Distance.setTitle("\(x ?? 0) miles.", for: .normal)
        }
    }
    
    
    @IBAction func bothAction(_ sender: Any) {
        genderSelected = 2
        bothBtn.setImage(#imageLiteral(resourceName: "male-and-female-gender-symbols-1"), for: .normal)
        femaleBtn.setImage(#imageLiteral(resourceName: "woman"), for: .normal)
        bothBtn.setTitleColor(UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1), for: .normal)
        bothBtn.layer.borderColor = UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1).cgColor
        femaleBtn.layer.borderColor = UIColor.lightGray.cgColor
        femaleBtn.setTitleColor(.lightGray, for: .normal)
        maleBtn.layer.borderColor = UIColor.lightGray.cgColor
        maleBtn.setTitleColor(.lightGray, for: .normal)
        maleBtn.setImage(#imageLiteral(resourceName: "man-1"), for: .normal)
        
    }
    @IBAction func maleAction(_ sender: UIButton) {
        genderSelected = 1
//        sender.selectedbtn()
        sender.setImage(#imageLiteral(resourceName: "man"), for: .normal)
        femaleBtn.setImage(#imageLiteral(resourceName: "woman"), for: .normal)
        sender.setTitleColor(UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1), for: .normal)
        sender.layer.borderColor = UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1).cgColor
        femaleBtn.layer.borderColor = UIColor.lightGray.cgColor
        femaleBtn.setTitleColor(.lightGray, for: .normal)
        bothBtn.layer.borderColor = UIColor.lightGray.cgColor
        bothBtn.setTitleColor(.lightGray, for: .normal)
        bothBtn.setImage(#imageLiteral(resourceName: "male-and-female-gender-symbols"), for: .normal)
//        femaleBtn.normalbtn()
        
    }
   
    @IBAction func femaleAction(_ sender: UIButton) {
//        sender.selectedbtn()
        genderSelected  = 0
        maleBtn.setImage(#imageLiteral(resourceName: "man-1"), for: .normal)
        sender.setImage(#imageLiteral(resourceName: "woman-2"), for: .normal)
        sender.setTitleColor(UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1), for: .normal)
        sender.layer.borderColor = UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1).cgColor
        maleBtn.layer.borderColor = UIColor.lightGray.cgColor
        maleBtn.setTitleColor(.lightGray, for: .normal)
        bothBtn.layer.borderColor = UIColor.lightGray.cgColor
        bothBtn.setTitleColor(.lightGray, for: .normal)
        bothBtn.setImage(#imageLiteral(resourceName: "male-and-female-gender-symbols"), for: .normal)
//        maleBtn.normalbtn()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func completeUserProfile1(){
        var params =  [String : Any]()
        
        params["min_age"] = Int(self.ageRangeSlider.selectedMinValue)
        params["max_age"] = Int(ageRangeSlider.selectedMaxValue)
        
       
        params["distance"] = self.distance_lbl_Txt
        if isSwitchOn {
            params["distance_type"] = "km"
            
        }
        else {
            params["distance_type"] = "miles"
        }
        if genderSelected == 1 {
        params["interested_in"] = "male"
        }
        else if genderSelected == 2 {
            params["interested_in"] = "both"
        }
        else {
            params["interested_in"] = "female"
        }
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForCompleteProfile2(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                self.openViewController(controller: CompleteypuProfileVC4.self, storyBoard: .mainStoryBoard) { (vc) in
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

