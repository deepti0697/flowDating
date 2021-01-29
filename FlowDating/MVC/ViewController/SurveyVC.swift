//
//  SurveyVC.swift
//  FlowDating
//
//  Created by deepti on 27/01/21.
//

import UIKit

class SurveyVC: UIViewController {
    var distance = "0"
    @IBOutlet weak var twoOC: UIButton!
    @IBOutlet weak var baseview2: UIView!
    @IBOutlet weak var oneAC: UIButton!
    @IBOutlet weak var scaleView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var threeOC: UIButton!
    
    @IBOutlet weak var elevenOC: UIButton!
    @IBOutlet weak var tenOC: UIButton!
    @IBOutlet weak var nineOC: UIButton!
    @IBOutlet weak var eightOC: UIButton!
    @IBOutlet weak var sevenOc: UIButton!
    @IBOutlet weak var sixOC: UIButton!
    @IBOutlet weak var fiveOC: UIButton!
    
    @IBOutlet weak var fourOC: UIButton!
    
    @IBOutlet weak var switchonAndOffView: UIView!
    
    var currentValue = 1
    
    
    var lbl_Distance = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonRounded()
        lbl_Distance.backgroundColor = .yellow
             lbl_Distance.frame = CGRect(x: 0,y: 32,width: 60,height: 15)
             lbl_Distance.setTitleColor(.blue, for: .normal)
//             lbl_Distance.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
             lbl_Distance.setTitle("0" + " km", for: .normal)
             lbl_Distance.center = setUISliderThumbValueWithLabel(slider: slider.self)
             slider.addSubview(lbl_Distance)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var kidsView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.kidsView.isHidden = true
        self.setUIView(caseValue: currentValue)
        
    }
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()

           // Call the roundCorners() func right there.
     
        self.baseview2.roundCorners(corners: [.topLeft, .topRight], radius: 30)
       }

    @IBOutlet weak var topLabel: UILabel!
    
    func buttonRounded(){
        oneAC.layer.cornerRadius = 0.2 * oneAC.bounds.size.width
        oneAC.clipsToBounds = true
        twoOC.layer.cornerRadius = 0.2 * twoOC.bounds.size.width
        twoOC.clipsToBounds = true
        threeOC.layer.cornerRadius = 0.2 * oneAC.bounds.size.width
        threeOC.clipsToBounds = true
        fourOC.layer.cornerRadius = 0.2 * oneAC.bounds.size.width
        fourOC.clipsToBounds = true
        fiveOC.layer.cornerRadius = 0.2 * oneAC.bounds.size.width
        fiveOC.clipsToBounds = true
        sixOC.layer.cornerRadius = 0.2 * oneAC.bounds.size.width
        sixOC.clipsToBounds = true
        sevenOc.layer.cornerRadius = 0.2 * oneAC.bounds.size.width
        sevenOc.clipsToBounds = true
        eightOC.layer.cornerRadius = 0.2 * oneAC.bounds.size.width
        eightOC.clipsToBounds = true
        nineOC.layer.cornerRadius = 0.2 * oneAC.bounds.size.width
        nineOC.clipsToBounds = true
        tenOC.layer.cornerRadius = 0.2 * oneAC.bounds.size.width
        tenOC.clipsToBounds = true
        
    }
    @IBAction func oneActopn(_ sender: Any) {
        self.kidsView.isHidden = true
        self.scaleView.isHidden = false
        self.topLabel.text = "what is your Height"
        self.switchonAndOffView.isHidden = false
        self.oneAC.backgroundColor = UIColor(red: 134/255, green: 0/255, blue: 90/255, alpha: 1)
        self.oneAC.setTitleColor(.white, for: .normal)
        self.twoOC.backgroundColor = .lightGray
        self.twoOC.setTitleColor(.black, for: .normal)
        self.threeOC.backgroundColor = .lightGray
        self.threeOC.setTitleColor(.black, for: .normal)
    
    }
   
    @IBAction func threeAction(_ sender: Any) {
        self.kidsView.isHidden = false
        self.scaleView.isHidden = true
        self.threeOC.backgroundColor = UIColor(red: 134/255, green: 0/255, blue: 90/255, alpha: 1)
        self.threeOC.setTitleColor(.white, for: .normal)
        self.oneAC.backgroundColor = .lightGray
        self.oneAC.setTitleColor(.black, for: .normal)
        self.twoOC.backgroundColor = .lightGray
        self.twoOC.setTitleColor(.black, for: .normal)
        
    }
    
    @IBAction func twoAction(_ sender: Any) {
        self.kidsView.isHidden = true
        self.scaleView.isHidden = false
        self.topLabel.text = "how good looking you are"
        self.slider.minimumValue = 0
        self.slider.maximumValue = 10
        self.switchonAndOffView.isHidden = true
        self.twoOC.backgroundColor = UIColor(red: 134/255, green: 0/255, blue: 90/255, alpha: 1)
        self.twoOC.setTitleColor(.white, for: .normal)
        self.oneAC.backgroundColor = .lightGray
        self.oneAC.setTitleColor(.black, for: .normal)
        self.threeOC.backgroundColor = .lightGray
        self.threeOC.setTitleColor(.black, for: .normal)
    
    }
    
    @IBAction func distancesSliderValueChanged(_ sender: UISlider) {
           let currentValue = Int(sender.value)
           print(currentValue)
           self.lbl_Distance.isHidden = false
           let x = Int(round(sender.value))
           lbl_Distance.setTitle("\(x)" + " km", for: .normal)
           self.distance = "\(x)"
           lbl_Distance.center = setUISliderThumbValueWithLabel(slider: sender)
   
       }
       func setUISliderThumbValueWithLabel(slider: UISlider) -> CGPoint {
           let slidertTrack : CGRect = slider.trackRect(forBounds: slider.bounds)
           let sliderFrm : CGRect = slider .thumbRect(forBounds: slider.bounds, trackRect: slidertTrack, value: slider.value)
           return CGPoint(x: sliderFrm.origin.x + slider.frame.origin.x + 16, y: slider.frame.origin.y - 50)
       }

      
           // Do any additional setup after loading the view.
    func setUIView(caseValue:Int){
        switch caseValue {
        case 1:
            self.kidsView.isHidden = true
            self.scaleView.isHidden = false
            self.topLabel.text = "what is your Height"
            self.switchonAndOffView.isHidden = false
            self.oneAC.backgroundColor = UIColor(red: 134/255, green: 0/255, blue: 90/255, alpha: 1)
            self.oneAC.setTitleColor(.white, for: .normal)
            self.twoOC.backgroundColor = .lightGray
            self.twoOC.setTitleColor(.black, for: .normal)
            self.threeOC.backgroundColor = .lightGray
            self.threeOC.setTitleColor(.black, for: .normal)
        case 2:
            self.kidsView.isHidden = true
            self.scaleView.isHidden = false
            self.topLabel.text = "how good looking you are"
            self.slider.minimumValue = 0
            self.slider.maximumValue = 10
            self.switchonAndOffView.isHidden = true
            self.twoOC.backgroundColor = UIColor(red: 134/255, green: 0/255, blue: 90/255, alpha: 1)
            self.twoOC.setTitleColor(.white, for: .normal)
            self.oneAC.backgroundColor = .lightGray
            self.oneAC.setTitleColor(.black, for: .normal)
            self.threeOC.backgroundColor = .lightGray
            self.threeOC.setTitleColor(.black, for: .normal)
        default:
            self.kidsView.isHidden = false
            self.scaleView.isHidden = true
            self.threeOC.backgroundColor = UIColor(red: 134/255, green: 0/255, blue: 90/255, alpha: 1)
            self.threeOC.setTitleColor(.white, for: .normal)
            self.oneAC.backgroundColor = .lightGray
            self.oneAC.setTitleColor(.black, for: .normal)
            self.twoOC.backgroundColor = .lightGray
            self.twoOC.setTitleColor(.black, for: .normal)
        }
    }

    @IBAction func previousButtonAction(_ sender: Any) {
        self.currentValue = currentValue - 1
        self.setUIView(caseValue: currentValue)
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        self.currentValue = currentValue + 1
        self.setUIView(caseValue: currentValue)
    }
}
