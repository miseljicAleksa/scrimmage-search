//
//  ProfileTypeController.swift
//  Scrimmage Search
//
//  Created by Arsen Leontijevic on 10/02/2020.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

    //Welcome popup delegate
    internal protocol ActionsDelegate : NSObjectProtocol {
        func teamClicked()
        func officialClicked()
        func coachClicked()
        func playerClicked()
        func gamesClicked()
    }

    class ProfileTypeController: UIViewController {
        var customTransitioningDelegate = AlertTransitioningDelegate()
        
        @IBOutlet weak var view3Line: UIView!
        @IBOutlet weak var view2Line: UIView!
        @IBOutlet weak var view1Line: UIView!
        @IBOutlet weak var completeProfile: UIButton!
        var delegate : ActionsDelegate?
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        convenience init() {
            self.init(nibName:nil, bundle:nil)
            configure()
        }
        
        func configure() {
            customTransitioningDelegate.height = 600
            customTransitioningDelegate.position = .BOTTOM
            modalPresentationStyle = .custom
            modalTransitionStyle = .coverVertical // use whatever transition you want
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
