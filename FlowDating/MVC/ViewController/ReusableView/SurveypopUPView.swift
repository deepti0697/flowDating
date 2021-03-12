//
//  SurveypopUPView.swift
//  FlowDating
//
//  Created by deepti on 12/03/21.
//

import Foundation
import UIKit
class SurveypopUPView: UIView {
    var closeButtonClouser: (() -> Void) = { }
    override func awakeFromNib() {
        super.awakeFromNib()
//        setupUI()
    }
    @IBAction func closeBtnAction(_ sender: Any) {
        closeButtonClouser()
    }
}
