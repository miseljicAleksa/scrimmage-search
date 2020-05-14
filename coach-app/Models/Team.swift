//
//  Notification.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/13/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import Foundation

struct Team {
    
    var json: JSON
    
    
    init(json: JSON) {
        self.json = json
    }
    var id: String? {
        return json["id"].string
    }
    var team_name: String? {
        return json["team_name"].string
    }
    var team_gender: String? {
           return json["team_gender"].string
       }
    var age_group: String? {
           return json["age_group"].string
       }
    var team_description: String? {
        return json["team_description"].string
    }
    var user_id: String? {
        return json["user_id"].string
    }
    var team_image: String? {
        return json["team_image"].string
    }
    var team_rate: String? {
        return json["team_rate"].string
    }
    var team_zip_code: String? {
        return json["team_rating"].string
    }
    var created_on: String? {
        return json["created_on"].string
    }
    
    var team_logo: String? {
          return json["team_logo"].string
      }
    var coach_name: String? {
          return json["coach_name"].string
      }
    
    var distance: Double? {
        return json["distance"].double
    }
    
}
