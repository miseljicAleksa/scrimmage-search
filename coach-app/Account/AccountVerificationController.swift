//
//  AccountVerificationController.swift
//  coach-app
//
//  Created by alk msljc on 1/23/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class AccountVerificationController: AbstractAccountController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
  
    @IBAction func backButtonClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        //pushController(id: "SignupController")
    }
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField1: UITextField!
    let dataManager:DataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.backgroundColor = UIColor.coachGreen()

        backButton.tintColor = UIColor.white
        
        textField1.keyboardType = .numberPad
        textField2.keyboardType = .numberPad
        textField3.keyboardType = .numberPad
        textField4.keyboardType = .numberPad
        
        textField1.layer.cornerRadius = 30
        textField1.layer.masksToBounds = true
        textField1.layer.borderWidth = 2
        textField1.layer.borderColor = UIColor.white.cgColor
        textField1.backgroundColor = UIColor.coachGreen()

        
        textField2.layer.cornerRadius = 30
        textField2.layer.masksToBounds = true
        textField2.backgroundColor = UIColor.coachGreen()
        textField2.layer.borderWidth = 2
        textField2.layer.borderColor = UIColor.white.cgColor
        
        textField3.layer.cornerRadius = 30
        textField3.layer.masksToBounds = true
        textField3.layer.borderWidth = 2
        textField3.layer.borderColor = UIColor.white.cgColor
        textField3.backgroundColor = UIColor.coachGreen()
        
        textField4.layer.cornerRadius = 30
        textField4.layer.masksToBounds = true
        textField4.layer.borderWidth = 2
        textField4.layer.borderColor = UIColor.white.cgColor
        textField4.backgroundColor = UIColor.coachGreen()
        
        textField1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textField2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textField3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textField4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        if #available(iOS 12.0, *) {
            textField1.textContentType = .oneTimeCode
        }
        
       //Set focus on first
        textField1.becomeFirstResponder()
        
    }
    
    @IBAction func resendCode(_ sender: Any) {
        loader.startAnimating()
        DispatchQueue.global(qos: .background).async {
            self.dataManager.resendCode(completion: { (json) -> Void in
                let status = json["status"]
                if(status == "success"){
                    DispatchQueue.main.async { () -> Void in
                        self.loader.stopAnimating()
                        // Display alert message
                        self.alert(msg: "The new verification code has been sent to your email, please also check SPAM folder.".localized)
                    }
                }else{
                    DispatchQueue.main.async(execute: {
                        self.loader.stopAnimating()
                        // Display alert message
                        self.alert(msg: "We're not able to send the new code to you at the moment, please contact our support at support@scrimmagesearch.com".localized)
                    })
                }
            })
        }
    }
    
    
        
    
    
    
    func checkIfAllTextFieldHasValue(txtField1: UITextField, txtField2: UITextField, txtField3: UITextField, txtField4: UITextField ){
        
        if !txtField1.text!.isEmpty && !txtField2.text!.isEmpty && !txtField3.text!.isEmpty && !txtField4.text!.isEmpty {
//            pushController(id: "CoachProfileController")
            
        }else{
            print("U have to enter some digits")

        }
        
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        
        textField.becomeFirstResponder()
        
        //If one if filled up, go to next
        if  text?.count == 1 {
            switch textField{
            case textField1:
                textField2.becomeFirstResponder()
            case textField2:
                textField3.becomeFirstResponder()
            case textField3:
                textField4.becomeFirstResponder()
            default:
                break
            }
        }else if text?.count == 4 {
            pasteCode(otpCode: textField.text!)
        }else{
            textField.text = ""
        }
        
        
        if(!textField1.text!.isEmpty && !textField2.text!.isEmpty && !textField3.text!.isEmpty && !textField4.text!.isEmpty)
        {
            let verifyAccCode = textField1.text! + textField2.text! + textField3.text! + textField4.text!
            verifyAccount(code: verifyAccCode)
        }
        
    }
    
    func pasteCode(otpCode:String){
        // here check you text field's input Type
        if #available(iOS 12.0, *) {
                //here split the text to your four text fields
            print(otpCode[1])
                    textField1.text = otpCode[0]
                    textField2.text = otpCode[1]
                    textField3.text = otpCode[2]
                    textField4.text = otpCode[3]
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    func clearTextViews() -> Void {
        textField1.text = ""
        textField2.text = ""
        textField3.text = ""
        textField4.text = ""
        textField1.becomeFirstResponder()
    }
    
    func verifyAccount(code: String){
        
            loader.startAnimating()
            DispatchQueue.global(qos: .background).async {
                self.dataManager.verifyAccount(code: code, completion: { (json) -> Void in
                    let status = json["status"]
                    if(status == "success"){
                            DispatchQueue.main.async { () -> Void in
                                self.loader.stopAnimating()
                                switch UserDefaults.standard.string(forKey: "profile_type") {
                                case "Coach":
                                    self.pushController(id: "CoachProfileController")
                                case "Official":
                                    self.pushController(id: "OfficialProfileController")
                                case "Player":
                                    self.pushController(id: "PlayerProfileController")
                                default:
                                    self.alert(msg: "Some error occured, no profile type defined")
                                }
                            }
                    }else{
                        DispatchQueue.main.async(execute: {
                            self.loader.stopAnimating()
                            self.clearTextViews()
                            // Display alert message
                            self.alert(msg: "Verification error, please check the code again.".localized)
                        })
                    }
            })
            }
        }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
   
    

}


