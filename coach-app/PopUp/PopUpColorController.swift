//
//  ViewController.swift
//  ChoicePopup
//
//  Created by Arsen Leontijevic on 9/23/19.
//  Copyright © 2019 Ralf Ebert. All rights reserved.
//

import UIKit

class PopUpColorController: UIViewController {

    var customTransitioningDelegate = TransitioningDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        configure()
    }
    
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve // use whatever transition you want
        transitioningDelegate = customTransitioningDelegate
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
