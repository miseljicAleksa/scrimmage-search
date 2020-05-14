//
//  TeamSearchController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/12/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit
import BEMCheckBox
import YYCalendar
import MapKit

class SearchController: AbstractAccountController, CLLocationManagerDelegate {
    @IBOutlet weak var milesLabelOutlet: UILabel!
    
    var customTransitioningDelegate = TransitioningDelegate()
    var delegate : PopUpDelegate?
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    //var and lets
    let years = [Int](1960...2010).map(String.init)
    var agePickerData = ["":[""]]
    
    enum types: String {
        case team
        case official
        case refine
        case official_refine
        case player
        case game
    }
    var type = types.team
    
    //calendar date picker
    var calendar:YYCalendar?
    @IBAction func dateButtonClicked(_ sender: UIButton) {
        calendar!.show()
    }
    
    //Setup if presenting as popup
    func configure() {
        customTransitioningDelegate.height = 600
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve // use whatever transition you want
        transitioningDelegate = customTransitioningDelegate
    }

     //outlets
    @IBOutlet weak var buttonTitleOutlet: UIButton!
    @IBOutlet weak var titleLabelOutlet: UILabel!
    @IBOutlet weak var timeCheckBox: UIControl!
    @IBOutlet weak var dateCheckBox: UIControl!
    @IBOutlet weak var flexibleTimeSwitch: Custom_Segmented_Control!
    @IBOutlet weak var homeFieldSwitch: Custom_Segmented_Control!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var containterOfButton: UIView!
    @IBOutlet weak var milesChangeOutlet: UISlider!
    @IBOutlet weak var milesLabel: UILabel!
    
    //Slider miles
    var intMilesHolder:Int = 50
    @IBAction func sliderDidMove(_ sender: UISlider) {
        
        let intMiles = Int(sender.value.rounded())
        let milesValue = String(intMiles)

        milesLabel.text = String(milesValue + " miles radius")
        intMilesHolder = intMiles
    
    }
    
    //Calendar
    @IBAction func arrowDown(_ sender: AnyObject) {
          calendar!.show()
    }
    
    var day_period:String = "MORNING"

    @IBAction func periodOfDaySegmentControl(_ sender: Custom_Segmented_Control) {
        switch sender.selected_button_idex {
        case 1:
            day_period = "MORNING"
        case 2:
            day_period = "AFTERNOON"
        case 3:
            day_period = "EVENING"
        default:
            day_period = "MORNING"
        }
    }
    
    var home_field_available: String = "0"

    @IBAction func homeFieldAvailableSegment(_ sender: Custom_Segmented_Control) {
        switch sender.selected_button_idex {
        case 1:
            home_field_available = "1"

        default:
            home_field_available = "0"
        }
    }
    
    var flexible_on_date: String = "0"
    @IBAction func flexibleOnDateSegment(_ sender: BEMCheckBox) {
        switch sender.on {
        case true:
            flexible_on_date = "1"
        default:
            flexible_on_date = "0"
        }
    }
    
    var flexible_on_time: String = "0"

    @IBAction func flexibleOnTimeSegment(_ sender: BEMCheckBox) {
        switch sender.on {
        case true:
            flexible_on_time = "1"

        default:
            flexible_on_time = "0"
        }
    }
    
