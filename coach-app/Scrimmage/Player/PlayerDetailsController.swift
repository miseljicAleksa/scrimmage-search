//
//  PlayerDetailsController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/19/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class PlayerDetailsController: AbstractViewController {
    var dataManager = DataManager()
    
    @IBOutlet weak var playerMainLabelYear: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerMainLabelName: UILabel!
    @IBOutlet weak var playerInterest: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerExperience: UILabel!
    @IBOutlet weak var playerZipCode: UILabel!
    @IBOutlet weak var playerDescription: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet var coachGreyUIViews: [UIView]!
    @IBOutlet weak var buttonContainer: UIView!
    
    var player:Player?
    
    @IBAction func buttonClicked(_ sender: Any) {
        connectToPlayer(player_id: ((player?.id)!))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let playerBirthStringToDate = player?.date_of_birth!.toDate()
        let playerBirthDateToString = playerBirthStringToDate!.year

         
        playerMainLabelYear.text = "(Born " + playerBirthDateToString + ")"
        
        playerInterest.text = player?.interested_in
        playerName.text = player?.player_name
        playerZipCode.text = player?.zip_code
        playerDescription.text = player?.player_description
        playerExperience.text = player?.years_of_experience
        playerMainLabelName.text = player?.player_name
        playerImage.downloadedFrom(link: player!.player_image!)
        
        buttonOutlet.backgroundColor = UIColor.coachGreen()
        buttonContainer.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            buttonContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        for line in coachGreyUIViews{
            line.backgroundColor = UIColor.coachGrey()
        }
        
        addScrimmageNavBarBack(title: "Player Details")
    }
    
    func connectToPlayer(player_id: String){
        buttonOutlet.startAnimating()
        DispatchQueue.global(qos: .background).async {
            self.dataManager.connectToPlayer(player_id: player_id, completion: { (json) -> Void in
                let status = json["status"]
                DispatchQueue.main.async { () -> Void in
                     if(status == "success"){
                        self.buttonOutlet.stopAnimating()
                        let connectSuccesefull = ConnectToTeamController()
                        self.present(connectSuccesefull, animated: true)
                     }else{
                         self.buttonOutlet.stopAnimating()
                     }
                 }
            })
         }
    }

   

}
