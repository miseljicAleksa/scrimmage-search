//
//  CoachDetailsController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/19/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class CoachDetailsController: AbstractViewController {
    var dataManager = DataManager()

    @IBOutlet weak var coachDescription: UILabel!
    @IBOutlet weak var coachTeamName: UILabel!
    @IBOutlet weak var coachZipCode: UILabel!
    @IBOutlet weak var coachAge: UILabel!
    @IBOutlet weak var coachGender: UILabel!
    @IBOutlet var coachGreyUIViews: [UIView]!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBAction func buttonClicked(_ sender: Any) {
        getCoachDetails(id: "1")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        for line in coachGreyUIViews{
            line.backgroundColor = UIColor.coachGrey()
        }
    }
    

    func getCoachDetails(id: String){
        buttonOutlet.startAnimating()
    
    
        DispatchQueue.global(qos: .background).async {
            self.dataManager.getTeamDetails(id: id,
                completion: { (json) -> Void in
                
                let status = json["status"]
                let message = json["message"]
                if(status == "success"){
                  
                    //Go next
                    DispatchQueue.main.async(execute: {
                        print(123)
                        self.buttonOutlet.stopAnimating()
                        
                    })
                }else{
                   
                    DispatchQueue.main.async(execute: {
                        self.buttonOutlet.stopAnimating()
                        if(message == "0")
                        {
                            // Display alert message
                            self.alert(msg: "The email has been already registered. Please go to login or use another one".localized)
                        }else
                        {
                            // Display alert message
                            self.alert(msg: "Unable to save, please try later".localized)
                        }
                    })
                }
        })
        }
    }

}
