//
//  RemoteDataSource.swift
//  Gamietory
//
//  Created by Ryo Martin on 27/06/24.
//

import Foundation
import Combine

protocol RemoteDataSourceProtocol {
    func fetchGames() -> AnyPublisher<[GameResponse], Error>
}

final class RemoteDataSource: NSObject {
    private override init() { }

    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func fetchGames() -> AnyPublisher<[GameResponse], any Error> {
        var urlComponents = URLComponents(string: Constants.baseURL)!
            urlComponents.queryItems = [
              URLQueryItem(name: "key", value: Constants.apiKey)
            ]

            guard let url = urlComponents.url else {
              return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET" // Assuming the API endpoint requires a GET request

            return URLSession.shared.dataTaskPublisher(for: urlRequest)
              .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                  throw URLError(.badServerResponse)
                }
                return data
              }
              .decode(type: GameResponse.self, decoder: JSONDecoder())
              .map { [$0] }
              .eraseToAnyPublisher()
    }

    func decodeJson(from data: Data, completion: @escaping (GameResponse?, Error?) -> Void) {
        let decoder = JSONDecoder()

        if let games = try? decoder.decode(GameResponse.self, from: data) as GameResponse {
            print("Page: \(games.count)")
            print("result: \(games.results)")
            completion(games, nil)
        } else {
            print("Cant decode json")
        }
    }
}
