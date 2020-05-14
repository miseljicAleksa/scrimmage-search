//
//  CoachProfileController.swift
//  coach-app
//
//  Created by alk msljc on 1/15/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//
import UIKit
import QuartzCore

class CoachProfileController: AbstractAccountController, HSBColorPickerDelegate, UIAdaptivePresentationControllerDelegate {

    //view outlets
 
    @IBOutlet weak var stepsButton2: UIButton!
    @IBOutlet weak var stepsButton1: UIButton!
    @IBOutlet weak var colorPicker2: UIView!
    @IBOutlet weak var colorPicker1: UIView!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var teamInfoBottomLineView: UIView!
    @IBOutlet weak var teamImageTopLineView: UIView!
    @IBOutlet weak var teamImageBottomLineVIew: UIView!
    @IBOutlet weak var profileTypeTopLineView: UIView!
    @IBOutlet weak var teamInfoTopLineView: UIView!
    @IBOutlet weak var personalInfoBottomLineView: UIView!
    @IBOutlet weak var profileTypeBottomLineView: UIView!
    @IBOutlet weak var endOfSectionBottomLineView: UIView!
    //image outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!

    //button outlets
    @IBOutlet weak var saveProfileButtonOutlet: UIButton!
    @IBOutlet weak var addAnotherTeamButtonOutlet: UIButton!
    @IBOutlet weak var logoImageOutlet: UIButton!
    @IBOutlet weak var teamImageButtonOutlet: UIButton!
    @IBOutlet weak var coach_descriptionTextField: UITextField!
    
    
    //text field outlets
    @IBOutlet weak var genderPickerTextField: UITextField!
    @IBOutlet weak var ageGroupPickerTextField: UITextField!
    @IBOutlet weak var colorPickerTextField: UITextField!
    @IBOutlet weak var teamName: UITextField!
    
    @IBAction func saveProfile(_ sender: Any) {
        
        var team_gender: String = "C"
        
        if genderPickerTextField.text == "Male" {
            team_gender = "M"
        }else if genderPickerTextField.text == "Female"{
            team_gender = "F"
        }else{
            team_gender = "C"
        }
        
        
        let team_description = coach_descriptionTextField.text
        let team_name = teamName.text
        let age_group = ageGroupPickerTextField.text
        let uicolor1 = colorPicker1.backgroundColor
        let color1 = hexStringFromColor(color: uicolor1!)
        let uicolor2 = colorPicker2.backgroundColor
        let color2 = hexStringFromColor(color: uicolor2!)
        let team_image = teamImageView.image?.resizeImage(200)?.toBase64()
        let team_logo = logoImageView.image?.resizeImage(100)?.toBase64()
        let coach_image = profileImage.image?.resizeImage(100)?.toBase64()
        
        var team_colors:[String] = [String]()
        team_colors.append(color1)
        team_colors.append(color2)
        
        // Check for empty field
        if(team_gender.isEmpty || age_group!.isEmpty || team_name!.isEmpty || color1.isEmpty || color2.isEmpty || team_description!.isEmpty) {
            // Display alert message
            self.alert(msg: "All fields are required!".localized)
            return
        }
        
        
        return setCoachProfile(coach_image: coach_image!, team_gender: team_gender, age_group: age_group!,team_name: team_name!, team_colors: team_colors, team_description: team_description!, team_logo: team_logo!, team_image: team_image!)
        
    }
    //actions
    @IBAction func addTeamLogoButton(_ sender: UIButton) {
        sender.tag = 1
         self.imagePicker.present(from: sender)
        
    }
    
    @IBAction func addPictureButton(_ sender: UIButton) {
        sender.tag = 2
         self.imagePicker.present(from: sender)
        
    }
    
    @IBAction func uploadCoachProfileImage(_ sender: UIButton) {
        
        sender.tag = 3
        self.imagePicker.present(from: sender)
        
    }
    
    
    func HSBColorColorPickerTouched(sender: HSBColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizer.State) {
        if let presented = self.presentedViewController {
            presented.dismiss(animated: true, completion: nil)
        }
        colorPicker1.backgroundColor = color
        colorPicker2.backgroundColor = color
    }
    
    func hexStringFromColor(color: UIColor) -> String {
       let components = color.cgColor.components
       let r: CGFloat = components?[0] ?? 0.0
       let g: CGFloat = components?[1] ?? 0.0
       let b: CGFloat = components?[2] ?? 0.0

       let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
       print(hexString)
       return hexString
    }
    
    @IBAction func arrowDownForGender(_ sender: Any) {
        showPopUpForGender()
    }
    @IBAction func arrowDownForAge(_ sender: Any) {
        showPopUpForAge()
    }
    @IBAction func arrowDownForColor(_ sender: Any) {
        let popUpController = PopUpColorController()
        let colorPickerView = popUpController.view as! HSBColorPicker
        colorPickerView.delegate = self
        self.present(popUpController, animated: true)
    }
    

    
    @IBAction func addAnotherProfileButton(_ sender: Any) {
    }
    var imagePicker: ImagePicker!
    
