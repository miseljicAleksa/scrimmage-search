//
//  PostGameController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 3/24/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit
import BEMCheckBox
import YYCalendar

class PostGameController: AbstractViewController {
    @IBOutlet var breakLines: [UIView]!
    var calendar:YYCalendar?

    @IBOutlet weak var postYourGameOutlet: UIButton!
    @IBOutlet weak var team2SelectionOutlet: UIButton!
    @IBOutlet weak var team1SelectionOutlet: UIButton!
    @IBOutlet weak var genderSelectionOutlet: UIButton!
    @IBOutlet weak var stateSelectionOutlet: UIButton!
    @IBOutlet weak var timeSelectionOutlet: UIButton!
    @IBOutlet weak var sportSelectionOutlet: UIButton!
    @IBOutlet weak var buttonTitleOutletDate: UIButton!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var addressOutlet: UITextField!
    @IBOutlet weak var cityOutlet: UITextField!
    @IBOutlet weak var zipCodeOutlet: UITextField!
    @IBOutlet weak var enterFeeOutlet: UITextField!
    @IBOutlet weak var negotiableOutlet: BEMCheckBox!
    
    //actions
    //Click Actions
    @IBAction func sportButton(_ sender: Any) {
        showPopUpForSport()

    }
    @IBAction func sportArrow(_ sender: Any) {
        showPopUpForSport()

    }

    @IBAction func dateButton(_ sender: Any) {
        calendar!.show()
    }
    @IBAction func dateArrow(_ sender: Any) {
        calendar!.show()

    }
    @IBAction func timeButton(_ sender: Any) {
        showPopUpForTime()
    }
    @IBAction func timeArrow(_ sender: Any) {
        showPopUpForTime()
    }
    @IBAction func team2Button(_ sender: Any) {
        showPopUpForTeam2()
    }
    @IBAction func team2Arrow(_ sender: Any) {
        showPopUpForTeam2()

    }
    @IBAction func team1Arrow(_ sender: Any) {
        showPopUpForTeam1()

    }
    @IBAction func team1Button(_ sender: Any) {
        showPopUpForTeam1()

    }
    @IBAction func genderArrow(_ sender: Any) {
        showPopUpForGender()
    }
    @IBAction func genderButton(_ sender: Any) {
        showPopUpForGender()
    }
    @IBAction func stateArrow(_ sender: UIButton) {
        showPopUpForState()
    }
    @IBAction func stateButton(_ sender: UIButton) {
        showPopUpForState()
    }
    
    let sportPickerData = ["Select Your Sport":["Soccer", "Basketball", "Softball", "Baseball", "Football", "Voleyball", "Lacrosse", "Hockey", "Ice Hockey", "Tennis"]]
    
    let genderPickerData = ["Select Your Gender":["Male", "Female", "/"]]
    
    let timePickerData = ["Select Time":["1", "2", "3"]]
    
    let team1PickerData = ["Select Team 1":["delije", "grobari", "sartid"]]
    
    let team2PickerData = ["Select Team 2":["delije", "grobari", "sartid"]]
    
