//
//  ViewController.swift
//  CodableSample
//
//  Created by Sujananth on 10/14/18.
//  Copyright © 2018 sujananth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    let downloadURLString = "https://api.punkapi.com/v2/beers"
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let car = Car(name: "Alto", brand: "Maruthi Suzuki", yearOfManufacturer: Date(timeIntervalSinceReferenceDate: -123456789.0), isNew: true, vechicleType: .Unknown, carHeight: 100, carWidth: 172)
        let carJsonString = self.encodeCarIntoJson(car)
        self.decodeJsonIntoCar(carJsonString)
        
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
            
            let newCar: Car = try! JSONDecoder().decode(Car.self, from: carJson)
            print(newCar)
        }
    }
}

