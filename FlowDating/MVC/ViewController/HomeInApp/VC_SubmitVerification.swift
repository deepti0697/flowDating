//
//  VC_SubmitVerification.swift
//  SugarOrDate
//
//  Created by Diwakar Tak on 30/11/20.
//  Copyright © 2020 Sunil Pradhan. All rights reserved.
//

import UIKit
import Foundation
import Alamofire


class VC_SubmitVerification: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var baseView2: UIView!
    @IBOutlet var lbl_Title: UILabel!
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var btn_Submit: GradientButton!
    @IBOutlet var btn_retake: UIButton!
    
    @IBOutlet var img1: UIImageView!
    @IBOutlet var img2: UIImageView!
    @IBOutlet var img3: UIImageView!
    
    var verification1 = true
    var selectedImage = UIImage()
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.baseView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        self.baseView2.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func uiLoad(){

        btn_retake.layer.borderColor = UIColor.lightGray.cgColor
        if verification1{
            img1.isHidden = false
            img2.isHidden = true
            img3.isHidden = true

            lbl1.text = "Copy This Gesture"
            lbl2.text = "Copy the gesture in the photo below. We'll compare them and if they match your profile will be verified and you can continue using SugarOrDate as normal."
            btn_retake.isHidden = true
            btn_Submit.setTitle("I'm ready", for: .normal)

        }else{
            img1.isHidden = true
            img2.isHidden = false
            img3.isHidden = false
            lbl1.text = "Do they match?"
            lbl2.text = "If your photo looks like the sample then submit it for verification.it should only take a minute or two for the results."
            btn_retake.isHidden = false
            btn_Submit.setTitle("Submit", for: .normal)

        }
        
        
    }
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Submit(_ sender: UIButton) {
        if verification1{
            clickPicture()
        }else{
          apiCallUploadPicture()
        }
    }
    
    func clickPicture(){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    //MARK: - Done image capture here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        verification1 = false
        uiLoad()
        selectedImage = (info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage)!
        img3.image = selectedImage
        
    }

    @IBAction func btn_retake(_ sender: Any) {
        verification1 = true

    }
    
}
//MARK:- api calling methods

extension VC_SubmitVerification{
    // move this api to sign up screen
    
    func apiCallUploadPicture(){
        
    }
}
