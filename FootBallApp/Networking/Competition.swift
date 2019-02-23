//
//  Competition.swift
//  FootBallApp
//
//  Created by hind on 2/21/19.
//  Copyright © 2019 hind. All rights reserved.
//

import Foundation
struct Competition: Codable
{
    let CompetionId: Int
    let CompetioName: String
    
    
    
    init(CompetionId:  Int , CompetioName:  String) {
         self.CompetionId = CompetionId
        self.CompetioName = CompetioName
        
    }
}
