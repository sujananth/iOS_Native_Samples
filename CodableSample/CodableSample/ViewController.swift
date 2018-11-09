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

class ViewController: UIViewController {
    
//    let downloadURLString = "https://api.punkapi.com/v2/beers"
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        //Decoding and Encoding Car using Codable, locally
        
        let car = Car(name: "Alto", brand: "Maruthi Suzuki", yearOfManufacturer: Date(timeIntervalSinceReferenceDate: -123456789.0), isNew: true, vechicleType: .Unknown, carHeight: 100, carWidth: 172)
        let carJsonString = self.encodeCarIntoJson(car)
        self.decodeJsonIntoCar(carJsonString)
        
        
        //Encoding Specific properties using CodingKeys and Decoding with additional properties of class, locally
        
        let bike = Bike(name: "Unicorn", brand: "Honda", cc: 160, isNew: false)
        let bikeJsonString = self.encodeBikeSpecificPropertiesToJson(bike)
        self.decodeBikeJsonWithAdditionalBikePropertiesFrom(bikeJsonString)
        
        //        guard let downlaodURL = URL(string: downloadURLString)  else {
        //            return
        //        }
        //        self.downloadJsonFrom(downlaodURL)
    }
    
//    func downloadJsonFrom(_ downloadURL: URL) {
//
//        let jsonDownloadTask = URLSession.shared.dataTask(with: downloadURL) { (downloadedData, response, error) in
//
//            guard let dataResponse = downloadedData, error == nil else {
//                print(error?.localizedDescription ?? "Response error")
//                return
//            }
//            do{
//                let decoder = JSONDecoder()
//                let ingredientsData = try decoder.decode([].self, from: dataResponse)
//                print(ingredientsData)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        jsonDownloadTask.resume()
//    }
}

extension EncodeDecodeUsingCodable {
    
    func encodeCarIntoJson(_ car: Car?) -> String? {
        let encodedCar = try? JSONEncoder().encode(car)
        if let encodedJSONString = String(data: encodedCar!, encoding: .utf8) {
            print(encodedJSONString)
            return encodedJSONString
        }
        return nil
    }
    
    func decodeJsonIntoCar(_ jsonString: String?) {
        if let carJson = jsonString?.data(using: .utf8) {
            let newCar: Car? = try? JSONDecoder().decode(Car.self, from: carJson)
            print(newCar!)
        }
    }
}

extension EncodeDecodeUsingCodingKeys {
    
    func encodeBikeSpecificPropertiesToJson(_ bike: Bike?) -> String? {
        let encodeBike = try? JSONEncoder().encode(bike)
        if let encodedJSONString = String(data: encodeBike!, encoding: .utf8) {
            print(encodedJSONString)
            return encodedJSONString
        }
        return nil
    }
    
    func decodeBikeJsonWithAdditionalBikePropertiesFrom(_ jsonString: String?) {
        if let bikeJson = jsonString?.data(using: .utf8) {
            let newBike: Bike = try! JSONDecoder().decode(Bike.self, from: bikeJson)
            print(newBike)
        }
    }
}

