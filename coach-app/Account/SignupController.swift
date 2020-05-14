//
//  SignupController.swift
//  Lepsha
//
//  Created by  reegee 
//  Copyright © 2018 Software Engineering Institute. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn

class SignupController: AbstractAccountController, PopUpDelegate, GIDSignInDelegate {
    
    
    //view outlets
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var ggButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func ggButtonClick(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().delegate = self
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            print(error)
            //alert(msg: "Error login")
            return
        }
            self.userEmailTextField.text = user.profile.email
            self.firstNameTextField.text = user.profile.givenName
            self.lastNameTextField.text = user.profile.familyName
           
    }
    @IBAction func fbButtonClick(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(
            permissions: [.publicProfile, .email],
            viewController: self
        ) { result in
            self.loginManagerDidComplete(result)
        }
    }
    
    func loginManagerDidComplete(_ result: LoginResult) {
        let alertController: UIAlertController
        switch result {
        case .cancelled:
            //alert(msg: "canceled")
            print("canceled")
        case .failed(let error):
            
            alert(msg: "canceled")
            
        case .success(let grantedPermissions, _, _):
            returnUserData()
        }
    }
    
    func returnUserData()
    {
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me", parameters: ["fields":"id,first_name,last_name,email"])) { httpResponse, result, error in
            if error != nil {
                print(error)
                return
            }
            
            // Handle vars
            if let result = result as? [String:String]{
                if let email: String = result["email"]{
                    self.userEmailTextField.text = email
                }
                if let first_name: String = result["first_name"] {
                    self.firstNameTextField.text = first_name
                }
                if let last_name: String = result["last_name"] {
                    self.lastNameTextField.text = last_name
                }
            }
        }
        connection.start()
        
    }
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var viewDim: UIView!
    @IBOutlet var termsAndConditionsPopupView: UIView!
    @IBOutlet weak var buttonBackground: UIView!
    @IBOutlet weak var profileTypeSectionBottomLineView: UIView!
    @IBOutlet weak var profileTypeBottomLineView: UIView!
    @IBOutlet weak var personalInfoSectioBottomLineVIew: UIView!
    @IBOutlet weak var personalInfoBottomLineView: UIView!
    @IBOutlet weak var backgroundOfContinueButtons: UIView!
    //button outlets
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var addAnotherButtonOutlet: UIButton!
    //text field outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var roleSelectionTextField: UITextField!
    @IBOutlet weak var sportSelectionTextField: UITextField!
    @IBOutlet weak var completeProfileButtonOutlet: UIButton!
    @IBAction func completeProfileButton(_ sender: UIButton) {
        pushController(id: "AccountVerficationController")
    }
    
    //LOGIN
    @IBAction func addAnotherButton(_ sender: Any) {
        AbstractViewController.goToController(modifier: "LoginController")
    }
    
    //other
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    //action outlets
    
    func nextButtonClicked() {
        if let presented = self.presentedViewController {
            presented.dismiss(animated: true, completion: nil)
        }
        pushController(id: "AccountVerficationController")
    }
    
    @IBAction func arrowDownForYear(_ sender: UIButton) {
        showPopUpForAge()
    }
    @IBAction func arrowDownForRole(_ sender: UIButton) {
        showPopUpForRole()
    }
    @IBAction func arrowDownForSport(_ sender: Any) {
        showPopUpForSport()
    }
    
    //lets
    let dataManager:DataManager = DataManager()
    let background_image_view = UIImageView()
    let rolePickerData = ["Select Your Role":["Coach", "Official","Player"]]
    let sportPickerData = ["Select Your Sport":["Soccer", "Basketball", "Softball", "Baseball", "Football", "Voleyball", "Lacrosse", "Hockey", "Ice Hockey", "Tennis"]]
    let years = [Int](1960...2010).map(String.init)
    var agePickerData = ["":[""]]
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //User is logged in
        if UserDefaults.standard.string(forKey: "access_token") != nil {
            
            //self.pushController(id: "WelcomeController")
        }

        GIDSignIn.sharedInstance()?.presentingViewController = self

        self.agePickerData = ["Select Your Age":years]
        
        //disable textFields
        dateOfBirthTextField.delegate = self
        roleSelectionTextField.delegate = self
        sportSelectionTextField.delegate = self
        
        fbButton.tintColor = UIColor.white
        ggButton.tintColor = UIColor.white
        
        
        
        navigationController?.navigationBar.barTintColor = UIColor.coachGreen()
        userEmailTextField.keyboardType = UIKeyboardType.emailAddress
        
        mobileNumberTextField.keyboardType = .numberPad
        zipCodeTextField.keyboardType = .numberPad
        
        roleSelectionTextField.addTarget(self, action: #selector(showPopUpForRole), for: .touchDown)
        
        sportSelectionTextField.addTarget(self, action: #selector(showPopUpForSport), for: .touchDown)
        
        dateOfBirthTextField.addTarget(self, action: #selector(showPopUpForAge), for: .touchDown)
        
        if #available(iOS 12, *) {
            // iOS 12 & 13: Not the best solution, but it works.
            userPasswordTextField.textContentType = .oneTimeCode
        } else {
            // iOS 11: Disables the autofill accessory view.
            userPasswordTextField.textContentType = .init(rawValue: "")
        }
        
        //DISMISS KEYBOARD
        /**let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        **/
        backgroundOfContinueButtons.backgroundColor = UIColor.coachGrey()
        personalInfoBottomLineView.backgroundColor = UIColor.coachGrey()
        personalInfoSectioBottomLineVIew.backgroundColor = UIColor.coachGrey()
        profileTypeBottomLineView.backgroundColor = UIColor.coachGrey()
        profileTypeSectionBottomLineView.backgroundColor = UIColor.coachGrey()
        //addAnotherButtonOutlet.borderColor = UIColor.coachGreen()
        nextButtonOutlet.backgroundColor = UIColor.coachGreen()
        buttonBackground.backgroundColor = UIColor.coachGrey()
        scrollView.backgroundColor = UIColor.coachGrey()
        
        //action
      
       buttonBackground.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            buttonBackground.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        
    }
    

    
    @objc func showPopUpForRole() {
        // Dismiss the Old
        if let presented = self.presentedViewController {
            presented.removeFromParent()
        }
        
        let controller = QuickTableController(rolePickerData) { (section, row) in
            let selectedSection = self.rolePickerData["Select Your Role"]!
            let role = selectedSection[row]
            self.roleSelectionTextField.text = role
        }
        
        self.present(controller, animated: true)
    }
    
    @objc func showPopUpForSport() {
        
        // Dismiss the Old
        if let presented = self.presentedViewController {
            presented.removeFromParent()
        }
        
        let controller = QuickTableController(sportPickerData) { (section, row) in
            let selectedSection = self.sportPickerData["Select Your Sport"]!
            let sport = selectedSection[row]
            self.sportSelectionTextField.text = sport
        }
        self.present(controller, animated: true)
    }
    
    @objc func showPopUpForAge() {
         
         // Dismiss the Old
         if let presented = self.presentedViewController {
             presented.removeFromParent()
         }
         
         let controller = QuickTableController(agePickerData) { (section, row) in
             let selectedSection = self.agePickerData["Select Your Age"]!
             let age = selectedSection[row]
             self.dateOfBirthTextField.text = age
            
         }
         self.present(controller, animated: true)
     }
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func signupButton(_ sender: Any) {
        
        let email = userEmailTextField.text
        let password = userPasswordTextField.text
        let first_name = firstNameTextField.text
        let last_name = lastNameTextField.text
        let mobile_number = mobileNumberTextField.text
        let zip_code = zipCodeTextField.text
        let year_born = dateOfBirthTextField.text
        let profile_type = roleSelectionTextField.text
        let sport = sportSelectionTextField.text
        
        
        // Check for empty field
        if(email!.isEmpty || password!.isEmpty) {
            // Display alert message
            self.alert(msg: "All fields are required!".localized)
            return
        }
        
        if(!isValidEmail(testStr: email!))
        {
            // Display alert message
            self.alert(msg: "Email is not valid!".localized)
            return
        }
        
        // Password length
        if(password!.count < 6) {
            // Display alert message
            self.alert(msg: "Password must be between 6 and 20 characters long".localized)
            return
        }else if(year_born!.count > 4) {
            // Display alert message
            self.alert(msg: "Year born have to be 4 characters long".localized)
            return
        }
        
        // Password matching
//        if(password != repeatPassword) {
//            // Display alert message
//            self.alert(msg: "Passwords do not match".localized)
//            return
//        }
//
        return
            register(first_name: first_name!, last_name: last_name!, email: email!, password: password!, mobile_number: mobile_number!, zip_code: zip_code!, year_born: year_born!, profile_type: profile_type!, sport: sport!)
    }
    

    

    
    func register(first_name:String, last_name:String, email:String, password:String, mobile_number:String, zip_code:String, year_born:String, profile_type:String, sport:String){
        nextButtonOutlet.startAnimating()
        DispatchQueue.global(qos: .background).async {
            self.dataManager.signup(first_name: first_name, last_name: last_name, email: email, password: password, mobile_number: mobile_number, zip_code: zip_code, year_born: year_born, profile_type: profile_type, sport: sport, completion: { (json) -> Void in
                
                UserDefaults.standard.set(profile_type, forKey: "profile_type")
                
                let status = json["status"]
                let result = json["result"]
                let message = json["message"]

                if(status == "success"){

                    //Login user
                    let user = User(json: result)
                    user.login()
                    //Go next
                    DispatchQueue.main.async(execute: {
                        self.nextButtonOutlet.stopAnimating()
                        //Start Terma popup
                        let terms = TermsController()
                        terms.delegate = self
                        self.present(terms, animated: true)
                    })
                }else{
                    //Logout user
                    User.logout()

                    DispatchQueue.main.async(execute: {
                        self.nextButtonOutlet.stopAnimating()
                        if(message == "0")
                        {
                            // Display alert message
                            self.alert(msg: "The email has been already registered. Please go to login or use another one".localized)
                        }else
                        {
                            // Display alert message
                            self.alert(msg: "Unable to register, please try later".localized)
                        }
                    })
                }
        })
        }
    }



    /// Email syntax validation
    ///
    /// - Parameter testStr: <#testStr description#>
    /// - Returns: <#return value description#>
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    /// Random string
    ///
    /// - Parameter length: length string length
    /// - Returns: return value String
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
    

    


    
    
//    func displayAlertMessage(userMessage:String) {
//
//        let textFieldAlert = UIAlertController(title: "Alert".localized, message: userMessage, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok".localized, style: .default, handler: nil)
//
//        textFieldAlert.addAction(okAction)
//
//        self.present(textFieldAlert, animated: true, completion: nil)
//
//    }


}



//SAVE THIS EXTENSION SOMEWHERE, IT COULD BE USEFULL LATER

//extension SignupController: UIPickerViewDelegate, UIPickerViewDataSource{
//
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if (pickerView == rolePicker){
//            return rolePickerData.count
//        }else{
//            return sportPickerData.count
//        }
//
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if (pickerView == rolePicker){
//            roleSelectionTextField.text = rolePickerData[row]
//        }else{
//            sportSelectionTextField.text = sportPickerData[row]
//        }
//
//        view.endEditing(false)
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        if (pickerView == rolePicker){
//            return rolePickerData[row]
//        }else{
//            return sportPickerData[row]
//        }
//
//    }
//}
 
