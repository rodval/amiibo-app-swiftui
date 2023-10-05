//
//  NetworkManager.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import Foundation
import Combine

protocol NetworkManagerType {
    func perform(request: RequestType) -> AnyPublisher<Data, Error>
}

extension NetworkManagerType {
    func perform<T>(request: RequestType,
                    using decoder: JSONDecoder = .init()) -> AnyPublisher<T, Error> where T : Decodable {
        perform(request: request)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

// MARK: Protocol Dependency
protocol HasNetworkManagerType {
    var networkManager: NetworkManagerType { get }
}

struct NetworkManager: NetworkManagerType {
    func perform(request: RequestType) -> AnyPublisher<Data, Error> {
        request.builder.performRequest()
    }
}
