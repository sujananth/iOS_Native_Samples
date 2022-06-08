import Foundation

/*
 Note:
 Encoding is essentially a writing process, whereas decoding is a reading process.
 Encoding breaks a spoken word down into parts that are written or spelled out,
 while decoding breaks a written word into parts that are verbally spoken.
 */

public class JsonCoder {
    
    public static let shared = JsonCoder()
    
    private init() { }
    
    /*
     To encode a model,
     First, we encode using JSONEncoder
     Second, convert the encoded data to String to send it over internet or save.
     */
    public func encode<T: Encodable>(model: T) -> String? {
        var encodedJsonString: String? = nil
        do {
            let encodedModel = try JSONEncoder().encode(model)
            encodedJsonString = String(data: encodedModel, encoding: .utf8)
        } catch {
            print("Encoding Error for model: \(model)")
        }
        return encodedJsonString
    }
    
    
    /*
     To decode a model,
     First, we convert the string to Data
     Second, pass the data and expected model type to decoder to decode.
     */
    public func decode<T: Decodable>(modelType: T.Type, jsonString: String?) -> T? {
        var model: T? = nil
        guard let json = jsonString?.data(using: .utf8) else {
            return nil
        }
        do {
            model = try JSONDecoder().decode(modelType, from: json)
        } catch {
            print("Decoding Error for model: \(modelType)")
        }
        return model
    }
}
