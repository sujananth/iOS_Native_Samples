import Foundation

enum ApiError: Error {
    case noResponse
    case modelCreation
    case unrecognizedUrl
    case unknownData
}

protocol ApiResource {
    associatedtype model: Decodable
}

extension ApiResource {
    
    /*
     Note:
     
     Serializing is about moving structured data over a storage/transmission medium
     in a way that the structure can be maintained.
     
     Encoding is more broad, like about how said data is converted to different forms, etc.
     */
    func serialize(data: Data) -> Data {
        do {
            try JSONSerialization.jsonObject(with: data)
            return data
        } catch {
            return Data("{}".utf8)
        }
    }
    
    func downloadAndDecode<T>(of type: T, from url: URL, completion: @escaping (_ error: Error?, _ data: T?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let _ = error else {
                completion(error, nil)
                return
            }

//            let serializedData = serialize(data: data)
//            completion(error, data)
        }.resume()
    }
}
