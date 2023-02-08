import Alamofire
import Foundation

public protocol ApiManagerProtocol {
    func fetch<T: Decodable>(url: String, parameters: [String:String]?, handler: @escaping (T?)->())
}

public final class ApiManager: ApiManagerProtocol {
    
    public static let shared = ApiManager()
    
    public func fetch<T>(url: String, parameters: [String : String]? = nil, handler: @escaping (T?) -> ()) where T : Decodable {
        AF.request(
            url, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString)
        ).response { response in
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                if let data = response.data, let result = try? decoder.decode(T.self, from: data) {
                    handler(result)
                } else {
                    print("Error! Could not parse server results")
                }
            case let .failure(error):
                print("Error! \(error)")
            }
        }
    }
}
