

import UIKit

class GamesHistoryViewCell: UITableViewCell {

    
    @IBOutlet weak var gamesDateOutlet: UILabel!
    @IBOutlet weak var vsTeamOutlet: UILabel!
    @IBOutlet weak var gameRateOutlet: UILabel!
    
    
    override func awakeFromNib() {
           super.awakeFromNib()
        

       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

