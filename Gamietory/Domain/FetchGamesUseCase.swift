//
//  FetchGamesUseCase.swift
//  Gamietory
//
//  Created by Ryo Martin on 27/06/24.
//

import Foundation
import Combine

protocol FetchGamesUseCaseProtocol {
    func fetchGames() -> AnyPublisher<GameResponse, Error>
}

class FetchGamesUseCase: FetchGamesUseCaseProtocol {
    private let remoteDataSource: RemoteDataSourceProtocol
    
    init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchGames() -> AnyPublisher<GameResponse, any Error> {
        return remoteDataSource.fetchGames()
            .map { $0.first }
            .compactMap{$0}
            .eraseToAnyPublisher()
    }
}
