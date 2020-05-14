//
//  ScrimmageViewCell.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/13/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class TeamResultViewCell: UITableViewCell {

    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamRating: UILabel!
    @IBOutlet weak var teamZipCode: UILabel!
    @IBOutlet weak var teamDistance: UILabel!
    @IBOutlet weak var teamName: UILabel!
    
    
    override func awakeFromNib() {
           super.awakeFromNib()
        teamImage.setRounded()

       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
