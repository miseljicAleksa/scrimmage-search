//
//  DataManager.swift
//  coachingApp
//
//  Created by alk msljc on 10/24/19.
//  Copyright © 2019 alk msljc. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    
    let salonApiUrl:String = "https://test.scrimmage.atakinteractive.com/application/api/json"
    let userApiUrl:String = "https://test.scrimmage.atakinteractive.com/application/api/json"
    
    let privateKey:String = "0e960cb10f6a06933479bccc5db2b814"
    
    var localItems = [[String:AnyObject]]()
    var filteredItems = [[String:AnyObject]]()
    var queryItems = [NSURLQueryItem()]
    var category:String = "all"
    
    var users: [User] = []
    
    var userDef = UserDefaults.standard
    var email: String = ""
    var access_token: String?
    
    enum methods: String {
        case GET
        case POST
    }
    
    var method = methods.GET
    
    init()
    {
        if (userDef.string(forKey: "email") != nil){
            email = userDef.string(forKey: "email")!
        }
        
        access_token = userDef.string(forKey: "access_token")
        
    }
    
    func setDeviceToken(deviceToken: String, completion:@escaping (_ status: String?) -> Void) {
        
        self.queryItems.removeAll()
        
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: UserDef().access_token))
        self.queryItems.append(NSURLQueryItem(name: "action", value: "setDeviceToken"))
        self.queryItems.append(NSURLQueryItem(name: "deviceToken", value: "ios_"+deviceToken))
        
        // Get JSON data
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            completion(String(describing: json["status"]))
        }
    }
    
    
    func signin(email:String,password:String, completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        
        self.queryItems.append(NSURLQueryItem(name: "email", value: email))
        self.queryItems.append(NSURLQueryItem(name: "password", value: password))
        self.queryItems.append(NSURLQueryItem(name: "action", value: "login"))
        
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            completion(json)
        }
    }
    
    func getSessions(completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getSessions"))
        
        let apiData = getTempData()
        let json = JSON(data: apiData)
        completion(json)
    }
    
    func getFavorites(completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getFavorites"))
        
        let apiData = getTempData()
        let json = JSON(data: apiData)
        completion(json)
    }
    
    func changeEmail(email:String, completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "email", value: email))
        self.queryItems.append(NSURLQueryItem(name: "action", value: "changeEmail"))
        
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            completion(json)
        }
    }
    
    
    func signup(first_name:String, last_name:String, email:String, password:String, mobile_number:String, zip_code:String, year_born:String, profile_type:String, sport:String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "signup"))
        self.queryItems.append(NSURLQueryItem(name: "first_name", value: first_name))
        self.queryItems.append(NSURLQueryItem(name: "last_name", value: last_name))
        self.queryItems.append(NSURLQueryItem(name: "email", value: email))
        self.queryItems.append(NSURLQueryItem(name: "password", value: password))
        self.queryItems.append(NSURLQueryItem(name: "mobile_number", value: mobile_number))
        self.queryItems.append(NSURLQueryItem(name: "zip_code", value: zip_code))
        self.queryItems.append(NSURLQueryItem(name: "year_born", value: year_born))
        self.queryItems.append(NSURLQueryItem(name: "profile_type", value: profile_type))
        self.queryItems.append(NSURLQueryItem(name: "sport", value: sport))

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func verifyAccount(code: String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "verifyAccount"))
        self.queryItems.append(NSURLQueryItem(name: "code", value: code))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func setCoachAccount(coach_image:String, team_gender:String,age_group:String, team_name:String,
                         team_colors:[String],team_description: String, team_logo:String, team_image: String,
        completion:@escaping (_ status: JSON) -> Void) {
        
        
        
        let color_data: Data = {
            do {
                return try JSONSerialization.data(withJSONObject: team_colors, options: [])
            } catch {
                return "[]".data(using: .utf8)!
            }
        }()
        let team_colors_json = String(data: color_data, encoding: String.Encoding.utf8)
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "setCoachAccount"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        self.queryItems.append(NSURLQueryItem(name: "coach_image", value: coach_image))
        self.queryItems.append(NSURLQueryItem(name: "team_gender", value: team_gender))
        self.queryItems.append(NSURLQueryItem(name: "age_group", value: age_group))
        self.queryItems.append(NSURLQueryItem(name: "team_name", value: team_name))
        self.queryItems.append(NSURLQueryItem(name: "team_colors", value: team_colors_json))
        self.queryItems.append(NSURLQueryItem(name: "team_description", value: team_description))
        self.queryItems.append(NSURLQueryItem(name: "team_logo", value: team_logo))
        self.queryItems.append(NSURLQueryItem(name: "team_image", value: team_image))

        //Set post method
        self.method = .POST
        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            //call completion handler
            completion(json)
        }
    }
    
    func setCoachExperience(experience_1:String, experience_2:String, session_plan:String,
        completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "setCoachExperience"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        self.queryItems.append(NSURLQueryItem(name: "experience_1", value: experience_1))
        self.queryItems.append(NSURLQueryItem(name: "experience_2", value: experience_2))
        self.queryItems.append(NSURLQueryItem(name: "session_plan", value: session_plan))




        //Set post method
        self.method = .POST
        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            
            print(String(data: apiData!, encoding: .utf8))
            //call completion handler
            completion(json)
        }
    }
    
    func sendMessage(request_id: String,message: String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "sendMessage"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        self.queryItems.append(NSURLQueryItem(name: "request_id", value: request_id))
        self.queryItems.append(NSURLQueryItem(name: "message", value: message))
        //Set post method
        self.method = .POST
        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            
            print(String(data: apiData!, encoding: .utf8))
            //call completion handler
            completion(json)
        }
    }
    
    func setRequestStatus(request_id: String, status: String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "setRequestStatus"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        self.queryItems.append(NSURLQueryItem(name: "request_id", value: request_id))
        self.queryItems.append(NSURLQueryItem(name: "status", value: status))
        //Set post method
        self.method = .POST
        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            
            print(String(data: apiData!, encoding: .utf8))
            //call completion handler
            completion(json)
        }
    }
    
    
    func setPlayerAccount(player_image:String, years_of_experience:String, team_name:String,
                            interested_in:String, player_description:String,
             miles_radius: String,
           completion:@escaping (_ status: JSON) -> Void) {
           
           //Add all needed params
           self.queryItems.removeAll()
           self.queryItems.append(NSURLQueryItem(name: "action", value: "setPlayerAccount"))
           self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
           self.queryItems.append(NSURLQueryItem(name: "player_image", value: player_image))
           self.queryItems.append(NSURLQueryItem(name: "years_of_experience", value: years_of_experience))
           self.queryItems.append(NSURLQueryItem(name: "team_name", value: team_name))
           self.queryItems.append(NSURLQueryItem(name: "interested_in", value: interested_in))
           self.queryItems.append(NSURLQueryItem(name: "player_description", value: player_description))
           self.queryItems.append(NSURLQueryItem(name: "miles_radius", value: miles_radius))
            
        //Set post method
        self.method = .POST
           
           //Make request and get data back
           self.getData(url: self.userApiUrl) {(apiData) -> Void in
               let json = JSON(data: apiData!)
               print(json)
               
               //call completion handler
               completion(json)
           }
       }
    
    func setOfficialAccount(official_image:String, sertificate:String, years_of_experience:String,
                         officiating_fee:String, official_description:String,
          miles_radius: String,
        completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "setOfficialAccount"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        self.queryItems.append(NSURLQueryItem(name: "official_image", value: official_image))
        self.queryItems.append(NSURLQueryItem(name: "sertificate", value: sertificate))
        self.queryItems.append(NSURLQueryItem(name: "years_of_experience", value: years_of_experience))
        self.queryItems.append(NSURLQueryItem(name: "officiating_fee", value: officiating_fee))
        self.queryItems.append(NSURLQueryItem(name: "official_description", value: official_description))
        self.queryItems.append(NSURLQueryItem(name: "miles_radius", value: miles_radius))
         
     //Set post method
     self.method = .POST
        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    
    func connectToTeam(team_id: String,
        completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "connectToTeam"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        self.queryItems.append(NSURLQueryItem(name: "team_id", value: team_id))

     //Set post method
     self.method = .POST
        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func connectToPlayer(player_id: String,
        completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "connectToPlayer"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        self.queryItems.append(NSURLQueryItem(name: "player_id", value: player_id))

     //Set post method
     self.method = .POST
        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    
    func connectToGame(game_id: String,
        completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "connectToGame"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        self.queryItems.append(NSURLQueryItem(name: "game_id", value: game_id))

     //Set post method
     self.method = .POST
        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func rateGame(game_id: String, rate: String,
        completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "rateGame"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        self.queryItems.append(NSURLQueryItem(name: "game_id", value: game_id))
        self.queryItems.append(NSURLQueryItem(name: "rate", value: rate))

     //Set post method
     self.method = .POST
        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func getGamesHistory(team_id: String,
        completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getGamesHistory"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        self.queryItems.append(NSURLQueryItem(name: "team_id", value: team_id))

     //Set post method
     self.method = .POST
        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func resendCode(completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "resendCode"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            completion(json)
        }
    }
    
    
    
    
    func getNotifications(completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getNotifications"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            completion(json)
        }
    }
    
    
    func getTeamDetails(id: String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getTeamDetails"))
        self.queryItems.append(NSURLQueryItem(name: "team_id", value: id))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func getRequests(completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getRequests"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func getMessages(request_id: String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getMessages"))
        self.queryItems.append(NSURLQueryItem(name: "request_id", value: request_id))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    
    
    func getOfficialDetails(id: String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getOfficialDetails"))
        self.queryItems.append(NSURLQueryItem(name: "official_id", value: id))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func getPlayerDetails(id: String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getPlayerDetails"))
        self.queryItems.append(NSURLQueryItem(name: "player_id", value: id))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func getCoachDetails(id: String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getCoachDetails"))
        self.queryItems.append(NSURLQueryItem(name: "coach_id", value: id))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func getRefereedHistory(official_id: String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getRefereedHistory"))
        self.queryItems.append(NSURLQueryItem(name: "official_id", value: official_id))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func connectToTeam(id: String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "connectToTeam"))
        self.queryItems.append(NSURLQueryItem(name: "team_id", value: id))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    
    
    func searchTeams(lon: String, lat: String, home_field_available:String, looking_date:String, flexible_on_date:String, day_period:String, flexible_on_time:String, need_players:String, miles_radius:String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "searchTeams"))
        self.queryItems.append(NSURLQueryItem(name: "lon", value: lon))
        self.queryItems.append(NSURLQueryItem(name: "lat", value: lat))
        self.queryItems.append(NSURLQueryItem(name: "home_field_available", value: home_field_available))
        self.queryItems.append(NSURLQueryItem(name: "looking_date", value: looking_date))
        self.queryItems.append(NSURLQueryItem(name: "flexible_on_date", value: flexible_on_date))
        self.queryItems.append(NSURLQueryItem(name: "day_period", value: day_period))
        self.queryItems.append(NSURLQueryItem(name: "flexible_on_time", value: flexible_on_time))
        self.queryItems.append(NSURLQueryItem(name: "need_players", value: need_players))
        self.queryItems.append(NSURLQueryItem(name: "miles_radius", value: miles_radius))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func searchPlayers(lon: String, lat: String, home_field_available:String, looking_date:String, flexible_on_date:String, day_period:String, flexible_on_time:String, need_players:String, miles_radius:String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "searchPlayers"))
        self.queryItems.append(NSURLQueryItem(name: "lon", value: lon))
        self.queryItems.append(NSURLQueryItem(name: "lat", value: lat))
        self.queryItems.append(NSURLQueryItem(name: "home_field_available", value: home_field_available))
        self.queryItems.append(NSURLQueryItem(name: "looking_date", value: looking_date))
        self.queryItems.append(NSURLQueryItem(name: "flexible_on_date", value: flexible_on_date))
        self.queryItems.append(NSURLQueryItem(name: "day_period", value: day_period))
        self.queryItems.append(NSURLQueryItem(name: "flexible_on_time", value: flexible_on_time))
        self.queryItems.append(NSURLQueryItem(name: "need_players", value: need_players))
        self.queryItems.append(NSURLQueryItem(name: "miles_radius", value: miles_radius))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    

    func searchOfficials(lon: String, lat: String, home_field_available:String, looking_date:String, flexible_on_date:String, day_period:String, flexible_on_time:String, need_players:String, miles_radius:String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "searchOfficials"))
        self.queryItems.append(NSURLQueryItem(name: "lon", value: lon))
        self.queryItems.append(NSURLQueryItem(name: "lat", value: lat))
        self.queryItems.append(NSURLQueryItem(name: "home_field_available", value: home_field_available))
        self.queryItems.append(NSURLQueryItem(name: "looking_date", value: looking_date))
        self.queryItems.append(NSURLQueryItem(name: "flexible_on_date", value: flexible_on_date))
        self.queryItems.append(NSURLQueryItem(name: "day_period", value: day_period))
        self.queryItems.append(NSURLQueryItem(name: "flexible_on_time", value: flexible_on_time))
        self.queryItems.append(NSURLQueryItem(name: "need_players", value: need_players))
        self.queryItems.append(NSURLQueryItem(name: "miles_radius", value: miles_radius))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    func searchGames(lon: String, lat: String, home_field_available:String, looking_date:String, flexible_on_date:String, day_period:String, flexible_on_time:String, need_players:String, miles_radius:String, completion:@escaping (_ status: JSON) -> Void) {
        
        //Add all needed params
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "action", value: "searchGames"))
        self.queryItems.append(NSURLQueryItem(name: "lon", value: lon))
        self.queryItems.append(NSURLQueryItem(name: "lat", value: lat))
        self.queryItems.append(NSURLQueryItem(name: "home_field_available", value: home_field_available))
        self.queryItems.append(NSURLQueryItem(name: "looking_date", value: looking_date))
        self.queryItems.append(NSURLQueryItem(name: "flexible_on_date", value: flexible_on_date))
        self.queryItems.append(NSURLQueryItem(name: "day_period", value: day_period))
        self.queryItems.append(NSURLQueryItem(name: "flexible_on_time", value: flexible_on_time))
        self.queryItems.append(NSURLQueryItem(name: "need_players", value: need_players))
        self.queryItems.append(NSURLQueryItem(name: "miles_radius", value: miles_radius))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
     

        
        //Make request and get data back
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            
            //call completion handler
            completion(json)
        }
    }
    
    
    func resetPassword(data:[NSURLQueryItem], completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        self.queryItems = data
        self.queryItems.append(NSURLQueryItem(name: "action", value: "resetPassword"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            completion(json)
        }
    }
    
    func getTempData() -> Data
    {
        let apiData = "[{\"name\":\"Sess One\",\"imageUrl\":\"https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500\"},{\"name\":\"Sess Two\",\"imageUrl\":\"https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260\"}]".data(using: .utf8)
        return apiData!
    }
    
    
    func urlEncode(string: String) -> String
    {
        var newString = string.replacingOccurrences(of: "+", with: "-")
        newString = newString.replacingOccurrences(of: "/", with: "_")
        return newString
    }
    
    
    
    private func getUrlComponets(url: String) -> NSURLComponents {
        
        let urlComps = NSURLComponents(string: url)!
        
        let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        self.queryItems.append(NSURLQueryItem(name: "version", value: version))
        self.queryItems.append(NSURLQueryItem(name: "platform", value: "ios"))
        var stringArray = [String]()
        stringArray = self.queryItems.compactMap { $0.value! as String }
        let flattenValues = stringArray.joined(separator: "")
        //print(flattenValues)
        let signature = self.urlEncode(string: flattenValues.HMACsha256(key: self.privateKey))
        self.queryItems.append(NSURLQueryItem(name: "key", value: signature))
        
        
        urlComps.queryItems = self.queryItems as [URLQueryItem]?
        return urlComps
    }
    
    private func getData(url: String, success: @escaping ((_ apiData: Data?) -> Void)) {
        
        print(url)
        loadDataFromURL(urlString: url, completion:{(data, error) -> Void in
         
            if let urlData = data {
                let json = JSON(data: urlData)
                if(json["status"] == "fail")
                {
                    if(json["message"] == "token_expired")
                    {
                        DispatchQueue.main.async(execute: {
                            
                            User.logout()
                            AbstractViewController.goToController(modifier: "LoginController")
                        })
                    }
                    //print(json["result"])
                }else{
                    //print(json["message"])
                }
                success(urlData)
            }else{
                let apiData = "{\"status\":\"fail\",\"message\":\"Failed request\",\"result\":[]}".data(using: .utf8)
                success(apiData)
            }
        })
    }
    
    private func loadDataFromURL(urlString: String, completion:@escaping (_ data: Data?, _ error: NSError?) -> Void) {
        
        var url = URL(string: urlString)! //change the url
        let session = URLSession.shared
        let urlComponents = self.getUrlComponets(url: urlString)
        
        if(self.method == .GET)
        {
            let urlWithQuery = urlComponents.url!
            url = urlWithQuery
            print(urlWithQuery)
        }

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue //set http method
        
        if(self.method == .POST)
        {
            request.httpBody = Data(urlComponents.url!.query!.utf8)
        }
        
        
        //Return to default method
        self.method = .GET
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if data != nil {
                print(String(data: data!, encoding: .utf8))
            }
            
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.lepsha", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    
                    completion(nil, statusError)
                } else {
                    if data != nil {
                        completion(data, nil)
                    }
                }
            }
        })
        loadDataTask.resume()
    }
}
