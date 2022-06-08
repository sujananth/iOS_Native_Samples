import Foundation

/*
 Intro :
  - Codable is a type that conforms to Codable and Decodable protocol.
  - Coding Keys can be used to decode only specific properties or property with different name
  - Using explicit "init(from decoder: Decoder) throws" we can take more control on decoding. 
 */



//MARK: EncodeDecodeUsingCodable
let car = Car(name: "Alto", brand: "Maruthi Suzuki", yearOfManufacturer: Date(timeIntervalSinceReferenceDate: -123456789.0), isNew: true, vechicleType: .Unknown, carHeight: 100, carWidth: 172)
let carJsonString = JsonCoder.shared.encode(model: car)
print("\(carJsonString ?? "") \n")
let decodedCarModel = JsonCoder.shared.decode(modelType: Car.self, jsonString: carJsonString)
print("\(String(describing: decodedCarModel)) \n")



//MARK: EncodeDecodeUsingCodingKeys
/*
 As mentioned in the model class additional properties not listed in codingkeys must given a defaukt value.
 */
let bike = Bike(name: "Unicorn", brand: "Honda", cc: 160, isNew: false)
let bikeJsonString = JsonCoder.shared.encode(model: bike)
let decodedBikeModel = JsonCoder.shared.decode(modelType: Bike.self, jsonString: bikeJsonString)



//MARK: Download and decoding JSON data from an API using Codable
let downloadURLString = "https://api.punkapi.com/v2/beers"
let downloadURL = URL(string: downloadURLString)!
var beerList: [Beer] = []

ApiResource.shared.downloadAndDecode(model: [Beer].self, from: downloadURL) { error, beers in
    beerList = beers ?? []
}
