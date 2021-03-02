//
//  InchargeImageCollectionViewCell.swift
//  MSVilla
//
//  Created by uu on 05/01/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class InchargeImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var imgeView: UIImageView!
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.imgeView.contentMode = .scaleAspectFit
        selectedImageView.contentMode = .scaleAspectFit
//        self.imageView.contentMode = UIviewC
        
    }
    func confirgureCell(response:UIImage){
//        if let imageStr = response.image{
//            print(imageStr)
//
//            let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//            let imageUrl = URL(string: urlString ?? "")
//            imgeView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ""), options: .continueInBackground) { (img, err, cacheType, url) in
//            }
//        }
//
    }

}
