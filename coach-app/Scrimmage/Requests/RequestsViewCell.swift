//
//  RequestsViewCell.swift
//  Scrimmage Search
//
//  Created by Arsen Leontijevic on 16/04/2020.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class RequestsViewCell: UITableViewCell {


    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var fromNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
            let mScreenSize = UIScreen.main.bounds
            let mSeparatorHeight = CGFloat(3.0) // Change height of speatator as you want
            let mAddSeparator = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height - mSeparatorHeight, width: mScreenSize.width, height: mSeparatorHeight))
            mAddSeparator.backgroundColor = UIColor.coachGrey() // Change backgroundColor of separator
            self.addSubview(mAddSeparator)
   
       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
