//
//  CompleteProfile2VC.swift
//  FlowDating
//
//  Created by deepti on 27/01/21.
//

import UIKit

class CompleteProfile2VC: UIViewController {
    @IBOutlet weak var baseview2: UIView!
  
    
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var bothBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()

           // Call the roundCorners() func right there.
     
        self.baseview2.roundCorners(corners: [.topLeft, .topRight], radius: 30)
       }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func bothAction(_ sender: Any) {
        bothBtn.setImage(#imageLiteral(resourceName: "man-3"), for: .normal)
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
//        sender.selectedbtn()
        sender.setImage(#imageLiteral(resourceName: "man-3"), for: .normal)
        femaleBtn.setImage(#imageLiteral(resourceName: "woman"), for: .normal)
        sender.setTitleColor(UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1), for: .normal)
        sender.layer.borderColor = UIColor(red: 168/255, green: 0/255, blue: 255/255, alpha: 1).cgColor
        femaleBtn.layer.borderColor = UIColor.lightGray.cgColor
        femaleBtn.setTitleColor(.lightGray, for: .normal)
        bothBtn.layer.borderColor = UIColor.lightGray.cgColor
        bothBtn.setTitleColor(.lightGray, for: .normal)
        bothBtn.setImage(#imageLiteral(resourceName: "woman"), for: .normal)
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
        bothBtn.layer.borderColor = UIColor.lightGray.cgColor
        bothBtn.setTitleColor(.lightGray, for: .normal)
        bothBtn.setImage(#imageLiteral(resourceName: "woman"), for: .normal)
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

}
