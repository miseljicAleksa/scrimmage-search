//
//  ViewController.swift
//  coachingApp
//
//  Created by alk msljc on 10/24/19.
//  Copyright © 2019 alk msljc. All rights reserved.
//

import UIKit

class ViewController: AbstractViewController {

    @IBAction func goToSignupButton(_ sender: UIButton) {
       //AbstractViewController.goToController(modifier: "SignupController")
        pushController(id: "SignupController")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

