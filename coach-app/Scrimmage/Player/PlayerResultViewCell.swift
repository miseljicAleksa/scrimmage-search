//
//  PlayerResultViewCell.swift
//  Scrimmage Search
//
//  Created by alk msljc on 3/17/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class PlayerResultViewCell: UITableViewCell {

    @IBOutlet weak var playerBirth: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerInterest: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
        playerImage.setRounded()
        
       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
