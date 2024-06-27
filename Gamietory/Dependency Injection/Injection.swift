//
//  Injection.swift
//  Gamietory
//
//  Created by Ryo Martin on 27/06/24.
//

import Foundation

final class Injection: NSObject {
    func provideGamesUseCase() -> FetchGamesUseCaseProtocol {
        let remoteDataSource: RemoteDataSource = RemoteDataSource.sharedInstance
        return FetchGamesUseCase(remoteDataSource: remoteDataSource)
    }
}
