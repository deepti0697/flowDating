//
//  SurveyVC.swift
//  FlowDating
//
//  Created by deepti on 27/01/21.
//

import UIKit
import SwiftyJSON
class SurveyVC: UIViewController {
    
    var isSwitchOn = true
    var distance = 0
    var relevantSelectedIndexArray = [Int]()
    var selectedQualitiesArray = [Int]()
    var otherPersonQualities = [Int]()
    var personalityValue = 0
    var clarityValue = 0
    var decisionValue = 0
    var interesetedValue  = 0
    
    @IBOutlet weak var twoOC: UIButton!
    @IBOutlet weak var baseview2: UIView!
    @IBOutlet weak var oneAC: UIButton!
    @IBOutlet weak var scaleView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var threeOC: UIButton!
    
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextView: GradientView!
    @IBOutlet weak var previousView: GradientView!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var colcnView: UIView!
    @IBOutlet weak var twelveOC: UIButton!
    @IBOutlet weak var elevenOC: UIButton!
    @IBOutlet weak var tenOC: UIButton!
    @IBOutlet weak var nineOC: UIButton!
    @IBOutlet weak var eightOC: UIButton!
    @IBOutlet weak var sevenOc: UIButton!
    @IBOutlet weak var sixOC: UIButton!
    @IBOutlet weak var fiveOC: UIButton!
    var value = -1 {
        didSet {
        collctnView.reloadData()
        }
    }
    @IBOutlet weak var collctnView: UICollectionView!
    @IBOutlet weak var fourOC: UIButton!
    @IBOutlet weak var switchonAndOffView: UIView!
    
    var currentValue = 1
    
    var relevantArray = ["Travel","Sports","Reading/Art/Music","Business/Work","Chill/Relax"]
    var descriptionArray = ["Smart","Cute/Dear","Honest/Loyal","Careerist","Sense of humour",
                            "Energy","Supportive/Helpful" ,"Spontaneous"]
    var qualitiesArray = ["You are his/her priority","Laugh together","Supports/Takes care of you","Meaningfuleaningfull conversations","Full of surprises/Fascinates you","Honest/Loyal"        ,"Cute/Dear","Quality sex"]
    var personalityArray = ["Extravert","Introvert"]
    var observableArray = ["I trust tested and focus on facts","I trust my intuition and better keep my options open"]
    var decisionsArray = ["Emotions","Rationality"]
    var flexibilityArray = [" Lets stick to the plan and clarity","Lets go with the flow and face the unknown"]

