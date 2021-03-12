//
//  InchargeImageCollectionViewCell.swift
//  MSVilla
//
//  Created by uu on 05/01/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import SDWebImage
class InchargeImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var crossImageView: UIImageView!
    @IBOutlet weak var hiddenImageView: UIImageView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var imgeView: UIImageView!
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.imgeView.contentMode = .scaleToFill
        selectedImageView.contentMode = .scaleToFill
//        self.imageView.contentMode = UIviewC
        
    }
    func confirgureCell(response:AllPhotos){
        self.selectedImageView.isHidden = false
        
        if let imageStr = response.name{
            print(imageStr)
            
            let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imageUrl = URL(string: urlString ?? "")
            selectedImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ""), options: .continueInBackground) { (img, err, cacheType, url) in
            }
        }
//
    }

}