    @IBOutlet weak var milesRadiusBottomBreakLine: UIView!
    var need_players:String = "0"
    @IBAction func needPlayersSegment(_ sender: Custom_Segmented_Control) {
        switch sender.selected_button_idex {
        case 1:
            need_players = "1"
        default:
            need_players = "0"

        }
        
    }
    @IBAction func searchTeamsButtonClicked(_ sender: Any) {
        let looking_date = "1111"
        let miles_radius = String(intMilesHolder)
        
        let def = UserDefaults.standard
        
        guard let latitude = def.string(forKey: "longitude"),
        let longitude = def.string(forKey: "longitude") else
        {
            alert(msg: "Your location is not get yet, please try few seconds later")
            return
        }
        
        switch self.type {
        case .team:
            searchTeams(lon: longitude, lat: latitude, home_field_available: home_field_available, looking_date: looking_date, flexible_on_date: flexible_on_date, day_period: day_period, flexible_on_time: flexible_on_time, need_players: need_players, miles_radius: miles_radius)
        case .player:
            searchPlayers(lon: longitude, lat: latitude, home_field_available: home_field_available, looking_date: looking_date, flexible_on_date: flexible_on_date, day_period: day_period, flexible_on_time: flexible_on_time, need_players: need_players, miles_radius: miles_radius)
            
        case .official:
            searchOfficials(lon: longitude, lat: latitude, home_field_available: home_field_available, looking_date: looking_date, flexible_on_date: flexible_on_date, day_period: day_period, flexible_on_time: flexible_on_time, need_players: need_players, miles_radius: miles_radius)
        case .refine:
            searchTeams(lon: longitude, lat: latitude, home_field_available: home_field_available, looking_date: looking_date, flexible_on_date: flexible_on_date, day_period: day_period, flexible_on_time: flexible_on_time, need_players: need_players, miles_radius: miles_radius)
        case .official_refine:
            searchOfficials(lon: longitude, lat: latitude, home_field_available: home_field_available, looking_date: looking_date, flexible_on_date: flexible_on_date, day_period: day_period, flexible_on_time: flexible_on_time, need_players: need_players, miles_radius: miles_radius)
        case .game:
            searchGames(lon: longitude, lat: latitude, home_field_available: home_field_available, looking_date: looking_date, flexible_on_date: flexible_on_date, day_period: day_period, flexible_on_time: flexible_on_time, need_players: need_players, miles_radius: miles_radius)
        }
        
        
    }
    @IBOutlet var breakLinesOutletCollection: [UIView]!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        
        //fill agepicker data
        self.agePickerData = ["Date":years]
        buttonTitleOutlet.setTitleColor(.black, for: .normal)
        buttonTitleOutlet.contentHorizontalAlignment = .left
        
