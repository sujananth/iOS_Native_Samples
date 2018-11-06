//
//  Car.swift
//  CodableSample
//
//  Created by Sujananth on 11/6/18.
//  Copyright © 2018 sujananth. All rights reserved.
//

import Foundation

struct Carsize: Codable {

    var height: Double
    var width: Double
}

enum CarType: String, Codable {
    
    case SUV
    case Sedan
    case Unknown
}

class Car: Codable {
    
    var name: String
    var brand: String
    var yearOfManufacturer: Date
    var isNew: Bool
    var vechicleType: CarType
    var carSize: Carsize
    
    init(name: String, brand: String, yearOfManufacturer: Date, isNew: Bool, vechicleType: CarType, carHeight: Double, carWidth: Double) {
     
        self.name = name
        self.brand = brand
        self.yearOfManufacturer = yearOfManufacturer
        self.isNew = isNew
        self.vechicleType = vechicleType
        self.carSize = Carsize(height: carHeight, width: carWidth)
    }
}
