//
//  MatchesTableViewCell.swift
//  FlowDating
//
//  Created by deepti on 28/01/21.
//

import UIKit
import SDWebImage
class MatchesTableViewCell: UITableViewCell {

    @IBOutlet weak var compatibilityLbl: UILabel!
    @IBOutlet weak var aboutMeLbl: UILabel!
    @IBOutlet weak var zodiacSignLbl: UILabel!
    @IBOutlet weak var userDistanceLbl: UILabel!
    @IBOutlet weak var userNamelbl: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(user:AllUserData) {
        if let imageStr = user.profile_pic{
            print(imageStr)
           
            let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imageUrl = URL(string: urlString ?? "")
            userProfileImageView.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Image -31"), options: .continueInBackground) { (img, err, cacheType, url) in
            }
        }
        self.userNamelbl.text = user.name
        self.userDistanceLbl.text = "\(user.miles ?? "") miles away"
        self.zodiacSignLbl.text = user.zodiac_sign
        self.aboutMeLbl.text = user.about
        self.compatibilityLbl.text = "\(user.compatibility ?? "") matched"
        
    }

}
