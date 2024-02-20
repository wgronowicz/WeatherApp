import Foundation

protocol Request {
    var method: RequestType { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

extension Request {
    func request(with baseUrl: URL) -> URLRequest {
        guard var components = URLComponents(
            url: baseUrl.appendingPathComponent(path),
            resolvingAgainstBaseURL: false) 
        else {
            fatalError("Unable to create URL components")
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return request
    }
}

enum RequestType: String {
    case GET
}
