//
//  TermsAndConditionsController.swift
//  coachingApp
//
//  Created by alk msljc on 10/27/19.
//  Copyright © 2019 alk msljc. All rights reserved.
//

import UIKit
//import BEMCheckBox

class TermsAndConditionsController: AbstractAccountController {
    
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var viewOutlet3: UIView!
    @IBOutlet weak var viewOutlet2: UIView!
    @IBOutlet weak var viewOutlet1: UIView!
    @IBAction func nextButton(_ sender: UIButton) {
        pushController(id: "CoachProfileController")
    }
    override func viewDidLoad() {
           super.viewDidLoad()
        viewOutlet1.backgroundColor = UIColor.coachGrey()
        viewOutlet2.backgroundColor = UIColor.coachGrey()
        viewOutlet3.backgroundColor = UIColor.coachGrey()
        buttonOutlet.backgroundColor = UIColor.coachGreen()

        
        
    }
    
    
    
    
}
