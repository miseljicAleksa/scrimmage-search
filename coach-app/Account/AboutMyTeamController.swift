//
//  AboutMyTeamController.swift
//  coachingApp
//
//  Created by alk msljc on 10/27/19.
//  Copyright © 2019 alk msljc. All rights reserved.
//

import UIKit

class AboutMyTeamController: AbstractAccountController {
   
    

    
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageGroupTextField: UITextField!
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var teamColorsTextField: UITextField!
    @IBOutlet weak var shortDescriptionTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var teamImageView: UIImageView!
    
    @IBAction func addTeamLogoButton(_ sender: UIButton) {
        sender.tag = 1
         self.imagePicker.present(from: sender)
        
    }
    
    @IBAction func addPictureButton(_ sender: UIButton) {
        sender.tag = 2
         self.imagePicker.present(from: sender)
        
    }
    
    @IBAction func shareAppButton(_ sender: UIButton) {
        
        let activityVC = UIActivityViewController(activityItems: ["www.google.com"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func addAnotherTeamButton(_ sender: UIButton) {
        
        
    }
    @IBAction func searchSetupButton(_ sender: UIButton) {
        
        pushController(id: "coachSearchSetupController")
        
    }
    
    //VARS and LETS
    private var ageGroupPicker: UIPickerView?
    private var genderPicker: UIPickerView?
    private var colorPicker: UIPickerView?
    
    var ageGroupPickerData = ["1998","1998.5","1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010"]
    var genderPickerData = ["male", "female", "COED"]
    var colorPickerData = ["black", "white", "red", "blue", "green", "yellow", "purple", "brown"]
    
    var imagePicker: ImagePicker!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //datePicker selection configuration
        //genderPicker selection configuration
        ageGroupPicker = UIPickerView()
        ageGroupPicker?.dataSource = self
        ageGroupPicker?.delegate = self
        ageGroupTextField.inputView = ageGroupPicker
        
        
        //genderPicker selection configuration
        genderPicker = UIPickerView()
        genderPicker?.dataSource = self
        genderPicker?.delegate = self
        genderTextField.inputView = genderPicker
        
        //colorPicker selection configuration
        colorPicker = UIPickerView()
        colorPicker?.dataSource = self
        colorPicker?.delegate = self
        teamColorsTextField.inputView = colorPicker
        
        //image picker
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
}

extension AboutMyTeamController: UIPickerViewDelegate, UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           if (pickerView == genderPicker){
               return genderPickerData.count
           }else if(pickerView == ageGroupPicker){
                return ageGroupPickerData.count
           }else{
               return colorPickerData.count
           }
           
       }
       
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           if (pickerView == genderPicker){
               genderTextField.text = genderPickerData[row]
           }else if(pickerView == ageGroupPicker){
                ageGroupTextField.text = ageGroupPickerData[row]
           }else{
               teamColorsTextField.text = colorPickerData[row]
           }
           
           view.endEditing(false)
       }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           
           if (pickerView == genderPicker){
               return genderPickerData[row]
           }else if(pickerView == ageGroupPicker){
                return ageGroupPickerData[row]
           }else{
               return colorPickerData[row]
           }
            
       }
}


extension AboutMyTeamController: ImagePickerDelegate {
    
    
    //we have to add some query to ask which button is sending action
    func didSelect(image: UIImage?, type: Int) {
        if type == 1 {
            self.logoImageView.image = image
        }else{
            self.teamImageView.image = image
        }
    }
}
