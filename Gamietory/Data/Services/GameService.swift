//
//  GameService.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import Foundation

class GameService: ObservableObject {

    func main(completion: @escaping (GameResponse?, Error?) -> Void) {
        var components = URLComponents(string: Constants.baseURL)!

        components.queryItems = [
            URLQueryItem(name: "key", value: Constants.apiKey)
        ]

        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {return}

            if let data = data {
                if response.statusCode == 200 {
                    self.decodeJson(from: data) { games, error in
                        completion(games, error)
                    }
                    print("Data: \(data), status: \(response.statusCode)")
                }
            }
        }

        task.resume()
    }

    func gameDetail(id: Int64, completion: @escaping (GameDetailResponse?, Error?) -> Void) {

        var components = URLComponents(string: "https://api.rawg.io/api/games/\(id)")!

        components.queryItems = [URLQueryItem(name: "key", value: Constants.apiKey)]

        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {return}

            if let data = data {
                if response.statusCode == 200 {
                    self.decodeDetailJson(from: data) { games, error in
                        completion(games, error)
                    }
                    print("Data: \(data), status: \(response.statusCode)")
                }
            }
        }

        task.resume()
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

    func decodeDetailJson(from data: Data, completion: @escaping (GameDetailResponse?, Error?) -> Void) {
        let decoder = JSONDecoder()

        if let games = try? decoder.decode(GameDetailResponse.self, from: data) as GameDetailResponse {
            print("Page: \(games.id)")
            print("result: \(games.name)")
            completion(games, nil)
        } else {
            print("Cant decode json")
        }
    }
}
