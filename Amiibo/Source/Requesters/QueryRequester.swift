//
//  QueryRequester.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import Foundation
import Combine

struct QueryRequester: NetworkRequesterType {
    let urlString: String
    
    func performRequest() -> AnyPublisher<Data, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw NetworkError.badRequest
                }
                if response.statusCode >= 200 && response.statusCode <= 299 {
                    return output.data
                }
                guard let error = NetworkError(rawValue: response.statusCode) else {
                    throw NetworkError.badRequest
                }
                throw error
            }
            .eraseToAnyPublisher()
    }
}
