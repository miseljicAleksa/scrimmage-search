//
//  ScrimmageViewCell.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/13/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class OfficialResultViewCell: UITableViewCell {

    
    @IBOutlet weak var officialNameLabel: UILabel!
    @IBOutlet weak var officialCertificationLabel: UILabel!
    @IBOutlet weak var officialGameFeeLabel: UILabel!
    @IBOutlet weak var officialImageOutlet: UIImageView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
        

       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
