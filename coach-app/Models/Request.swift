//
//  Game.swift
//  Scrimmage Search
//
//  Created by Arsen Leontijevic on 09/03/2020.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import Foundation

struct Request {
    
    var json: JSON
    
    
    init(json: JSON) {
        self.json = json
    }
    var id: String? {
        return json["id"].string
    }
    
    var team_id: String? {
        return json["team_id"].string
    }
    
    var player_id: String? {
        return json["player_id"].string
    }
    
    var official_id: String? {
        return json["official_id"].string
    }
    
    var created_on: String? {
        return json["created_on"].string
    }
    
    
    var created_by: String? {
        return json["id"].string
    }
    
    var accepted: String? {
        return json["accepted"].string
    }
    
    var accepted_on: String? {
        return json["accepted_on"].string
    }
    
    var game_id: String? {
        return json["game_id"].string
    }
    
    var status: String? {
        return json["status"].string
    }
    
    var message: String? {
        return json["message"].string
    }
    
    var name: String? {
        return json["name"].string
    }
    
}
