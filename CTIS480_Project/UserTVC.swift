//
//  UserTVC.swift
//  CTIS480_Project
//
//  Created by Yusuf Çiftci on 27.12.2022.
//

import UIKit

class UserTVC: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var userView: UIView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
