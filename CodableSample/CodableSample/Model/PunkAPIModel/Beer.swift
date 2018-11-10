//
//  Beer.swift
//  CodableSample
//
//  Created by Sujananth on 11/10/18.
//  Copyright © 2018 sujananth. All rights reserved.
//

import Foundation

class Beer: Codable {
    
    var name: String = "Unknown"
    var description: String = "Unknown"
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
    }
}
