//
//  GameViewModel.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var gameResponses: GameResponse?
    @Published var gameDetailResponses: GameDetailResponse?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    let gamesApi = GameService()
    
    func fetchGames() {
        isLoading = true
        gamesApi.main() { responses, error in
            DispatchQueue.main.async {
                self.isLoading = false
                guard let gameResponse = responses else {
                    self.errorMessage = "Error: \(String(describing: error))"
                    return
                }
                self.gameResponses = gameResponse
            }
            
            if let error = error {
                self.isLoading = false
                self.errorMessage = "error: "
            }
        }
    }
    
    func fetchDetail(id: Int64) {
        isLoading = true
        gamesApi.gameDetail(id: id) { responses, error in
            DispatchQueue.main.async {
                self.isLoading = false
                guard let detailResponse = responses else {
                    self.errorMessage = "dfsdsfd"
                    return
                }
                self.gameDetailResponses = detailResponse
            }
            
            if let error = error {
                self.isLoading = false
                self.errorMessage = "errorr"
            }
        }
    }
}
