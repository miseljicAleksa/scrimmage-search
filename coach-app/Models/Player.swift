//
//  Player.swift
//  Scrimmage Search
//
//  Created by alk msljc on 3/17/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import Foundation

struct Player {
    
    var json: JSON
    
    
    init(json: JSON) {
        self.json = json
    }
    var id: String? {
        return json["id"].string
    }
    
    var zip_code: String? {
        return json["zip_code"].string
    }
    
    var player_name: String? {
        return json["player_name"].string
    }
    
    var date_of_birth: String? {
        return json["date_of_birth"].string
    }
    
    var years_of_experience: String? {
           return json["years_of_experience"].string
    }
    
    var interested_in: String? {
        return json["interested_in"].string
    }
    
    var player_image: String? {
        return json["player_image"].string
    }
    
    var team_name: String? {
        return json["team_name"].string
    }
    
    var player_description: String? {
        return json["player_description"].string
    }
    
    var distance: String? {
        return json["distance"].string
    }
    
}
