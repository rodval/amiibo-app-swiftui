//
//  MockQueryRequester.swift
//  AmiiboTests
//
//  Created by Rodrigo Valladares on 12/6/23.
//

import Foundation
import Combine
@testable import Amiibo

class MockQueryRequester: NetworkRequesterType {
    let urlString: String = ""
    
    func performRequest() -> AnyPublisher<Data, Error> {
        return Future<Data, Error> { completion in
            do {
                if let data = FileParser.readLocalFile(forName: self.urlString) {
                    completion(.success(data))
                }
                throw ErrorFile.tryParserFile
            } catch {
                completion(.failure(ErrorFile.tryParserFile))
            }
        }.eraseToAnyPublisher()
    }
}
