import Foundation

public struct Carsize: Codable {

    var height: Double
    var width: Double
}

public enum CarType: String, Codable {
    
    case SUV
    case Sedan
    case Unknown
}

public class Car: Codable {
    
    var name: String
    var brand: String
    var yearOfManufacturer: Date
    var isNew: Bool
    var vechicleType: CarType
    var carSize: Carsize
    
    public init(name: String, brand: String, yearOfManufacturer: Date, isNew: Bool, vechicleType: CarType, carHeight: Double, carWidth: Double) {
     
        self.name = name
        self.brand = brand
        self.yearOfManufacturer = yearOfManufacturer
        self.isNew = isNew
        self.vechicleType = vechicleType
        self.carSize = Carsize(height: carHeight, width: carWidth)
    }
}
