//
//  DetailsCell.swift
//  Union
//
//  Created by surendra on 04/06/20.
//  Copyright © 2020 Union. All rights reserved.
//

import UIKit
//import ZMSwiftRangeSlider

class DetailsCell: UITableViewCell {

  
   
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    
//    @IBOutlet weak var rangeslideer: RangeSlider!
//
//    @IBOutlet weak var lbl_5_height: NSLayoutConstraint!
//    @IBOutlet weak var lbl4_height: NSLayoutConstraint!
//    @IBOutlet weak var view1: UIView!
//    @IBOutlet weak var lbl5: UILabel!
//    @IBOutlet weak var lbl4: UILabel!
//    @IBOutlet weak var lbl3: UILabel!
//    @IBOutlet weak var lbl2: UILabel!
//    @IBOutlet weak var lblNew: UILabel!
//    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblcount: UILabel!
//    @IBOutlet weak var chatView: UIView!
//    @IBOutlet weak var btn2: UIButton!
//    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
//    @IBOutlet weak var img1: UIImageView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       //rangeslideer.setMinAndMaxValue(0, maxValue: 100)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
