//
//  CandidateDetailsVC.swift
//  Union
//
//  Created by surendra on 04/06/20.
//  Copyright © 2020 Union. All rights reserved.
//

import UIKit
import TapCardView
import SDWebImage
class CandidateDetailsVC: UIViewController {
    
    @IBOutlet weak var tinderCardView: UIView!
//    @IBOutlet weak var totalMatchLbl: UILabel!
//    @IBOutlet weak var aboutMeLbl: UILabel!
//    @IBOutlet weak var horoScopeLbl: UILabel!
//    @IBOutlet weak var distanceLbl: UILabel!
//    @IBOutlet weak var userNameLbl: UILabel!
    //    @IBOutlet weak var likeButtonView: UIView!
  //  @IBOutlet weak var public_collection: UICollectionView!
  //  @IBOutlet weak var private_collection: UICollectionView!
//    @IBOutlet weak var scrollView: UIScrollView!
   
    @IBOutlet weak var viewbottom: UIView!
//    @IBOutlet weak var btnLike: UIButton!
    var typefav:String = ""
    var image = [#imageLiteral(resourceName: "Image -31"),#imageLiteral(resourceName: "Image -18")]
//    @IBOutlet weak var pagecontrol: UIPageControl!
    var slides:[ImageViewPage] = []
    var personUserid : Int = 0
    var userDetail =  AllUserData()
//    var user : UserModel = UserModel()
    var person_name = ""
    var cellcount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let numberOfPage = userDetail.photos.count
        var images: [UIImage] = []
        for index in  0..<numberOfPage {
            if let imageStr =  userDetail.photos[index].name{
                     print(imageStr)
                     let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                     let imageUrl = URL(string: urlString ?? "")
                 
                        let data = try? Data(contentsOf: imageUrl!)

                          let image: UIImage = UIImage(data: data!)!
                print(image)
                images.append(image)

                          
//                image.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ""), options: .continueInBackground) { (img, err, cacheType, url) in
//                     }
               
                 }
          
         
        }
        
        let frame = CGRect(x: 0, y: 0, width: self.tinderCardView.frame.size.width, height: self.tinderCardView.frame.size.height)
        
        let card = CustomTapCardView(frame: frame, datas: images)
        card.delegate = self

//        card.center = tinderCardView.center
        card.layer.cornerRadius = 8.0
        card.clipsToBounds = true
        self.tinderCardView.addSubview(card)
      
        self.modalPresentationStyle = .fullScreen
     
//        likeButtonView.isHidden = true
        
        
//        pagecontrol.numberOfPages = image.count
//        pagecontrol.currentPage = 0
//        self.btnLike.isSelected = false
     
        // view.bringSubviewToFront(pagecontrol)
        // Do any additional setup after loading the view.
    }
    
    func setup(){
////        self.nam
//        self.userNameLbl.text = self.userDetail.name
//        self.aboutMeLbl.text = self.userDetail.about
//        self.totalMatchLbl.text = self.userDetail
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionMenu(_ sender: Any) {
        
    }
    
    @IBAction func actionBack(_ sender: Any) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func actionChat(_ sender: Any) {
      
    }
    
    func createSlides() -> [ImageViewPage] {
        //let Array : <Array>
        var arr : [ImageViewPage] = []
        for ( item)  in image {
            
            let slide1:ImageViewPage = Bundle.main.loadNibNamed("ImageViewPage", owner: self, options: nil)?.first as! ImageViewPage
            slide1.img.image = item
            slide1.img.contentMode = .scaleToFill
            slide1.tag = 1
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            tap.numberOfTapsRequired = 1
            slide1.isUserInteractionEnabled = true
            slide1.addGestureRecognizer(tap)
            arr.append(slide1)
        }
        
        
        //      let slide2:ImageViewPage = Bundle.main.loadNibNamed("ImageViewPage", owner: self, options: nil)?.first     as! ImageViewPage
        //      slide2.img .sd_setImage(with: URL.init(string: user.image ?? ""), completed: nil)
        
        return arr
    }
   @objc func handleTap(_ sender: UITapGestureRecognizer) {
//        guard let getTag = sender.view?.tag else { return }
//       let dic = user.public_photo[getTag] as! NSDictionary
//
//    let storyboard = UIStoryboard(name: "TabStoryboard", bundle: nil)
//    let imageView = storyboard.instantiateViewController(withIdentifier: "CommonImageVC") as! CommonImageVC
//    imageView.isModalInPresentation = true
//    imageView.imagUrl = dic["image"] as? String ?? ""
//    self.present(imageView, animated: true, completion: nil)
//       print("getTag == \(getTag)")
   }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.slides = self.createSlides()
//        self.setupSlideScrollView(slides: self.slides)
        self.navigationController?.navigationBar.isHidden  = true
    }
    
    @IBAction func actionUnfav(_ sender: Any) {
        //        let currentuser = getUser()
        //               if personUserid == currentuser.id{
        //                   return
        //               }
        //        typefav = "unfavourite"
        
       
    }
    @IBAction func actionFav(_ sender: Any) {
      
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.viewbottom.frame
        rectShape.position = self.viewbottom.center
        rectShape.path = UIBezierPath(roundedRect: self.viewbottom.bounds, byRoundingCorners: [.topRight ,.topLeft], cornerRadii: CGSize(width: 45, height: 45)).cgPath
        
        
        self.viewbottom.layer.mask = rectShape
        
        
    }
    
    
    // MARK: - TABLEVIEW
  
    
    
//    // MARK: - collectionview
//    func collectionView(_ collectionView: UICollectionView,
//                        numberOfItemsInSection section: Int) -> Int {
//        switch collectionView {
//        case public_collection:
//            return user.public_photo.count
//        case private_collection:
//            return user.public_photo.count
//        default:
//            return 0
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        switch collectionView {
//        case public_collection:
//            let cell =
//                collectionView.dequeueReusableCell(withReuseIdentifier:
//                    "detailCell", for: indexPath) as! ButtonCell
//            let  dict = user.public_photo[indexPath.row] as! NSDictionary
//            cell.img .sd_setImage(with: URL.init(string:dict["image"] as? String ?? ""), completed: nil)
//            return cell
//        case private_collection:
//            let cell =
//                collectionView.dequeueReusableCell(withReuseIdentifier:
//                    "detailCell", for: indexPath) as! ButtonCell
//            let  dict = user.private_photo[indexPath.row] as! NSDictionary
//            cell.img .sd_setImage(with: URL.init(string:dict["image"] as? String ?? ""), completed: nil)
//            return cell
//        default:
//            return UICollectionViewCell()
//        }
//    }
    
    
    // MARK : - API call
}
extension CandidateDetailsVC:CardViewDelegate {
    func tapPosition(type: TapPosition, sender: TapCardView) {
        print(type)
        
        switch type {
        case .left:
          break
        case .right:
          break
        case .bottom:
          break
        }
    }
    
    
}
