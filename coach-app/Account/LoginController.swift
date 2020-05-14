//
//  LoginController.swift
//  coachingApp
//
//  Created by alk msljc on 10/24/19.
//  Copyright © 2019 alk msljc. All rights reserved.
//

import UIKit

class LoginController: AbstractAccountController {
    
    
        
    

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var loginButtonStyle: UIButton!
    
    @IBOutlet weak var createAccount: UIButton!
    
    let background_image_view = UIImageView()
    
    @IBAction func createAccountButtonClicked(_ sender: UIButton) {
        AbstractViewController.goToController(animationType: .ANIMATE_RIGHT, modifier: "SignupController")
    }
    //ACTIONS
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
        AbstractViewController.goToController(modifier: "ForgotPasswordController")
    }
    
    @IBAction func login(_ sender: Any) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        signin(email: userEmail!, password: userPassword!);
    }
    
    
    let dataManager:DataManager = DataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        //self.view.addGestureRecognizer(tapGesture)
        
        //addCustomBar(title: "", back: "IntroController")
        loginButtonStyle.backgroundColor = UIColor.coachGreen()
        navigationController?.navigationBar.barTintColor = UIColor.coachGreen()
}
    
    

    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        userEmailTextField.resignFirstResponder()
        userPasswordTextField.resignFirstResponder()
    }
    
    
    @IBAction func backToLogin(sender: UIStoryboardSegue) {
        
    }
    
    
    //new
    //REGISTER TO SERVER AND REDIRECT TO TABBAR
    func signin(email:String,password:String){
        
        // Check for empty field
        if(email.isEmpty || password.isEmpty) {
            // Display alert message
            alert(msg: "All fields are required!".localized)
            return
        }
        
        if(!isValidEmail(testStr: email))
        {
            // Display alert message
            alert(msg: "Email is not valid!".localized)
            return
        }
        
        
        
        loginButtonStyle.startAnimating()
        DispatchQueue.global(qos: .background).async {
            
            self.dataManager.signin(email: email, password: password, completion:{(json) -> Void in
                let status = json["status"]
                let result = json["result"]
                
                //SET USER DATA
                if(status == "success"){
                    let user = User(json: result)
                    user.login()
                    DispatchQueue.main.async(execute: {
                        self.loginButtonStyle.stopAnimating()
                        guard let window = UIApplication.shared.keyWindow else {
                            return
                        }
                        window.showViewControllerWith(withIdentifier: "WelcomeController", usingAnimation: .ANIMATE_LEFT, menu: true)
                        
                    })
                }else{
                    //RESET SETTINGS
                    User.logout()
                    DispatchQueue.main.async(execute: {
                        self.loginButtonStyle.stopAnimating()
                        self.alert(msg: "Email or password is incorrect.".localized)
                        })
                        
                    }
                })
            }
        }
    
    
    
    /// Check if email is valid
    ///
    /// - Parameter testStr: testStr eamil address
    /// - Returns: return Bool
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    
    /// randomString
    ///
    /// - Parameter length: String size
    /// - Returns: Random string
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
    
        return randomString
    }
    
    
    @objc func forgotPass(){
        if let url = URL(string: "https://lepsha.com/forgotpass") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}
