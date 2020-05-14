//
//  Notification.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/13/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import Foundation

struct Official {
    
    var json: JSON
    
    
    init(json: JSON) {
        self.json = json
    }
    var id: String? {
        return json["id"].string
    }
    var name: String? {
        return json["name"].string
    }
    
    var official_image: String? {
        return json["official_image"].string
    }
    
    var sertificate: String? {
        return json["sertificate"].string
    }
    
    var years_of_experience: String? {
        return json["years_of_experience"].string
    }
    
    var officiating_fee: String? {
        return json["officiating_fee"].string
    }
    
    var official_description: String? {
        return json["official_description"].string
    }
    
    var distance: Double? {
        return json["distance"].double
    }
    
    var official_rate: String? {
        return json["official_rate"].string
    }
    
    
}
