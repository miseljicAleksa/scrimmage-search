//
//  CoachExperienceController.swift
//  Scrimmage Search
//
//  Created by Arsen Leontijevic on 08/02/2020.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class CoachExperienceController: AbstractAccountController {

    var dataManager: DataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set back button
        self.SetBackBarButtonCustom()
        self.view.backgroundColor = UIColor.coachGrey()
       //style
        stepsUIView1.backgroundColor = UIColor.coachGreen()
        stepsUIView2.backgroundColor = UIColor.coachGreen()
        breakUIView1.backgroundColor = UIColor.coachGrey()
        breakUIView2.backgroundColor = UIColor.coachGrey()
        breakUIView3.backgroundColor = UIColor.coachGrey()
        breakUIView4.backgroundColor = UIColor.coachGrey()
        breakUIView5.backgroundColor = UIColor.coachGrey()
        breakUIView6.backgroundColor = UIColor.coachGrey()
        saveButton.backgroundColor = UIColor.coachGreen()
        containerOfSaveButton.backgroundColor = UIColor.coachGrey()
        stepsUIView1.isUserInteractionEnabled = false
        stepsUIView2.isUserInteractionEnabled = false
        //container
        containerOfSaveButton.layer.cornerRadius = 40
               if #available(iOS 11.0, *) {
                   containerOfSaveButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
               } else {
                   // Fallback on earlier versions
               }
        
    }
    

    @IBOutlet weak var stepsUIView1: UIButton!
    @IBOutlet weak var stepsUIView2: UIButton!
    @IBOutlet weak var breakUIView1: UIView!
    @IBOutlet weak var breakUIView2: UIView!
    @IBOutlet weak var breakUIView3: UIView!
    @IBOutlet weak var breakUIView4: UIView!
    @IBOutlet weak var breakUIView5: UIView!
    @IBOutlet weak var breakUIView6: UIView!
    @IBOutlet weak var coachXPtextField1: UITextField!
    @IBOutlet weak var coachXPtextField2: UITextField!
    @IBOutlet weak var sessionPlanTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var containerOfSaveButton: UIView!
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let experience_1 = coachXPtextField1.text
        let experience_2 = coachXPtextField2.text
        let session_plan = sessionPlanTextField.text
        
        // Check for empty field
        if(experience_1!.isEmpty || experience_2!.isEmpty || session_plan!.isEmpty ) {
            // Display alert message
            self.alert(msg: "All fields are required!".localized)
            return
        }
        
        
        return setCoachExperienceProfile(experience_1: experience_1!, experience_2: experience_2!, session_plan: session_plan!)
    }
    
    
    func setCoachExperienceProfile(experience_1:String, experience_2:String, session_plan:String){
            saveButton.startAnimating()
        
            DispatchQueue.global(qos: .background).async {
                self.dataManager.setCoachExperience(experience_1: experience_1, experience_2: experience_2, session_plan : session_plan,
                    completion: { (json) -> Void in
                    
                    let status = json["status"]
                    let result = json["result"]
                    let message = json["message"]
                    print(status, result, message)
                    if(status == "success"){
                        
                        //Go next
                        DispatchQueue.main.async(execute: {
                            self.saveButton.stopAnimating()
                            UserDefaults.standard.removeObject(forKey: "profile_type")
                            self.pushController(id: "WelcomeController")
                        })
                    }else{
                       
                        DispatchQueue.main.async(execute: {
                            self.saveButton.stopAnimating()
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
