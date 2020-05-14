//
//  ScrimmageViewCell.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/13/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class ScrimmageViewCell: UITableViewCell {

    @IBOutlet weak var notficationImageView: UIImageView!
    @IBOutlet weak var notificationMessageLabel: UILabel!
    @IBOutlet weak var notificationTimeLabel: UILabel!
    
    
     override func awakeFromNib() {
           super.awakeFromNib()
        notificationTimeLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        notificationTimeLabel.textColor = UIColor.lightGray
        notificationMessageLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        

       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
