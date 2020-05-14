//
//  GameDetailsController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 3/20/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class GameDetailsController: AbstractViewController {
    var game:Game?
    let dataManager=DataManager()
    @IBOutlet var breakLines: [UIView]!
    @IBOutlet weak var enterFeeGame: UITextField!
    @IBOutlet weak var feeLabelBig: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var feeContainer: UIView!
    @IBOutlet weak var gameGender: UILabel!
    @IBOutlet weak var gameZipCode: UILabel!
    @IBOutlet weak var gameState: UILabel!
    @IBOutlet weak var gameCity: UILabel!
    @IBOutlet weak var gameAdress: UILabel!
    @IBOutlet weak var gameCoach: UILabel!
    @IBOutlet weak var gameSport: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    
    @IBOutlet weak var gameOpponents: UILabel!
    @IBAction func connectButton(_ sender: Any) {
        connectToGame(game_id: (game?.id)!)

    }
    @IBAction func feeTextLabelDidChange(_ sender: UITextField) {
        feeLabelBig.text = sender.text
    }
    @IBOutlet weak var buttonContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonContainer.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            buttonContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        
    
        gameZipCode.text = game!.zip_code
        gameCity.text = game!.city
        gameState.text = game?.state
        gameSport.text = game!.sport_id
        gameCoach.text = game!.coach_name
        gameAdress.text = game!.address
        gameOpponents.text = game!.team_one! + " vs. " + game!.team_two!
        
        feeContainer.backgroundColor = UIColor.coachGreen()
        feeLabelBig.text = enterFeeGame.text
        
        addScrimmageNavBarBack(title: "Game Details")
        
        feeContainer.layer.cornerRadius = 45
        feeContainer.layer.masksToBounds = true
        buttonContainer.backgroundColor = UIColor.coachGrey()
        buttonOutlet.backgroundColor = UIColor.coachGreen()
        enterFeeGame.delegate = self
        enterFeeGame.addTarget(self, action: #selector(textField), for: .editingChanged)
        

    }
    

   func connectToGame(game_id: String){
       buttonOutlet.startAnimating()
       DispatchQueue.global(qos: .background).async {
           self.dataManager.connectToGame(game_id: game_id, completion: { (json) -> Void in
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
    @objc func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        feeLabelBig.text = enterFeeGame.text! + "$"
        return true
    }
}


