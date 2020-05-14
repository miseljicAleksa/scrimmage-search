//
//  GameResultViewCell.swift
//  Scrimmage Search
//
//  Created by alk msljc on 3/18/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class GameResultViewCell: UITableViewCell {

    @IBOutlet weak var gameAge: UILabel!
    @IBOutlet weak var gameTeams: UILabel!
    @IBOutlet weak var gameTime: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    override func awakeFromNib() {
              super.awakeFromNib()
        gameImage.setRounded()
          }
       
       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

           // Configure the view for the selected state
       }


}