    let agePickerData = ["Select Your Age Group":["1999", "2000", "2001", "2002", "2003"]]
    let genderPickerData = ["Select Your Gender":["Male", "Female", "/"]]
    
    let dataManager: DataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.coachGreen()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.showColorPickerForUIView(_:)))
        self.colorPicker1.addGestureRecognizer(gesture)
        self.colorPicker2.addGestureRecognizer(gesture)
        //image section
        logoImageOutlet.layer.zPosition = 150
        logoImageOutlet.layer.cornerRadius = 0.4 * logoImageOutlet.bounds.size.width
        logoImageOutlet.clipsToBounds = true
        teamImageButtonOutlet.layer.cornerRadius = 0.4 * teamImageButtonOutlet.bounds.size.width
        teamImageButtonOutlet.clipsToBounds = true
        logoImageView.setRounded()
        logoImageView.layer.zPosition = 100
        teamImageView.layer.zPosition = -100
        //disable interaction
        genderPickerTextField.delegate = self
        ageGroupPickerTextField.delegate = self
        //color picker views
        colorPicker1.layer.cornerRadius = 10
        colorPicker2.layer.cornerRadius = 10
        stepsButton1.backgroundColor = UIColor.coachGreen()
        stepsButton2.backgroundColor = UIColor.coachGrey()
        
        
        
        //image picker
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
            
        //style button
        addAnotherTeamButtonOutlet.borderColor = UIColor.coachGreen()
        saveProfileButtonOutlet.backgroundColor = UIColor.coachGreen()
        //style horizontal lines
        personalInfoBottomLineView.backgroundColor = UIColor.coachGrey()
        teamInfoTopLineView.backgroundColor = UIColor.coachGrey()
        teamInfoBottomLineView.backgroundColor =
            UIColor.coachGrey()
        teamImageTopLineView.backgroundColor = UIColor.coachGrey()
        teamImageBottomLineVIew.backgroundColor = UIColor.coachGrey()
        endOfSectionBottomLineView.backgroundColor = UIColor.coachGrey()
        profileTypeBottomLineView.backgroundColor = UIColor.coachGrey()
        profileTypeTopLineView.backgroundColor = UIColor.coachGrey()
        profileImage.setRounded()
        buttonContainer.backgroundColor = UIColor.coachGrey()
        buttonContainer.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            buttonContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        genderPickerTextField.addTarget(self, action: #selector(showPopUpForGender), for: .touchDown)
        ageGroupPickerTextField.addTarget(self, action: #selector(showPopUpForAge), for: .touchDown)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func showColorPickerForUIView(_ sender:UITapGestureRecognizer){
        let popUpController = PopUpColorController()
        let colorPickerView = popUpController.view as! HSBColorPicker
        colorPickerView.delegate = self
        self.present(popUpController, animated: true)
    }
    

    @objc func showPopUpForGender() {
         
         // Dismiss the Old
         if let presented = self.presentedViewController {
             presented.removeFromParent()
         }
         
         let controller = QuickTableController(genderPickerData) { (section, row) in
             let selectedSection = self.genderPickerData["Select Your Gender"]!
             let gender = selectedSection[row]
             self.genderPickerTextField.text = gender
         }
         self.present(controller, animated: true)
     }
    
    @objc func showPopUpForAge() {
         
         // Dismiss the Old
         if let presented = self.presentedViewController {
             presented.removeFromParent()
         }
         
         let controller = QuickTableController(agePickerData) { (section, row) in
             let selectedSection = self.agePickerData["Select Your Age Group"]!
             let age = selectedSection[row]
             self.ageGroupPickerTextField.text = age
         }
         self.present(controller, animated: true)
     }
    
    
    
    
    func setCoachProfile(coach_image:String, team_gender: String, age_group:String, team_name: String, team_colors:[String], team_description:String, team_logo:String, team_image: String){
            saveProfileButtonOutlet.startAnimating()
        
            DispatchQueue.global(qos: .background).async {
                self.dataManager.setCoachAccount(coach_image: coach_image, team_gender: team_gender, age_group: age_group
                    , team_name: team_name, team_colors: team_colors, team_description: team_description, team_logo: team_logo, team_image: team_image,
                    completion: { (json) -> Void in
                    
                    let status = json["status"]
                    let result = json["result"]
                    let message = json["message"]
                    print(status, result, message)
                    if(status == "success"){
                        
                        //Go next
                        DispatchQueue.main.async(execute: {
                            self.saveProfileButtonOutlet.stopAnimating()
                             self.pushController(id: "CoachExperienceController")
                            
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



    


}

extension CoachProfileController: ImagePickerDelegate {
    
    
    //we have to add some query to ask which button is sending action
    func didSelect(image: UIImage?, type: Int) {
        if type == 1 {
            self.logoImageView.image = image
        }else if type == 2{
            self.teamImageView.image = image
        }else{
            self.profileImage.image = image
        }
    }
}
