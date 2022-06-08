import Foundation

/*
 Codable is typealias that conforms to both Encodable and Decodable
 */
public struct Beer: Codable {
    var name: String
    var description: String
    var volume: Volume
    var ingredients: Ingredients
}

public struct Volume: Codable {
    var value: Int
    var unit: String
}

public struct Ingredients: Codable {
    var malt: [Malt]
    var yeast: String
}

/*
 Note: In Malt model using CodingKeys to rename the key
        availble from json to maltName
 */
public struct Malt: Codable {
    var maltName: String
    var amount: Amount
    
    enum CodingKeys: String, CodingKey {
        case maltName = "name"
        case amount
    }
}

public struct Amount: Codable {
    var value: Float
    var unit: String
}
