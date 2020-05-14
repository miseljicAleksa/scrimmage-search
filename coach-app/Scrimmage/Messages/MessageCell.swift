import UIKit

class MessageCell: UITableViewCell {



    @IBOutlet weak var messageSent: MessageLabel!
    
    @IBOutlet weak var messageDateTime: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
   
       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
