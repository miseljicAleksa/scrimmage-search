//
//  PlayerProfileController.swift
//  coach-app
//
//  Created by alk msljc on 1/15/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class PlayerProfileController: AbstractAccountController, UIAdaptivePresentationControllerDelegate {

    //outlets

    @IBOutlet weak var playerDescription: UITextField!
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var yearsOfExperienceTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveProfileButtonOutlet: UIButton!
    @IBOutlet weak var personalInfoBottomLineView: UIView!
    @IBOutlet weak var milesRadiusBottomLineView: UIView!
    @IBOutlet weak var playerDescriptionTopLineView: UIView!
    @IBOutlet weak var playerDescriptionBottomLineView: UIView!
    @IBOutlet weak var backgroundOfNextButtonVIew: UIView!
    @IBOutlet weak var personalInfoSectionBottomLineView: UIView!
    @IBOutlet weak var milesRadiusTopLineView: UIView!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    var imagePicker: ImagePicker!

    @IBAction func uploadPlayerProfilePicture(_ sender: UIButton) {
        sender.tag = 1
         self.imagePicker.present(from: sender)
    }
    @IBOutlet weak var milesRadiusSlider: UISlider!
    @IBOutlet weak var interestedInTextField: UITextField!
    
    @IBAction func saveProfileButton(_ sender: UIButton) {
        //pushController(id: "WelcomeController")
        let player_image = profilePhotoImageView.image?.resizeImage(100)!.toBase64()
        let years_of_experience = yearsOfExperienceTextField.text
        let team_name = teamNameTextField.text
        let interested_in = interestedInTextField.text
        let player_description = playerDescription.text
        let miles_radius = milesLabel.text


                    // Check for empty field
        if(player_description!.isEmpty || years_of_experience!.isEmpty || team_name!.isEmpty || miles_radius!.isEmpty) {
                        // Display alert message
                        self.alert(msg: "All fields are required!".localized)
                        return
                    }
                    return
                        setPlayerProfile(player_image: player_image!, years_of_experience: years_of_experience!, team_name: team_name!,interested_in: interested_in!, player_description: player_description!, miles_radius: miles_radius!)
                                
            
            
        
    }
    @IBOutlet weak var milesLabel: UILabel!
    //actions
    @IBAction func milesChanged(_ sender: UISlider) {
        let intMiles = Int(sender.value.rounded())
        let milesValue = String(intMiles)
        
        milesLabel.text = String(milesValue + " miles")
        
    }
    
    @IBAction func arrowDownForIntrest(_ sender: Any) {
        showPopUpForInterest()
    }
    let interestPickerData = ["Kind of games:": ["Pick Up Games", "Tournamets", "Seazons"]]
    
    let dataManager: DataManager = DataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        interestedInTextField.delegate = self
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        //style
        // remove left buttons (in case you added some)
         self.navigationItem.leftBarButtonItems = []
        // hide the default back buttons
         self.navigationItem.hidesBackButton = true
        saveProfileButtonOutlet.backgroundColor = UIColor.coachGreen()
        personalInfoBottomLineView.backgroundColor = UIColor.coachGrey()
        personalInfoSectionBottomLineView.backgroundColor = UIColor.coachGrey()
        milesRadiusTopLineView.backgroundColor = UIColor.coachGrey()
        milesRadiusBottomLineView.backgroundColor = UIColor.coachGrey()
        playerDescriptionTopLineView.backgroundColor = UIColor.coachGrey()
        playerDescriptionBottomLineView.backgroundColor = UIColor.coachGrey()
        
        backgroundOfNextButtonVIew.backgroundColor = UIColor.coachGrey()
        backgroundOfNextButtonVIew.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            backgroundOfNextButtonVIew.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        interestedInTextField.addTarget(self, action: #selector(showPopUpForInterest), for: .touchDown)
        profilePhotoImageView.setRounded()
        milesRadiusSlider.tintColor = UIColor.coachGreen()
        
        //image picker
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    
    func setPlayerProfile(player_image:String, years_of_experience: String, team_name:String, interested_in:String, player_description: String, miles_radius:String){
            saveProfileButtonOutlet.startAnimating()
        
        
            DispatchQueue.global(qos: .background).async {
                self.dataManager.setPlayerAccount(player_image: player_image, years_of_experience: years_of_experience, team_name: team_name
                    , interested_in: interested_in, player_description: player_description, miles_radius: miles_radius,
                    completion: { (json) -> Void in
                    
                    let status = json["status"]
                    let message = json["message"]
                    if(status == "success"){
                      
                        //Go next
                        DispatchQueue.main.async(execute: {
                            UserDefaults.standard.removeObject(forKey: "profile_type")
                            self.saveProfileButtonOutlet.stopAnimating()
                            self.pushController(id: "WelcomeController")
                            
                        })
                    }else{
                       
                        DispatchQueue.main.async(execute: {
                            self.saveProfileButtonOutlet.stopAnimating()
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
    

    @objc func showPopUpForInterest(){
             
            // Dismiss the Old
            if let presented = self.presentedViewController {
                presented.removeFromParent()
            }
            
            let controller = QuickTableController(interestPickerData) { (section, row) in
                let selectedSection = self.interestPickerData["Kind of games:"]!
                let kindOfGames = selectedSection[row]
                self.interestedInTextField.text = kindOfGames
            }
            self.present(controller, animated: true)
        }
    

}

extension PlayerProfileController: ImagePickerDelegate {
    
        func didSelect(image: UIImage?, type: Int) {
        if type == 1 {
            self.profilePhotoImageView.image = image
        }
    }
}
