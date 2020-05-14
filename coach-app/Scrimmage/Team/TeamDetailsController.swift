//
//  TeamDetailsController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/13/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class TeamDetailsController: AbstractViewController {
    
    @IBOutlet weak var coachLabel: UILabel!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var breakLine: UIView!
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamHistory: UILabel!
    @IBOutlet weak var teamRate: UILabel!
    @IBOutlet weak var teamDescription: UILabel!
    @IBOutlet weak var teamDistance: UILabel!
    @IBOutlet weak var teamZipCode: UILabel!
    @IBOutlet weak var hasHomeField: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBAction func buttonClicked(_ sender: Any) {
        connectToTeam(team_id: (team?.id)!)
    }
    
    
    var team:Team?
    
    let dataManager = DataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        //z order of UIImage and labels
        teamImage.layer.zPosition = -100
        teamLogo.layer.zPosition = 100
        teamNameLabel.layer.zPosition = 100
        teamRate.layer.zPosition = 100
        teamHistory.layer.zPosition = 100
        //uiimage
        teamLogo.setRounded()
        //colors
        breakLine.backgroundColor = UIColor.coachGrey()
        buttonContainer.backgroundColor = UIColor.coachGrey()
        buttonOutlet.backgroundColor = UIColor.coachGreen()
        //border of button container
        buttonContainer.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            buttonContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        
        //Fill data
        teamImage.downloadedFrom(link: team!.team_image!)
        teamLogo.downloadedFrom(link: team!.team_logo!)
        teamNameLabel.text = team!.team_name! + " (" + team!.age_group! + ")"
        let teamDistanceDouble = team?.distance
        coachName.text = team!.coach_name
        teamDistance.text = teamDistanceDouble!.stringWithoutDecimal + " miles"
        teamZipCode.text = team!.team_zip_code ?? " "
        teamDescription.text = team!.team_description
        teamRate.text = team!.team_rate?.toOneDecimal()
        addScrimmageNavBarBack(title: "Team Details")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.gamesHistory(_:)))
        tapGesture.cancelsTouchesInView = false;
        tapGesture.numberOfTapsRequired = 1
        teamHistory.isUserInteractionEnabled = true
        teamHistory.addGestureRecognizer(tapGesture)
    }
    
    func connectToTeam(team_id: String){
        buttonOutlet.startAnimating()
        DispatchQueue.global(qos: .background).async {
            self.dataManager.connectToTeam(id: team_id, completion: { (json) -> Void in
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
    
    @objc func gamesHistory(_ sender: UITapGestureRecognizer) {
        print("clicked")
        let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
        let history = storyBoard.instantiateViewController(withIdentifier: "GamesHistoryController") as! GamesHistoryController
        history.configure()
        history.team_id = team?.id
        self.present(history, animated: true)
    }

    

}
