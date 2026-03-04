import Foundation
import Combine

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error>
}

struct Endpoint {
    let path: String
    let method: String
    var body: Data?
}

final class APIClient: APIClientProtocol {
    private let baseURL: URL
    private let session: URLSession
    private let tokenProvider: () -> String?

    init(baseURL: URL, session: URLSession = .shared, tokenProvider: @escaping () -> String?) {
        self.baseURL = baseURL
        self.session = session
        self.tokenProvider = tokenProvider
    }

    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: baseURL.appendingPathComponent(endpoint.path))
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = tokenProvider() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
