//
//  UserProfileController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 4/18/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class UserProfileController: AbstractViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var yearBorn: UITextField!
    let def = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstName.text = def.string(forKey: "first_name")
        lastName.text = def.string(forKey: "lastName")
        password.text = def.string(forKey: "password")
        mobileNumber.text = def.string(forKey: "mobileNumber")
        email.text = def.string(forKey: "email")
        zipCode.text = def.string(forKey: "zipCode")
        yearBorn.text = def.string(forKey: "yearBorn")
        //disable textFields
        firstName.delegate = self
        lastName.delegate = self
        password.delegate = self
        mobileNumber.delegate = self
        email.delegate = self
        zipCode.delegate = self
        yearBorn.delegate = self
        
        //nav
        addScrimmageNavBarBack(title: "User Profile")
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
