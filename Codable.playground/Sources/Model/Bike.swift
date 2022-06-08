import Foundation

public class Bike: NSObject, Codable {
    
    var name: String
    var brand: String
    //Info: For Decodable Protocol, we need to pass default values to the properties that are not added to the coding keys. The default value will be added to class or struct recieved on decoding JSON.
    var cc: Int = 0
    var isNew: Bool = true
    
    //Info: Only the properties adding in CodingKeys enum will be Encoded and Decoded
    enum CodingKeys: String, CodingKey {
        case name
        case brand
    }
        
    public init(name:String, brand: String, cc: Int, isNew: Bool) {
        
        self.name = name
        self.brand = brand
        self.cc = cc
        self.isNew = isNew
    }
}
