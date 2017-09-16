//
//  TeamsModel.swift
//  TheTeam
//
//  Created by Marcin Pietrzak on 16.09.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import Foundation

struct Teams {
    
    let teamID: String
    let teamLogo: String
    let teamName: String
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json: [String:Any]) throws {
        guard let teamID = json["team_id"] as? String else {throw SerializationError.missing("teamID is missing")}
        guard let teamLogo = json["team_logo"] as? String else {throw SerializationError.missing("teamLogo is missing")}
        
        guard let teamName = json["team_name"] as? String else {throw SerializationError.missing("teamName is missing")}
        
        self.teamID = teamID
        self.teamLogo = teamLogo
        self.teamName = teamName
    }
    
}
