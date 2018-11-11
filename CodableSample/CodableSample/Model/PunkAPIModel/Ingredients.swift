//
//  Ingredients.swift
//  CodableSample
//
//  Created by Sujananth on 11/11/18.
//  Copyright © 2018 sujananth. All rights reserved.
//

import UIKit

class Ingredients: Codable {
    
    var malt: [Malt]
    var yeast: String
    
    enum CodingKeys: String, CodingKey {
        case malt
        case yeast
    }
}

class Malt: Codable {
    
    var maltName: String
    var amount: Amount
    
    enum CodingKeys: String, CodingKey {
        case maltName = "name"      //Example for handling different key names in model class and json
        case amount
    }
}

class Amount: Codable {
    
    var value: Float
    var unit: String
}
