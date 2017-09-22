//
//  TeamsModel.swift
//  TheTeam
//
//  Created by Marcin Pietrzak on 16.09.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import Foundation

// I prepare this model for Teams but I don't have enough of time to implement this in code. At the first I focused on make working code and then do some code refactoring.

struct Teams {
    
    let teamID: Int
    let teamLogo: String
    let teamName: String
    
    init(teamID: Int, teamLogo: String, teamName: String) {
        self.teamID = teamID
        self.teamLogo = teamLogo
        self.teamName = teamName
    }
    
}
