//
//  Game.swift
//  Scrimmage Search
//
//  Created by Arsen Leontijevic on 09/03/2020.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import Foundation

struct Game {
    
    var json: JSON
    
    
    init(json: JSON) {
        self.json = json
    }
    var id: String? {
        return json["id"].string
    }
    var created_by: String? {
        return json["created_by"].string
    }
    var created_on: String? {
        return json["created_on"].string
    }
    var city: String? {
        return json["city"].string
    }
    var address: String? {
        return json["address"].string
    }
    var state: String? {
        return json["state"].string
    }
    var zip_code: String? {
        return json["zip_code"].string
    }
    var lat: String? {
        return json["lat"].string
    }
    var lon: String? {
        return json["lon"].string
    }
    var date_and_time: String? {
        return json["date_and_time"].string
    }
    var description: String? {
        return json["description"].string
    }
    var sport_id: String? {
        return json["sport_id"].string
    }
    
    var age_group: String? {
        return json["age_group"].string
    }
    
    var team_one: String? {
        return json["team_one"].string
    }
    
    var team_two: String? {
        return json["team_two"].string
    }
    var coach_name: String? {
        return json["coach_name"].string
    }
    
}
