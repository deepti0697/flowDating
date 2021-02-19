//
//  FilterCollectionViewCell.swift
//  FORSA
//
//  Created by apple on 21/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImageView: UIImageView!
    @IBAction func buttonACtion(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
  
    @IBOutlet weak var lblSubject: UILabel!
}
