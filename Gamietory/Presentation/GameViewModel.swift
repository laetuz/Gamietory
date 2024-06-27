//
//  GameViewModel.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var gameResponses: GameResponse?
    @Published var gameResponsess: [GameResponse]?
    private var cancellables: Set<AnyCancellable> = []
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

    private let useCase: FetchGamesUseCaseProtocol

    init(
        gameResponses: GameResponse? = nil, gameResponsess: [GameResponse]? = nil,
        gameDetailResponses: GameDetailResponse? = nil, errorMessage: String? = nil, isLoading: Bool = false, useCase: FetchGamesUseCaseProtocol) {
        self.gameResponses = gameResponses
        self.gameResponsess = gameResponsess
        self.gameDetailResponses = gameDetailResponses
        self.errorMessage = errorMessage
        self.isLoading = isLoading
        self.useCase = useCase
    }
//    init(gameResponses: GameResponse? = nil, gameDetailResponses: GameDetailResponse? = nil, errorMessage: String? = nil, isLoading: Bool = false, useCase: FetchGamesUseCaseProtocol) {
//        self.gameResponses = gameResponses
//        self.gameDetailResponses = gameDetailResponses
//        self.errorMessage = errorMessage
//        self.isLoading = isLoading
//        self.useCase = useCase
//    }

    func fetchGamesFromUseCase() {
        useCase.fetchGames()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { games in
                self.gameResponses = games
            })
            .store(in: &cancellables)
    }
}