    let statePickerData = ["Select State":["CG", "RM", "D"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for line in breakLines{
            line.backgroundColor = UIColor.coachGrey()
        }
        
        buttonContainer.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            buttonContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
         //Date picker
         let date = Date()
         let formatter = DateFormatter()
         formatter.dateFormat = "dd/MM/yyyy"
         let result = formatter.string(from: date)
        let attributes: [NSAttributedString.Key: Any] = [
                       .foregroundColor: UIColor.black,
                   ]
        let attributed = NSAttributedString(string: result, attributes: attributes)
        self.buttonTitleOutletDate.setAttributedTitle(attributed, for: .normal)
         
         calendar = YYCalendar(normalCalendarLangType: .ENG, date: "06/10/2019", format: "MM/dd/yyyy") { date in
            print(date)
            let attributes: [NSAttributedString.Key: Any] = [
                           .foregroundColor: UIColor.black,
                       ]
            let attributed = NSAttributedString(string: date, attributes: attributes)
            self.buttonTitleOutletDate.setAttributedTitle(attributed, for: .normal)
            
        }
        addScrimmageNavBarBack(title: "Post Your Game")
        buttonContainer.backgroundColor=UIColor.coachGrey()
        postYourGameOutlet.backgroundColor=UIColor.coachGreen()
        postYourGameOutlet.setTitle("Post Your Game", for: .normal)

    }
    func showPopUpForSport() {
           
           // Dismiss the Old
           if let presented = self.presentedViewController {
               presented.removeFromParent()
           }
           
           let controller = QuickTableController(sportPickerData) { (section, row) in
               let selectedSection = self.sportPickerData["Select Your Sport"]!
               let sport = selectedSection[row]
                let attributes: [NSAttributedString.Key: Any] = [
                           .foregroundColor: UIColor.black,
                       ]
                       let attributed = NSAttributedString(string: sport, attributes: attributes)
                       self.sportSelectionOutlet.setAttributedTitle(attributed, for: .normal)
           }
           self.present(controller, animated: true)
       }
    
    func showPopUpForGender() {
        
        // Dismiss the Old
        if let presented = self.presentedViewController {
            presented.removeFromParent()
        }
        
        let controller = QuickTableController(genderPickerData) { (section, row) in
            let selectedSection = self.genderPickerData["Select Your Gender"]!
            let gender = selectedSection[row]
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
            ]
            let attributed = NSAttributedString(string: gender, attributes: attributes)
            self.genderSelectionOutlet.setAttributedTitle(attributed, for: .normal)
        }
        self.present(controller, animated: true)
    }
    
    func showPopUpForTime() {
        
        // Dismiss the Old
        if let presented = self.presentedViewController {
            presented.removeFromParent()
        }
        
        let controller = QuickTableController(timePickerData) { (section, row) in
            let selectedSection = self.timePickerData["Select Time"]!
            let time = selectedSection[row]
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
            ]
            let attributed = NSAttributedString(string: time, attributes: attributes)
            self.timeSelectionOutlet.setAttributedTitle(attributed, for: .normal)
        }
        self.present(controller, animated: true)
    }
    
    func showPopUpForTeam1() {
        
        // Dismiss the Old
        if let presented = self.presentedViewController {
            presented.removeFromParent()
        }
        
        let controller = QuickTableController(team1PickerData) { (section, row) in
            let selectedSection = self.team1PickerData["Select Team 1"]!
            let team1 = selectedSection[row]
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
            ]
            let attributed = NSAttributedString(string: team1, attributes: attributes)
            self.team1SelectionOutlet.setAttributedTitle(attributed, for: .normal)
        }
        self.present(controller, animated: true)
    }
    
    func showPopUpForTeam2() {
        
        // Dismiss the Old
        if let presented = self.presentedViewController {
            presented.removeFromParent()
        }
        
        let controller = QuickTableController(team2PickerData) { (section, row) in
            let selectedSection = self.team2PickerData["Select Team 2"]!
            let team2 = selectedSection[row]
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
            ]
            let attributed = NSAttributedString(string: team2, attributes: attributes)
            self.team2SelectionOutlet.setAttributedTitle(attributed, for: .normal)
        }
        self.present(controller, animated: true)
    }
    
    func showPopUpForState() {
        
        // Dismiss the Old
        if let presented = self.presentedViewController {
            presented.removeFromParent()
        }
        
        let controller = QuickTableController(statePickerData) { (section, row) in
            let selectedSection = self.statePickerData["Select State"]!
            let state = selectedSection[row]
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
            ]
            let attributed = NSAttributedString(string: state, attributes: attributes)
            self.stateSelectionOutlet.setAttributedTitle(attributed, for: .normal)
        }
        self.present(controller, animated: true)
    }

    
}
    

