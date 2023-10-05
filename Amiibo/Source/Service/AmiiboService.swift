//
//  AmiiboService.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import Foundation
import Combine

// MARK: Protocol
protocol AmiiboServiceType {
    func getSeriesList() -> AnyPublisher<AmiiboListResponse, Error>
    func getGameSeriesList() -> AnyPublisher<AmiiboListResponse, Error>
    func getSerieDetail(serie: String) -> AnyPublisher<AmiiboSerieDetailListResponse, Error>
    func getGameSerieDetail(gameSerie: String) -> AnyPublisher<AmiiboSerieDetailListResponse, Error>
    func getAmiiboImage(url: String) -> AnyPublisher<Data, Error>
}

// MARK: Dependency Protocol
protocol HasAmiiboServiceType {
    var amiiboServiceType: AmiiboServiceType { get }
}

// MARK: - Smart Transfer Service
struct AmiiboService: AmiiboServiceType {
    // MARK: - Alias
    typealias Dependencies = HasNetworkManagerType
    
    // MARK: - Properties
    private let dependencies: Dependencies
    
    // MARK: - Initialization
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getSeriesList() -> AnyPublisher<AmiiboListResponse, Error> {
        dependencies
            .networkManager
            .perform(request: AmiiboRequest.getSeriesList)
            .eraseToAnyPublisher()
    }
    
    func getGameSeriesList() -> AnyPublisher<AmiiboListResponse, Error> {
        dependencies
            .networkManager
            .perform(request: AmiiboRequest.getGameSeriesList)
            .eraseToAnyPublisher()
    }

    func getSerieDetail(serie: String) -> AnyPublisher<AmiiboSerieDetailListResponse, Error> {
        dependencies
            .networkManager
            .perform(request: AmiiboRequest.getSerie(input: serie))
            .eraseToAnyPublisher()
    }
    
    func getGameSerieDetail(gameSerie: String) -> AnyPublisher<AmiiboSerieDetailListResponse, Error> {
        dependencies
            .networkManager
            .perform(request: AmiiboRequest.getGameSerie(input: gameSerie))
            .eraseToAnyPublisher()
    }
    
    func getAmiiboImage(url: String) -> AnyPublisher<Data, Error> {
        dependencies
            .networkManager
            .perform(request: AmiiboRequest.getAmiiboImage(url: url))
            .eraseToAnyPublisher()
    }
}

// MARK: Dependencies
struct AmiiboServiceDependencies: HasNetworkManagerType {
    let networkManager: NetworkManagerType = NetworkManager()
}
