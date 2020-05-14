//
//  TermsController.swift
//  coach-app
//
//  Created by alk msljc on 1/24/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit
import MapKit
import BEMCheckBox

internal protocol PopUpDelegate : NSObjectProtocol {
    func nextButtonClicked()
}


class TermsController: AbstractViewController, BEMCheckBoxDelegate {
    
    
    func didTap(_ checkBox: BEMCheckBox) {
        
        if checkBox.on {
            completeProfile.isEnabled = true
        }else{
            completeProfile.isEnabled = false
        }
        print("tapped")
    }
    
    
    var customTransitioningDelegate = TransitioningDelegate()
    
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var view3Line: UIView!
    @IBOutlet weak var view2Line: UIView!
    @IBOutlet weak var view1Line: UIView!
    @IBOutlet weak var completeProfile: UIButton!
    var     delegate : PopUpDelegate?
    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeProfile.backgroundColor = UIColor.coachGreen()
        view1Line.backgroundColor = UIColor.coachGrey()
        view2Line.backgroundColor = UIColor.coachGrey()
        view3Line.backgroundColor = UIColor.coachGrey()
        checkBox.delegate = self
    }
    
    @IBAction func xButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func acceptTerms(_ sender: Any) {
        
        
        if CLLocationManager.locationServicesEnabled() {
            print(CLLocationManager.authorizationStatus())
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                self.alertLocationDisabled()
            case .authorizedAlways, .authorizedWhenInUse:
                print("enabled")
                self.delegate?.nextButtonClicked()
            }
        } else {
            self.alertLocationDisabled()
        }
    }
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        configure()
    }
    
    func configure() {
        customTransitioningDelegate.height = 600
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