    var lbl_Distance = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
//        buttonRounded()
//        lbl_Distance.backgroundColor = .yellow
             lbl_Distance.frame = CGRect(x: 0,y: 32,width: 100,height: 15)
        lbl_Distance.setTitleColor(.lightGray, for: .normal)
        lbl_Distance.titleLabel?.font =  UIFont(name: "sf_ui_display_light.ttf", size: 12)
//             lbl_Distance.Font = UIFont.systemFont(ofSize: 12, weight: .light)
//        lbl_Distance.setTitle("121 CM", for: .normal)
             lbl_Distance.center = setUISliderThumbValueWithLabel(slider: slider.self)
             slider.addSubview(lbl_Distance)
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = CGSize(width: self.view.frame.width, height:60)
              collectionLayout.minimumInteritemSpacing = 1
        collectionLayout.scrollDirection = .vertical
        lbl_Distance.isHidden = true
              collctnView.collectionViewLayout = collectionLayout
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var kidsView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
//
        self.setUIView(caseValue: currentValue)
        self.slider.minimumValue = 121
        self.slider.maximumValue = 190
        self.colcnView.isHidden = true
        self.kidsView.isHidden = true
        if currentValue == 1 {
            self.previousView.isHidden = true
            self.stackViewHeightConstraint.constant = 50
        }
        else {
            self.previousView.isHidden = false
            self.stackViewHeightConstraint.constant = 110
        }
    }
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
            buttonRounded()
           // Call the roundCorners() func right there.
     
        self.baseview2.roundCorners(corners: [.topLeft, .topRight], radius: 30)
       }

    @IBOutlet weak var topLabel: UILabel!
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func youHaveNoKidsAction(_ sender: Any) {
        
    }
    @IBAction func youhaveKidsAction(_ sender: Any) {
    }
    func buttonRounded(){
//        oneAC.backgroundColor =
       
        oneAC.layer.cornerRadius = twoOC.frame.size.height / 2.0
        oneAC.layer.masksToBounds = true
       
        twoOC.layer.cornerRadius = twoOC.frame.size.height / 2.0
        twoOC.layer.masksToBounds = true
        threeOC.layer.cornerRadius = oneAC.frame.size.width / 2.0
        threeOC.layer.masksToBounds = true
        fourOC.layer.cornerRadius = oneAC.frame.size.width / 2.0
        fourOC.layer.masksToBounds = true
        fiveOC.layer.cornerRadius = oneAC.frame.size.width / 2.0
        fiveOC.layer.masksToBounds = true
        sixOC.layer.cornerRadius = oneAC.frame.size.width / 2.0
        sixOC.layer.masksToBounds = true
        sevenOc.layer.cornerRadius = oneAC.frame.size.width / 2.0
        sevenOc.layer.masksToBounds = true
        eightOC.layer.cornerRadius = oneAC.frame.size.width / 2.0
        eightOC.layer.masksToBounds = true
        nineOC.layer.cornerRadius = oneAC.frame.size.width / 2.0
        nineOC.layer.masksToBounds = true
        tenOC.layer.cornerRadius = oneAC.frame.size.width / 2.0
        tenOC.layer.masksToBounds = true
        elevenOC.layer.cornerRadius = oneAC.frame.size.width / 2.0
        elevenOC.layer.masksToBounds = true

        twelveOC.layer.cornerRadius = oneAC.frame.size.width / 2.0
        twelveOC.layer.masksToBounds = true
        
    }
    override func viewDidLayoutSubviews() {
//        buttonRounded()
    }
    @IBAction func oneActopn(_ sender: Any) {
       
    
    }
   
    @IBAction func threeAction(_ sender: Any) {
       
    }
    
    @IBAction func twoAction(_ sender: Any) {
       
    
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            self.slider.minimumValue = 121
            self.slider.maximumValue = 195
            isSwitchOn = true
//            self.slider.
            slider.setValue(121, animated: false)
           lbl_Distance.setTitle("121 CM", for: .normal)
        }
        else {
            isSwitchOn = false
            self.slider.minimumValue = 47
            self.slider.maximumValue = 77
            lbl_Distance.setTitle("47 Inches", for: .normal)
            slider.setValue(47, animated: false)
        }
