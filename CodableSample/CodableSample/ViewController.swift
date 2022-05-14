//
//  ViewController.swift
//  CodableSample
//
//  Created by Sujananth on 10/14/18.
//  Copyright © 2018 sujananth. All rights reserved.
//

import UIKit

typealias EncodeDecodeUsingCodable = ViewController
typealias EncodeDecodeUsingCodingKeys = ViewController
typealias DecodingSpecificPropertiesFromJSON = ViewController

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //MARK: EncodeDecodeUsingCodable
        //Decoding and Encoding Car using Codable, locally
        let car = Car(name: "Alto", brand: "Maruthi Suzuki", yearOfManufacturer: Date(timeIntervalSinceReferenceDate: -123456789.0), isNew: true, vechicleType: .Unknown, carHeight: 100, carWidth: 172)
        let carJsonString = encode(car)
        decode(type: Car.self, jsonString: carJsonString)
        
        //MARK: EncodeDecodeUsingCodingKeys
        //Encoding Specific properties using CodingKeys and Decoding with additional properties of class, locally
        /*
         As mentioned in the model class additional properties not listed in codingkeys must given a defaukt value.
         */
        let bike = Bike(name: "Unicorn", brand: "Honda", cc: 160, isNew: false)
        let bikeJsonString = self.encode(bike)
        decode(type: Bike.self, jsonString: bikeJsonString)
        
        //MARK: PUNK API Sample
        //Decoding Array of beer data from Punk API
        let downloadURLString = "https://api.punkapi.com/v2/beers"
        let downloadURL = URL(string: downloadURLString)!
        downloadAndDecodeBeer(downloadURL)
    }
    
    func encode<T: Encodable>(_ model: T) -> String? {
        let encodeModel = try! JSONEncoder().encode(model)
        let encodedJsonString = String(data: encodeModel, encoding: .utf8)
        print(encodedJsonString!)
        return encodedJsonString
    }
    
    func decode<T: Decodable>(type: T.Type, jsonString: String?) {
        if let json = jsonString?.data(using: .utf8) {
            let newObject: T = try! JSONDecoder().decode(T.self, from: json)
            print(newObject)
        }
    }
}

extension DecodingSpecificPropertiesFromJSON {
    
    func downloadAndDecodeBeer(_ downloadURL: URL) {
        let jsonDownloadTask = URLSession.shared.dataTask(with: downloadURL) { (downloadedData, response, error) in
            let beerList: [Beer] = try! JSONDecoder().decode([Beer].self, from: downloadedData!)
            print(beerList)
        }
        jsonDownloadTask.resume()
    }
}
