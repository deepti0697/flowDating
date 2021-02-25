//
//  TinderbottomView.swift
//  Union
//
//  Created by Ravi on 31/05/20.
//  Copyright © 2020 Union. All rights reserved.
//

import UIKit

class TinderbottomView: UIView {

    @IBOutlet weak var horoScopeLbl: UILabel!
    
    @IBOutlet weak var matchPercentage: UILabel!
    @IBOutlet weak var isVerified: UIImageView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var nmPerson: UILabel!
    override  func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 14.0, *) {
            pageControl.backgroundStyle = .minimal
        } else {
            // Fallback on earlier versions
        }
    }
   
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