//        vehicleHeightSliderValueChanged(slider)
//        sender.isOn = !sender.isOn
    }
   
    @IBAction func distancesSliderValueChanged(_ sender: UISlider) {
           let currentValue = Int(sender.value)
           print(currentValue)
           self.lbl_Distance.isHidden = false
           let x = Int(round(sender.value))
       
       
           self.distance = (x)
           lbl_Distance.center = setUISliderThumbValueWithLabel(slider: sender)
        switch self.currentValue {
        case 2,4,5:
            lbl_Distance.setTitle("\(x)", for: .normal)
        default:
            if isSwitchOn{
               lbl_Distance.setTitle("\(x) CM", for: .normal)
            }
            else {
              
                lbl_Distance.setTitle( "\(x) Inches", for: .normal)
            }
        }
        
   
       }
       func setUISliderThumbValueWithLabel(slider: UISlider) -> CGPoint {
           let slidertTrack : CGRect = slider.trackRect(forBounds: slider.bounds)
           let sliderFrm : CGRect = slider .thumbRect(forBounds: slider.bounds, trackRect: slidertTrack, value: slider.value)
           return CGPoint(x: sliderFrm.origin.x + slider.frame.origin.x + 16, y: slider.frame.origin.y - 40)
       }

      
           // Do any additional setup after loading the view.
    func setUIView(caseValue:Int){
        switch caseValue {
        case 1:
            self.colcnView.isHidden = true
            self.kidsView.isHidden = true
            self.scaleView.isHidden = false
            self.topLabel.text = "what is your Height"
            self.switchonAndOffView.isHidden = false
            self.oneAC.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
            self.oneAC.setTitleColor(.white, for: .normal)
            self.twoOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.twoOC.setTitleColor(.black, for: .normal)
            
            case 2:
            self.kidsView.isHidden = true
            self.scaleView.isHidden = false
            self.topLabel.text = "how good looking you are"
            self.slider.minimumValue = 1
            self.slider.maximumValue = 10
//                lbl_Distance.setTitle("5", for: .normal)
            self.switchonAndOffView.isHidden = true
            self.twoOC.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
            self.twoOC.setTitleColor(.white, for: .normal)
            self.oneAC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.oneAC.setTitleColor(.black, for: .normal)
            self.threeOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.threeOC.setTitleColor(.black, for: .normal)
            self.colcnView.isHidden = true
        case 3 :
            self.kidsView.isHidden = false
            
            self.scaleView.isHidden = true
//            self.topLabel.text = "how good looking you are"
            self.slider.minimumValue = 1
            self.slider.maximumValue = 10
            self.switchonAndOffView.isHidden = true
            slider.setValue(1, animated: false)
            self.threeOC.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
            self.threeOC.setTitleColor(.white, for: .normal)
            self.fourOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.fourOC.setTitleColor(.black, for: .normal)
            self.twoOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.twoOC.setTitleColor(.black, for: .normal)
            self.colcnView.isHidden = true
        case 4:
            self.kidsView.isHidden = true
            self.scaleView.isHidden = false
            self.topLabel.text = "how wealthy you are"
            self.slider.minimumValue = 1
            self.slider.maximumValue = 10
            self.lbl_Distance.setTitle("1", for: .normal)
            slider.setValue(1, animated: false)
            self.switchonAndOffView.isHidden = true
            self.fourOC.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
            self.fourOC.setTitleColor(.white, for: .normal)
            self.fiveOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.fiveOC.setTitleColor(.black, for: .normal)
            self.threeOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.threeOC.setTitleColor(.black, for: .normal)
            self.colcnView.isHidden = true
        case 5:
            self.kidsView.isHidden = true
            self.scaleView.isHidden = false
            self.topLabel.text = "How important is other person’s wealth to you"
            self.slider.minimumValue = 1
            self.slider.maximumValue = 10
            self.fiveOC.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
            self.fiveOC.setTitleColor(.white, for: .normal)
            self.fourOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.fourOC.setTitleColor(.black, for: .normal)
            self.sixOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.sixOC.setTitleColor(.black, for: .normal)
            self.colcnView.isHidden  = true
        case 6:
            self.kidsView.isHidden = true
            self.scaleView.isHidden = true
            self.sixOC.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
            self.sixOC.setTitleColor(.white, for: .normal)
            self.sevenOc.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.sevenOc.setTitleColor(.black, for: .normal)
            self.fiveOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.fiveOC.setTitleColor(.black, for: .normal)
            self.collectionLabel.text = "Mark 1 to 3 things that are most relevant for you"
            self.colcnView.isHidden  = false
            value = 6
        case 7:
            self.kidsView.isHidden = true
            self.scaleView.isHidden = true
            self.sevenOc.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
            self.sevenOc.setTitleColor(.white, for: .normal)
            self.sixOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.sixOC.setTitleColor(.black, for: .normal)
            self.eightOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.eightOC.setTitleColor(.black, for: .normal)
            self.colcnView.isHidden = false
            self.collectionLabel.text = "Choose 1 to 4  given qualities that best describes you"
            value = 7
        case 8:
            self.kidsView.isHidden = true
            self.scaleView.isHidden = true
            self.eightOC.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
            self.eightOC.setTitleColor(.white, for: .normal)
            self.nineOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.nineOC.setTitleColor(.black, for: .normal)
            self.sevenOc.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.sevenOc.setTitleColor(.black, for: .normal)
            self.colcnView.isHidden = false
            self.collectionLabel.text = "Choose 4 out of 8 given qualities that you most appreciate in the other person"
            value = 8
        case 9:
            self.kidsView.isHidden = true
            self.scaleView.isHidden = true
            self.nineOC.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
            self.nineOC.setTitleColor(.white, for: .normal)
            self.tenOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.tenOC.setTitleColor(.black, for: .normal)
            self.eightOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.eightOC.setTitleColor(.black, for: .normal)
            self.colcnView.isHidden = false
            self.collectionLabel.text = "Which of these two personality types you are more like? "
            value = 9
        case 10:
            self.kidsView.isHidden = true
            self.scaleView.isHidden = true
            self.tenOC.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
            self.tenOC.setTitleColor(.white, for: .normal)
            self.nineOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.nineOC.setTitleColor(.black, for: .normal)
            self.elevenOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.elevenOC.setTitleColor(.black, for: .normal)
            self.colcnView.isHidden = false
            self.collectionLabel.text = "Are you more interested in facts and observable things, focusing on the tried and tested or are you visionary, more interested in ideas, focusing on novelty and always leave your options open? "
            value = 10
        case 11:
            self.kidsView.isHidden = true
            self.scaleView.isHidden = true
            self.elevenOC.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
            self.elevenOC.setTitleColor(.white, for: .normal)
            self.tenOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.tenOC.setTitleColor(.black, for: .normal)
            self.twelveOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.twelveOC.setTitleColor(.black, for: .normal)
            self.collectionLabel.text = "Based on what you usually make decisions? "
            self.colcnView.isHidden = false
            value = 11
        case 12:
            self.kidsView.isHidden = true
            self.scaleView.isHidden = true
            self.twelveOC.backgroundColor = UIColor(red: 148/255, green: 51/255, blue: 203/255, alpha: 1)
            self.twelveOC.setTitleColor(.white, for: .normal)
            self.tenOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.tenOC.setTitleColor(.black, for: .normal)
            self.elevenOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.elevenOC.setTitleColor(.black, for: .normal)
            self.collectionLabel.text = "Do you prefer clarity, closure and always stick to the plan or rather go with the flow, keep your options open and be always flexible? "
            self.colcnView.isHidden = false
            value = 12
        default:
          break
        }
    }

    @IBAction func previousButtonAction(_ sender: Any) {
        if currentValue <= 1 || currentValue == 2{
            self.previousView.isHidden = true
            self.stackViewHeightConstraint.constant = 60
            self.colcnView.isHidden = true
            self.kidsView.isHidden = true
            self.scaleView.isHidden = false
            self.topLabel.text = "what is your Height"
            self.switchonAndOffView.isHidden = false
            self.oneAC.backgroundColor = UIColor(red: 134/255, green: 0/255, blue: 90/255, alpha: 1)
            self.oneAC.setTitleColor(.white, for: .normal)
            self.twoOC.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            self.twoOC.setTitleColor(.black, for: .normal)
            self.currentValue = currentValue - 1
            return
        }
        else {
        self.currentValue = currentValue - 1
        self.setUIView(caseValue: currentValue)
        
    }
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        if currentValue >= 12 {
            appdelegate.setHomeVC()
        }
        else {
            self.previousView.isHidden = false
            self.stackViewHeightConstraint.constant = 110
            switch currentValue {
            case 6,7:
                if relevantSelectedIndexArray.count >= 1 {
                    hitSurvey(param: setParameters(str: currentValue))
                }
                else {
                    Common.showAlert(alertMessage: "Please Select minimum 1", alertButtons: ["Ok"]) { (bt) in
                    }
                }
            case 8:
                if relevantSelectedIndexArray.count < 5 {
                    hitSurvey(param: setParameters(str: currentValue))
                }
                else {
                    Common.showAlert(alertMessage: "Please Select minimum 4", alertButtons: ["Ok"]) { (bt) in
                    }
                }
            
            default:
                hitSurvey(param: setParameters(str: currentValue))
            }
           
        
       
        }
    }
}
extension SurveyVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch value {
        case 6:
            return relevantArray.count
            
