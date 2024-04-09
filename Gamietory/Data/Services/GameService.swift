//
//  GameService.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import Foundation

class GameService: ObservableObject {
    let apiKey = "eb89cf8a69374b48a8d2950a1b7e3bfb"
    
    func main(completion: @escaping (GameResponse?, Error?) -> Void) {
        var components = URLComponents(string: "https://api.rawg.io/api/games")!
        
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
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
    
    func gameDetail(completion: @escaping (GameResponse?, Error?) -> Void) {
//        var components = URLComponents(string: "https://api.rawg.io/api/games/{id}")
        var components = URLComponents(string: "https://api.rawg.io/api/games/2")!
        
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        
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
    
    func decodeJson(from data: Data, completion: @escaping (GameResponse?, Error?) -> Void) {
        let decoder = JSONDecoder()
      //  let result = try? decoder.decode(MovieResponses.self, from: data) as MovieResponses
        
        if let games = try? decoder.decode(GameResponse.self, from: data) as GameResponse {
            print("Page: \(games.count)")
            print("result: \(games.results)")
            completion(games, nil)
        } else {
            print("Cant decode json")
        }
    }
}
