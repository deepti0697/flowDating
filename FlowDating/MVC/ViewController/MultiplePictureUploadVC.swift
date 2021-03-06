//
//  ComplaintViewController.swift
//  MSVilla
//
//  Created by apple on 04/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import SwiftyJSON
import AVFoundation

class MultiplePictureUploadVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var isComingFromRegistration = false
    var isArrayImage = true
    var imgcell = InchargeImageCollectionViewCell()
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var baseView2: UIView!
    var imageDatas = [Data]()
    var imageArray = [String]()
    var tempImage :String?
    
    var getDataProfile  = GetUserProfile()
    
    
    var selectedIndex = -1
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Call the roundCorners() func right there.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.baseView2.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    var isComingFromEdit = false
    
    
    func checkCameraPermission(){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = CGSize(width: self.imageCollectionView.frame.width/3.5, height: self.imageCollectionView.frame.width/3.5)
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.scrollDirection = .vertical
        imageCollectionView.collectionViewLayout = collectionLayout
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
    
    @IBAction func btnComplaintAction(_ sender: UIButton) {
        
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func uploadImage3Action(_ sender: Any) {
        //        setImageForComplaint(imageSec: "3")
    }
    @IBAction func uploadImage1Action(_ sender: Any) {
        //        setImageForComplaint(imageSec: "1")
    }
    
    @IBAction func uploadImage2Action(_ sender: Any) {
        //        setImageForComplaint(imageSec: "2")
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            //imgcell.imgeView.image = pickedImage
            
            
            //    let str =   self.convertImageToBase64String(img: pickedImage)
            let imageData = pickedImage.jpegData(compressionQuality: 0.1)! as Data
            imageDatas.append(imageData)
            //    imageArray.append(str)
            self.imageCollectionView.reloadData()
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    fileprivate func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setImageForComplaint(imageSec:String,cel:InchargeImageCollectionViewCell) {
        self.tempImage = imageSec
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveAndContinueAction(_ sender: Any) {
        if getDataProfile.photos.count == 6
        {
//            if self.isComingFromRegistration {
//                self.openViewController(controller: CompleteypuProfileVC4.self, storyBoard: .mainStoryBoard) { (vc) in
//                    vc.profileData = self.getDataProfile
//                }
//            }
//            else {
//                self.navigationController?.popViewController(animated: true)
//            }
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            if imageDatas.count > 0 {
                imageUpload()
                
            }
            else {
                Common.showAlert(alertMessage: "Please upload atleast one image", alertButtons: ["Ok"]) { (bt) in
                }
            }
        }
        
    }
    @IBAction func profileVerificationAction(_ sender: Any) {
        openViewController(controller: VC_SubmitVerification.self, storyBoard: .mainStoryBoard) { (vc) in
            
        }
    }
}



extension MultiplePictureUploadVC : UITextFieldDelegate {
    
    
    func convertImageToBase64String (img: UIImage) -> String {
        let imageData:NSData = img.jpegData(compressionQuality: 0.50)! as NSData //UIImagePNGRepresentation(img)
        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }
    //        for amount in winnerAmountArray {
    //            let amtStr = "\(amount)"
    //            amountArray.append(amtStr)
}

extension MultiplePictureUploadVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "InchargeImageCollectionViewCell", for: indexPath) as! InchargeImageCollectionViewCell
        
        if  indexPath.row  < getDataProfile.photos.count {
            cell.confirgureCell(response: self.getDataProfile.photos[indexPath.row])
            cell.hiddenImageView.isHidden = true
            cell.crossImageView.isHidden = false
            return cell
        }
        else if indexPath.row < getDataProfile.photos.count + imageDatas.count
        {
            cell.hiddenImageView.isHidden = true
            cell.selectedImageView.isHidden = false
            cell.crossImageView.isHidden = false
            cell.selectedImageView.image = UIImage(data: self.imageDatas[indexPath.row - self.getDataProfile.photos.count])
            
            return cell
        }
        else {
            cell.hiddenImageView.isHidden = false
            cell.selectedImageView.isHidden = true
            cell.crossImageView.isHidden = true
            return cell
        }
        
        //            if cell.imgeView.image == #imageLiteral(resourceName: "AddPhoto") {
        
        //                cell.imgeView.image = #imageLiteral(resourceName: "AddPhoto")
        //            }
        
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row - getDataProfile.photos.count
        
        if indexPath.row >=  getDataProfile.photos.count {
            
            if indexPath.row < self.getDataProfile.photos.count + self.imageDatas.count
            {
                self.imageDatas.remove(at: indexPath.row - self.getDataProfile.photos.count)
                self.imageCollectionView.reloadData()
                
            }
            else {
                if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                    imgcell = collectionView.cellForItem(at: indexPath) as! InchargeImageCollectionViewCell
                    //        if imgcell.imgeView.image == #imageLiteral(resourceName: "Union 5")  {
                    setImageForComplaint(imageSec: "1", cel: imgcell)
                } else {
                    AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                        if granted == true {
                            self.imgcell = collectionView.cellForItem(at: indexPath) as! InchargeImageCollectionViewCell
                            //        if imgcell.imgeView.image == #imageLiteral(resourceName: "Union 5")  {
                            self.setImageForComplaint(imageSec: "1", cel: self.imgcell)
                        } else {
                            DispatchQueue.main.async {
                                let alert = UIAlertController(title: "Camera Services are disabled", message: "Please enable Location Services in your Settings", preferredStyle: .alert)
                                //                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                        return
                                    }
                                    
                                    if UIApplication.shared.canOpenURL(settingsUrl) {
                                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                            print("Settings opened: \(success)") // Prints true
                                        })
                                    }
                                })))
                                self.present(alert, animated: true, completion: nil)
                            }
                            
                        }
                    })
                }
            }
        }
        else if indexPath.row > self.getDataProfile.photos.count + self.imageDatas.count
        {
            self.imageDatas.remove(at: indexPath.row - self.getDataProfile.photos.count)
            self.imageCollectionView.reloadData()
            
        }
        else
        {
            deleteImage(id: getDataProfile.photos[indexPath.row].id)
        }
        
        
        //        }
        
        
    }
    func imageUpload(){
        let params =  [String : Any]()
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceMultipleImage(params, data: imageDatas, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                Common.showAlert(alertMessage: parseData["message"].stringValue, alertButtons: ["Ok"]) { (bt) in
                    if self.isComingFromRegistration {
                        self.openViewController(controller: CompleteypuProfileVC4.self, storyBoard: .mainStoryBoard) { (vc) in
                            vc.profileData = self.getDataProfile
                        }
                    }
                    else {
                        self.navigationController?.popViewController(animated: true)
                    }
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
    func deleteImage(id:String){
        var params =  [String : Any]()
        params["id"] = id
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServicedeleteImage(params, data: imageDatas, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                //
                for i in 0..<self.getDataProfile.photos.count {
                    if self.getDataProfile.photos[i].id == id {
                        self.getDataProfile.photos.remove(at: i)
                        
                        break
                        //                        return
                    }
                    
                }
                self.imageCollectionView.reloadData()
                //                self.getDataProfile.photos = self.getDataProfile.photos.filter{ $0.user_id != id}
                
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

