//
//  QueryRequesterTest.swift
//  AmiiboTests
//
//  Created by Rodrigo Valladares on 13/6/23.
//

import XCTest
import Combine
@testable import Amiibo

class QueryRequesterTest: XCTestCase {
    func testRequest() {
        // Given
        let request = QueryRequester(urlString: "amiibo")
        let expectation = XCTestExpectation(description: "testing request function")
        var cancellable = Set<AnyCancellable>()
        var data: Data = Data()
        var errorRequest: String = ""
        
        // When
        request
            .performRequest()
            .sink { response in
                guard case let .failure(error) = response else { return }
                
                errorRequest = error.localizedDescription
                expectation.fulfill()
            } receiveValue: { response in
                data = response
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 30)

        // Then
        XCTAssertNotNil(cancellable, "Theres no subcriber")
        XCTAssertEqual(data.count, 0, "Theres no conecction, data is 0")
        XCTAssertEqual(errorRequest, "unsupported URL", "The url is not correct")
    }
}