        case 7:
            return qualitiesArray.count
        case 8 :
            return descriptionArray.count
        case 9:
            return  personalityArray.count
        case 10:
            return observableArray.count
        case 11:
            return decisionsArray.count
            case 12:
                return flexibilityArray.count
        default:
         break
        }
       return 0
    }
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        switch  value {
        case 6:
            cell.lblSubject.text = self.relevantArray[indexPath.row]
          
                      if relevantSelectedIndexArray.contains(indexPath.row) {
                        cell.collectionImageView.image = #imageLiteral(resourceName: "Group 9950")
                      }
                      else {
                        cell.collectionImageView.image =  #imageLiteral(resourceName: "Rectangle 3733")
                      }
            
        case 7 :
            
            cell.lblSubject.text = self.qualitiesArray[indexPath.row]
          
                      if selectedQualitiesArray.contains(indexPath.row) {
                        cell.collectionImageView.image = #imageLiteral(resourceName: "Group 9950")
                      }
                      else {
                        cell.collectionImageView.image =  #imageLiteral(resourceName: "Rectangle 3733")
                      }
       
        case 8:
            cell.lblSubject.text = self.descriptionArray[indexPath.row]
            if otherPersonQualities.contains(indexPath.row) {
              cell.collectionImageView.image = #imageLiteral(resourceName: "Group 9950")
            }
            else {
              cell.collectionImageView.image =  #imageLiteral(resourceName: "Rectangle 3733")
            }
       case 9 :
        cell.lblSubject.text = self.personalityArray[indexPath.row]
        if personalityValue == indexPath.row {
            cell.collectionImageView.image = #imageLiteral(resourceName: "Group 9950")
          
        }
        else {
            cell.collectionImageView.image = #imageLiteral(resourceName: "Rectangle 3733")
          
        }
        case 10:
            cell.lblSubject.text = self.observableArray[indexPath.row]
            if interesetedValue == indexPath.row {
                cell.collectionImageView.image = #imageLiteral(resourceName: "Group 9950")
              
            }
            else {
                cell.collectionImageView.image = #imageLiteral(resourceName: "Rectangle 3733")
              
            }
        case 11:
            cell.lblSubject.text = self.decisionsArray[indexPath.row]
            if decisionValue == indexPath.row {
                cell.collectionImageView.image = #imageLiteral(resourceName: "Group 9950")
              
            }
            else {
                cell.collectionImageView.image = #imageLiteral(resourceName: "Rectangle 3733")
              
            }
            
        case 12:
            cell.lblSubject.text = self.flexibilityArray[indexPath.row]
         
            if clarityValue == indexPath.row {
                cell.collectionImageView.image = #imageLiteral(resourceName: "Group 9950")
              
            }
            
            else {
                cell.collectionImageView.image = #imageLiteral(resourceName: "Rectangle 3733")
            }
        default:
        break
       
    
    }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 30)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch  value {
        case 6:
            if relevantSelectedIndexArray.count < 3 {
                if relevantSelectedIndexArray.contains(indexPath.row){
    //                relevantSelectedIndexArray.remove(at: indexPath.row)
                    relevantSelectedIndexArray = relevantSelectedIndexArray.filter{ $0 != indexPath.row }
                }
                else {
                self.relevantSelectedIndexArray.append(indexPath.row)
                }
            }
            else{
                if relevantSelectedIndexArray.contains(indexPath.row){
    //                relevantSelectedIndexArray.remove(at: indexPath.row)
                    relevantSelectedIndexArray = relevantSelectedIndexArray.filter{ $0 != indexPath.row}
                }
                else {
                Common.showAlert(alertMessage: "You can select maximum 3", alertButtons: ["Ok"]) { (bt) in
                }
                }
            }
        case 7:
            if selectedQualitiesArray.count < 4 {
                if selectedQualitiesArray.contains(indexPath.row){
    //                relevantSelectedIndexArray.remove(at: indexPath.row)
                    selectedQualitiesArray = selectedQualitiesArray.filter{ $0 != indexPath.row}
                }
                else {
                self.selectedQualitiesArray.append(indexPath.row)
                }
            }
            else{
                if selectedQualitiesArray.contains(indexPath.row){
    //                relevantSelectedIndexArray.remove(at: indexPath.row)
                    selectedQualitiesArray = selectedQualitiesArray.filter{ $0 != indexPath.row}
                }
                else {
                Common.showAlert(alertMessage: "You can select maximum 4", alertButtons: ["Ok"]) { (bt) in
                }
                }
            }
        case 8:
            if otherPersonQualities.count < 4 {
                if otherPersonQualities.contains(indexPath.row){
    //                relevantSelectedIndexArray.remove(at: indexPath.row)
                    otherPersonQualities = otherPersonQualities.filter{ $0 != indexPath.row}
                }
                else {
                self.otherPersonQualities.append(indexPath.row)
                }
            }
            else{
                if otherPersonQualities.contains(indexPath.row){
    //                relevantSelectedIndexArray.remove(at: indexPath.row)
                    otherPersonQualities = otherPersonQualities.filter{ $0 != indexPath.row}
                }
                else {
                Common.showAlert(alertMessage: "You can select maximum 4", alertButtons: ["Ok"]) { (bt) in
                }
                }
            }
        case 9:

            personalityValue = indexPath.row
        case 10:

            interesetedValue = indexPath.row
        case 11:

            decisionValue = indexPath.row
        case 12:

            clarityValue    = indexPath.row
        default:
           
            
        break
        }
        collctnView.reloadData()

    }
      
