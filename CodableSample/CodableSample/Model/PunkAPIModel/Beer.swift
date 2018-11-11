//
//  Beer.swift
//  CodableSample
//
//  Created by Sujananth on 11/10/18.
//  Copyright © 2018 sujananth. All rights reserved.
//

import Foundation

class Beer: Codable {
    
    var name: String
    var description: String
    var volume: Volume
    var ingredients: Ingredients
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case volume
        case ingredients
    }
}
