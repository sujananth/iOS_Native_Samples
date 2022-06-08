import Foundation

enum CodableError: Error {
    case decodingError
}

public class ApiResource {
    
    public static let shared = ApiResource()
    
    private init() { }
    
    public func downloadAndDecode<T: Decodable>(model: T.Type, from url: URL, completion: @escaping (_ error: Error?, _ data: T?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let responseData = data else {
                completion(error, nil)
                return
            }
            do {
                let decodedModel = try JSONDecoder().decode(model.self, from: responseData)
                completion(nil, decodedModel)
            } catch {
                completion(CodableError.decodingError ,nil)
            }
        }.resume()
    }
}
