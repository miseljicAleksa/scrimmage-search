//
//  RateGameController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 3/25/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class RateGameController: AbstractViewController {

    @IBOutlet weak var gameDate: UILabel!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet var breakLines: [UIView]!
    
    @IBAction func sendFeedbackClicked(_ sender: Any) {
    }
    @IBAction func submitRatingClicked(_ sender: Any) {
        rateGame(game_id: "1", rate: rate_game)
    }
    @IBOutlet weak var submitRatingOutlet: UIButton!
    @IBOutlet weak var sendFeedbackOutlet: UIButton!
    @IBOutlet var rateDesign: [Custom_Segmented_Control]!
    @IBOutlet weak var gameRate: Custom_Segmented_Control!
    @IBOutlet weak var officialRate: Custom_Segmented_Control!
    @IBOutlet weak var sportmanshipRate: Custom_Segmented_Control!
    override func viewDidLoad() {
        super.viewDidLoad()
        for rD in rateDesign{
            rD.backgroundColor = UIColor.coachGrey()
            rD.selector_color = UIColor.coachGreen()
        }
        
        for line in breakLines{
            line.backgroundColor = UIColor.coachGrey()
        }
        
        buttonContainer.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            buttonContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        submitRatingOutlet.backgroundColor = UIColor.coachGreen()
        sendFeedbackOutlet.setTitleColor(UIColor.coachGreen(), for: .normal)
        addScrimmageNavBarBack(title: "Rate Game")
    }
    var rate_game:String="1"
    @IBAction func rateGameAction(_ sender:Custom_Segmented_Control) {
        switch sender.selected_button_idex {
        case 1:
            rate_game = "1"
        case 2:
            rate_game = "2"
        case 3:
            rate_game = "3"
        case 4:
            rate_game = "4"
        case 5:
            rate_game = "5"
        default:
            rate_game = "1"
        }
    }
    
    var rate_official:String="1"
    @IBAction func officialRateAction(_ sender: Custom_Segmented_Control) {
       switch sender.selected_button_idex {
        case 1:
            rate_official = "1"
        case 2:
            rate_official = "2"
        case 3:
            rate_official = "3"
        case 4:
            rate_official = "4"
        case 5:
            rate_official = "5"
        default:
            rate_official = "1"
        }
    }
    
    var rate_sportmanship:String="1"
    @IBAction func sportmanshipRateAction(_ sender: Custom_Segmented_Control) {
        switch sender.selected_button_idex {
        case 1:
            rate_sportmanship = "1"
        case 2:
            rate_sportmanship = "2"
        case 3:
            rate_sportmanship = "3"
        case 4:
            rate_sportmanship = "4"
        case 5:
            rate_sportmanship = "5"
        default:
            rate_sportmanship = "1"
        }
    }
    
    var dm = DataManager()
    
    func rateGame(game_id: String, rate: String){
        submitRatingOutlet.startAnimating()
        dm.rateGame(game_id: game_id, rate: rate) { (json) in
                DispatchQueue.main.async(execute: {
                        let status = json["status"]
                        //Success
                        if(status == "success"){
                            
                        
                            let result = json["result"]
                            
                            print("USPESNO SI REJTOVO GAME")
                            self.submitRatingOutlet.stopAnimating()
                            
                        }else{
                            //Api Error
                            // Display alert message
                            self.alert(msg: "Error getting search results".localized)
                        }
                        self.submitRatingOutlet.stopAnimating()
                    })
        
        }
    }
}

