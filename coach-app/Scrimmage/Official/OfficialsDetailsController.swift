//
//  OfficialsDetailsController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/19/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class OfficialsDetailsController: AbstractViewController {

    @IBOutlet weak var officialRating: UILabel!
    @IBOutlet weak var buttonContainerOutlet: UIView!
    @IBOutlet weak var officialImage: UIImageView!
    @IBOutlet weak var officialDescription: UILabel!
    @IBOutlet weak var officialDistance: UILabel!
    @IBOutlet weak var officialCertification: UILabel!
    @IBOutlet weak var officialExperience: UILabel!
    @IBOutlet weak var officialFee: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet var coachGreyColorUIViews: [UIView]!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBOutlet weak var gamesRefereed: UILabel!
    @IBAction func buttonClicked(_ sender: Any) {
        connectToOfficial(official_id: (official?.id)!)
    }
    var official:Official?

    let dataManager = DataManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        for line in coachGreyColorUIViews{
            line.backgroundColor = UIColor.coachGrey()
        }
        
        //Fill data
        nameLabel.text = official?.name
        rateLabel.text = official?.official_rate?.toOneDecimal()
        officialImage.downloadedFrom(link: official!.official_image!)
        officialDescription.text = official?.official_description
        officialDistance.text = (official?.distance!.stringWithoutDecimal)! + " miles"
        officialCertification.text = official?.sertificate
        officialExperience.text = official?.years_of_experience
        officialFee.text = official?.officiating_fee

        
        buttonOutlet.backgroundColor = UIColor.coachGreen()
        
        //nav
        addScrimmageNavBarBack(title: "Official Details")
        //button container
        buttonContainerOutlet.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            buttonContainerOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.gamesHistory(_:)))
        tapGesture.cancelsTouchesInView = false;
        tapGesture.numberOfTapsRequired = 1
        gamesRefereed.isUserInteractionEnabled = true
        gamesRefereed.addGestureRecognizer(tapGesture)
    }
    
    @objc func gamesHistory(_ sender: UITapGestureRecognizer) {
        print("clicked")
        let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
        let history = storyBoard.instantiateViewController(withIdentifier: "GamesHistoryController") as! GamesHistoryController
        history.configure()
        history.official_id = official?.id
        self.present(history, animated: true)
    }


   func connectToOfficial(official_id: String){
       buttonOutlet.startAnimating()
       DispatchQueue.global(qos: .background).async {
           self.dataManager.connectToTeam(id: official_id, completion: { (json) -> Void in
               let status = json["status"]
               DispatchQueue.main.async { () -> Void in
                    if(status == "success"){
                       self.buttonOutlet.stopAnimating()
                       let connectSuccesefull = ConnectToTeamController()
                        connectSuccesefull.message = "Your official request has been sent"
                        connectSuccesefull.subtitle = "WE WILL NOTIFY YOU WHEN THE OFFICIAL HAS CONFIRMED OR DECLINED THE INVITATION"
                       self.present(connectSuccesefull, animated: true)
                    }else{
                        self.buttonOutlet.stopAnimating()
                    }
                }
           })
        }
    }
}
