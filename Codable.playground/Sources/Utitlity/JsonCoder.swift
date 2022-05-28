import Foundation

/*
 Note:
 Encoding is essentially a writing process, whereas decoding is a reading process.
 Encoding breaks a spoken word down into parts that are written or spelled out,
 while decoding breaks a written word into parts that are verbally spoken.
 */
class JsonCoder {
    
    static let shared = JsonCoder()
    
    private init() { }
    
    /*
     A method to encode a model of type T to JSON
     */
    func encode<T: Encodable>(_ model: T) -> String? {
        let encodeModel = try! JSONEncoder().encode(model)
        return String(data: encodeModel, encoding: .utf8)
    }
    
    /*
     A method to decode a model of type T from JSON string
     */
    func decode<T: Decodable>(type: T.Type, jsonString: String?) -> T? {
        if let json = jsonString?.data(using: .utf8) {
            let newObject: T = try! JSONDecoder().decode(T.self, from: json)
            return newObject
        }
        return nil
    }
}
