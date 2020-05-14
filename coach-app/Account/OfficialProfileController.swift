//
//  OfficialProfileController.swift
//  coach-app
//
//  Created by alk msljc on 1/23/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class OfficialProfileController: AbstractAccountController, UIAdaptivePresentationControllerDelegate  {
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    var imagePicker: ImagePicker!
    
    @IBAction func uploadProfilePictureButton(_ sender: UIButton) {
        
        sender.tag = 1
        self.imagePicker.present(from: sender)
        
    }
    @IBAction func removeProfilePictureButton(_ sender: Any) {
        
    }
    @IBOutlet weak var addAnotherCardOutlet: UIButton!
    
    @IBOutlet weak var saveProfileButtonOutlet: UIButton!
    
    @IBOutlet weak var milesRadiusSliderOutlet: UISlider!
    
    @IBOutlet weak var CertificateTextField: UITextField!
    
    @IBOutlet weak var yearsOfExperienceTextField: UITextField!
    @IBOutlet weak var feePerGameTextFIeld: UITextField!
    
    @IBOutlet weak var officialDescriptionTextField: UITextField!
    
    @IBAction func milesRadiusSlider(_ sender: UISlider) {
        
        let intMiles = Int(sender.value.rounded())
        let milesValue = String(intMiles)
        
        milesRadiusValueLabel.text = String(milesValue + " miles")
        
    }
    
    @IBOutlet weak var milesRadiusValueLabel: UILabel!
    
    @IBAction func saveProfileButton(_ sender: UIButton) {
        //official_image:String, sertificate: String, years_of_experience:String, officiating_fee: String, official_description:String, miles_radius:String
        let official_image = profileImageView.image?.resizeImage(100)!.toBase64()
        let sertificate = CertificateTextField.text
        let years_of_experience = yearsOfExperienceTextField.text
        let officiating_fee = feePerGameTextFIeld.text
        let official_description = officialDescriptionTextField.text
        let miles_radius = milesRadiusValueLabel.text


                    // Check for empty field
        if(officiating_fee!.isEmpty || years_of_experience!.isEmpty || officiating_fee!.isEmpty || miles_radius!.isEmpty) {
                        // Display alert message
                        self.alert(msg: "All fields are required!".localized)
                        return
                    }
            print("NJAJANJANJANJANJANJANJANJAN")
                    return
                        setOfficialProfile(official_image: official_image!, sertificate: sertificate!, years_of_experience: years_of_experience!, officiating_fee: officiating_fee!, official_description: official_description!, miles_radius: miles_radius!)
        
        
    }
    
    var dataManager: DataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImageView.setRounded()
        milesRadiusSliderOutlet.tintColor = UIColor.coachGreen()
        
        //image picker
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        view1.backgroundColor = UIColor.coachGrey()
        view2.backgroundColor = UIColor.coachGrey()
        view3.backgroundColor = UIColor.coachGrey()
        view4.backgroundColor = UIColor.coachGrey()
        view5.backgroundColor = UIColor.coachGrey()
        view6.backgroundColor = UIColor.coachGrey()
        view7.backgroundColor = UIColor.coachGrey()
        view8.backgroundColor = UIColor.coachGrey()
        view8.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            view8.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        saveProfileButtonOutlet.backgroundColor = UIColor.coachGreen()
        addAnotherCardOutlet.setTitleColor( UIColor.coachGreen(), for: .normal)
        addAnotherCardOutlet.borderColor = UIColor.coachGreen()

    }
    

  func setOfficialProfile(official_image:String, sertificate: String, years_of_experience:String, officiating_fee: String, official_description:String, miles_radius:String){
      saveProfileButtonOutlet.startAnimating()
  
      DispatchQueue.global(qos: .background).async {
          self.dataManager.setOfficialAccount(official_image: official_image, sertificate: sertificate, years_of_experience: years_of_experience
              , officiating_fee: officiating_fee, official_description: official_description, miles_radius: miles_radius,
              completion: { (json) -> Void in
              
              let status = json["status"]
              let result = json["result"]
              let message = json["message"]
              print(status, result, message)
              if(status == "success"){
                  
                  //Go next
                  DispatchQueue.main.async(execute: {
                    self.saveProfileButtonOutlet.stopAnimating()
                    UserDefaults.standard.removeObject(forKey: "profile_type")
                    self.pushController(id: "WelcomeController")
                      
                      
                  })
              }else{
                 
                  DispatchQueue.main.async(execute: {
                      self.saveProfileButtonOutlet.stopAnimating()
                      
                          // Display alert message
                          self.alert(msg: "Unable to save, please try later".localized)
                      
                  })
              }
      })
      }
  }

}

extension OfficialProfileController: ImagePickerDelegate {
    
        func didSelect(image: UIImage?, type: Int) {
        if type == 1 {
            self.profileImageView.image = image
        }
    }
}