        //Adopt for different types
        switch self.type {
        case .team:
            self.titleLabelOutlet.text = "Team Search Criteria"
            addScrimmageNavBarBack(title: "Team Search")
            buttonOutlet.setTitle("SEARCH TEAMS", for: .normal)
            
        case .player:
            self.titleLabelOutlet.text = "Player Search Criteria"
            addScrimmageNavBarBack(title: "Player Search")
            buttonOutlet.setTitle("SEARCH PLAYERS", for: .normal)
        case .game:
            self.titleLabelOutlet.text = "Game Search Criteria"
            addScrimmageNavBarBack(title: "Game Search")
            buttonOutlet.setTitle("SEARCH GAMES", for: .normal)
            
        case .official:
            self.titleLabelOutlet.text = "Official Search Criteria"
            addScrimmageNavBarBack(title: "Official Search")
            buttonOutlet.setTitle("SEARCH OFFICIALS", for: .normal)

        case .refine:
            self.titleLabelOutlet.text = "Refine Search Criteria"
            //HIDE EXTRA ELEMENTS, OR SET HEIGHT TO 0
            //For example
            milesLabelOutlet.layer.isHidden = true
            milesRadiusBottomBreakLine.layer.isHidden = true
            buttonOutlet.setTitle("APPLY", for: .normal)
            
        case .official_refine:
            self.titleLabelOutlet.text = "Refine Search Criteria"
            //HIDE EXTRA ELEMENTS, OR SET HEIGHT TO 0
            //For example
            milesLabelOutlet.layer.isHidden = true
            milesRadiusBottomBreakLine.layer.isHidden = true
            buttonOutlet.setTitle("APPLY", for: .normal)

        }
        
        
        //Date picker
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        buttonTitleOutlet.setTitle(result, for: .normal)
       calendar = YYCalendar(normalCalendarLangType: .ENG, date: "06/10/2019", format: "MM/dd/yyyy") { date in
           print(date)

        self.buttonTitleOutlet.setTitle(date, for: .normal)
       }
    
        
        //Title
//        addScrimmageNavBar(title: "Team Search")
        buttonOutlet.backgroundColor = UIColor.coachGreen()
        //set coach grey color for uiviews
        for line in breakLinesOutletCollection{
            line.backgroundColor = UIColor.coachGrey()
        }
        //set rounded corners of button container
        containterOfButton.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            containterOfButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        //change uislider preferences
        milesChangeOutlet.tintColor = UIColor.coachGreen()
        //Switch preferences
        flexibleTimeSwitch.backgroundColor = UIColor.coachGrey()
        flexibleTimeSwitch.selector_color = UIColor.coachGreen()
        homeFieldSwitch.backgroundColor = UIColor.coachGrey()
        homeFieldSwitch.selector_color = UIColor.coachGreen()
//        homeFieldSwitch.
        }

        
    //LOCATION DELEGATE
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        UserDefaults.standard.set(location!.coordinate.latitude.string, forKey: "latitude")
        UserDefaults.standard.set(location!.coordinate.longitude.string, forKey: "longitude")
        self.locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors " + error.localizedDescription)
    }
    
    
    //TEAMS
    func searchTeams(lon: String, lat: String, home_field_available:String, looking_date:String, flexible_on_date:String, day_period:String, flexible_on_time:String, need_players:String, miles_radius:String){
    
    let dm = DataManager()
    buttonOutlet.startAnimating()

    dm.searchTeams(lon: lon, lat: lat, home_field_available: home_field_available, looking_date: looking_date, flexible_on_date: flexible_on_date, day_period: day_period, flexible_on_time: flexible_on_time, need_players: need_players, miles_radius: miles_radius, completion: { (json) -> Void in
                //Go next
                DispatchQueue.main.async(execute: {
                    let status = json["status"]
                    //Success
                    if(status == "success"){
                        var teams:[Team] = []
                        let result = json["result"]
                        
                        for item in result["list"].arrayValue {
                            let team:Team = Team(json: item)
                            teams.append(team)
                        }
                        self.buttonOutlet.stopAnimating()
                        switch self.type {
                        case .team:
                            let nextCon = self.storyboard?.instantiateViewController(withIdentifier: "TeamsResultController") as! TeamsResultController
                            nextCon.source = teams
                            self.navigationController?.pushViewController(nextCon, animated: true)
                        case .player:
                            print("Player")
                        case .refine:
                            if let vc = self.traverseAndFindClass() as TeamsResultController?
                            {
                                vc.source = teams
                            }
                            self.dismiss(animated: true, completion: nil)
                        case .official_refine:
                            print("official_refine")
                        case .official:
                            print("official")
                        case .game:
                            print("game")
                        }
                    }else{
                        //Api Error
                        // Display alert message
                        self.alert(msg: "Error getting search results".localized)
                    }
                    self.buttonOutlet.stopAnimating()
                })
        })
    }
    
    
    //PLAYERS
    func searchPlayers(lon: String, lat: String, home_field_available:String, looking_date:String, flexible_on_date:String, day_period:String, flexible_on_time:String, need_players:String, miles_radius:String){
    
    let dm = DataManager()
    buttonOutlet.startAnimating()
    dm.searchPlayers(lon: lon, lat: lat, home_field_available: home_field_available, looking_date: looking_date, flexible_on_date: flexible_on_date, day_period: day_period, flexible_on_time: flexible_on_time, need_players: need_players, miles_radius: miles_radius, completion: { (json) -> Void in
                //Go next
                DispatchQueue.main.async(execute: {
                    let status = json["status"]
                    //Success
                    if(status == "success"){
                        var players:[Player] = []
                        let result = json["result"]
                        
                        for item in result["list"].arrayValue {
                            let player:Player = Player(json: item)
                            players.append(player)
                        }
                        self.buttonOutlet.stopAnimating()
                        switch self.type {
                        case .player:
                            let nextCon = self.storyboard?.instantiateViewController(withIdentifier: "PlayersResultController") as! PlayersResultController
                            nextCon.source = players
                            self.navigationController?.pushViewController(nextCon, animated: true)
                        case .team:
                            print("Team")
                        case .refine:
                            if let vc = self.traverseAndFindClass() as PlayersResultController?
                            {
                                vc.source = players
                            }
                            self.dismiss(animated: true, completion: nil)
                        case .official_refine:
                            print("official_refine")
                        case .official:
                            print("official")
                        case .game:
                            print("gameeee")
                        }
                        
                        
                    }else{
                        //Api Error
                        // Display alert message
                        self.alert(msg: "Error getting search results".localized)
                    }
                    self.buttonOutlet.stopAnimating()
                })
        })
    }
    
    
    
    //GAMES
    func searchGames(lon: String, lat: String, home_field_available:String, looking_date:String, flexible_on_date:String, day_period:String, flexible_on_time:String, need_players:String, miles_radius:String){
    
    let dm = DataManager()
    buttonOutlet.startAnimating()

    dm.searchGames(lon: lon, lat: lat, home_field_available: home_field_available, looking_date: looking_date, flexible_on_date: flexible_on_date, day_period: day_period, flexible_on_time: flexible_on_time, need_players: need_players, miles_radius: miles_radius, completion: { (json) -> Void in
                //Go next
                DispatchQueue.main.async(execute: {
                    let status = json["status"]
                    //Success
                    if(status == "success"){
                        var games:[Game] = []
                        let result = json["result"]
                        
                        for item in result["list"].arrayValue {
                            let game:Game = Game(json: item)
                            games.append(game)
                        }
                        self.buttonOutlet.stopAnimating()
                        switch self.type {
                        case .game:
                            let nextCon = self.storyboard?.instantiateViewController(withIdentifier: "GamesResultController") as! GamesResultController
                            nextCon.source = games
                            self.navigationController?.pushViewController(nextCon, animated: true)
                        case .player:
                            print("Player")
                        case .refine:
                            if let vc = self.traverseAndFindClass() as GamesResultController?
                            {
                                vc.source = games
                            }
                            self.dismiss(animated: true, completion: nil)
                        case .official_refine:
                            print("official_refine")
                        case .official:
                            print("official")
                        case .team:
                            print("team")
                        }
                        
                        
                    }else{
                        //Api Error
                        // Display alert message
                        self.alert(msg: "Error getting search results".localized)
                    }
                    self.buttonOutlet.stopAnimating()
                })
        })
    }

    
    
    //OFFICIALS
    func searchOfficials(lon: String, lat: String, home_field_available:String, looking_date:String, flexible_on_date:String, day_period:String, flexible_on_time:String, need_players:String, miles_radius:String){
    
    let dm = DataManager()
    buttonOutlet.startAnimating()
    
    dm.searchOfficials(lon: lon, lat: lat, home_field_available: home_field_available, looking_date: looking_date, flexible_on_date: flexible_on_date, day_period: day_period, flexible_on_time: flexible_on_time, need_players: need_players, miles_radius: miles_radius, completion: { (json) -> Void in
                //Go next
                DispatchQueue.main.async(execute: {
                    let status = json["status"]
                    //Success
                    if(status == "success"){
                        var officials:[Official] = []
                        let result = json["result"]
                        
                        for item in result["list"].arrayValue {
                            let official:Official = Official(json: item)
                            officials.append(official)
                        }
                        self.buttonOutlet.stopAnimating()
                        
                        switch self.type {
                        case .official:
                            let nextCon = self.storyboard?.instantiateViewController(withIdentifier: "OfficialsResultController") as! OfficialsResultController
                            nextCon.source = officials
                            self.navigationController?.pushViewController(nextCon, animated: true)
                        case .official_refine:
                            if let vc = self.traverseAndFindClass() as OfficialsResultController?
                            {
                                vc.source = officials
                            }
                            self.dismiss(animated: true, completion: nil)
                        case .team:
                            print("team")
                        case .player:
                            print("player")
                        case .refine:
                            print("refine")
                        case .game:
                            print("game")
                        }
                        
                    }else{
                        //Api Error
                        // Display alert message
                        self.alert(msg: "Error getting search results".localized)
                    }
                    self.buttonOutlet.stopAnimating()
                })
        })
    }
}
    
    