//
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//         return sectionInsets
//     }
//
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//         return spacingBetweenCells
//     }
    func showScale(){
//        self.kidsView.isHidden = true
//        self.scaleView.isHidden = false
//        self.switchonAndOffView.isHidden = true
//        self.twoOC.backgroundColor = UIColor(red: 134/255, green: 0/255, blue: 90/255, alpha: 1)
//        self.twoOC.setTitleColor(.white, for: .normal)
//        self.oneAC.backgroundColor = .lightGray
//        self.oneAC.setTitleColor(.black, for: .normal)
//        self.threeOC.backgroundColor = .lightGray
//        self.threeOC.setTitleColor(.black, for: .normal)
    }
    func setParameters(str:Int) -> [String:Any]{
        var params = [String:Any]()
        params["step"] = str
        switch str {
        case 1:
         
            if isSwitchOn {
                params["height_type"] = "inches"
            }
            else {
                params["height_type"] = "cm"
            }
           
            params["height"] = self.distance
            return params
        case 2:
            params["good_looking"] = self.distance
            return params
        case 3:
            params["kids"] = false
            params["kids_in_future"] = "2"
            return params
            
        case 4:
            params["my_health"] = self.distance
            return params
        case 5:
            params["other_health"] = self.distance
            return params
            
        case 6 :
          
                params["relevant"] = getReleventArray()
                return params
            
        case 7:
           
                params["my_qualities"] = getQualityArray()
                return params
            
           
        case 8:
            
                params["other_qualities"] = getQualityArray()
                return params
            
        case 9:
            
            params["personality"] = self.personalityValue + 1
                return params
            
        case 10:
            
            params["interested_fact"] = self.personalityValue + 1
                return params
            
            
        case 11:
            
            params["decision"] = self.personalityValue + 1
                return params
            
        case 12:
            
            params["prefer_clarity"] = self.personalityValue + 1
                return params
            
           
        default:
            return params
        }
      
    }
    
    
    func hitSurvey(param:[String:Any]){
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForCompleteSurvey(param, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                self.currentValue = self.currentValue + 1
                self.setUIView(caseValue: self.currentValue)
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
    
    
    
    func getReleventArray() -> [Int]{
        var amountArray = [Int]()
     
    
        for amount in relevantSelectedIndexArray {
            let amtStr = amount + 1
            amountArray.append(amtStr)
        }
        
        return amountArray
    }
    func getQualityArray() -> [Int]{
        var amountArray = [Int]()
     
    
        for amount in selectedQualitiesArray {
            let amtStr = amount + 1
            amountArray.append(amtStr)
        }
        
        return amountArray
    }
    func getOtherQualityArray() -> [Int]{
        var amountArray = [Int]()
     
    
        for amount in otherPersonQualities {
            let amtStr = amount + 1
            amountArray.append(amtStr)
        }
        
        return amountArray
    }
}


extension UILabel{
    var defaultFont: UIFont? {
        get { return self.font }
        set { self.font = newValue }
    }
}
extension SurveyVC {
    func vehicleHeightSliderValueChanged(_ slider: UISlider) {

           let currentValue = Int(slider.value)

           let heightMeters = Measurement(value: Double(currentValue), unit: UnitLength.meters)
//           let heightFeet = heightMeters.converted(to: UnitLength.feet)

           let heightCentimeters = heightMeters.converted(to: UnitLength.centimeters)
           let heightInches = heightMeters.converted(to: UnitLength.inches)


        if isSwitchOn {
            self.lbl_Distance.setTitle("\(heightInches) inches", for: .normal)
        }
        else {
            self.lbl_Distance.setTitle("\(heightCentimeters) inches", for: .normal)
        }
          
       }
}
