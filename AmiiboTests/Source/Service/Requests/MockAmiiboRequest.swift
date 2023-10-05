//
//  MockAmiiboRequest.swift
//  AmiiboTests
//
//  Created by Rodrigo Valladares on 13/6/23.
//

import Foundation
import Combine
@testable import Amiibo

enum MockAmiiboRequest {
    case getSeriesList
    case getGameSeriesList
    case getSerie(input: String)
    case getGameSerie(input: String)
    case getAmiiboImage(url: String)
}

extension MockAmiiboRequest: RequestType {
var builder: NetworkRequesterType {
    switch self {
    case .getSeriesList:
        
        return QueryRequester(urlString: "amiiboList")
    case .getGameSeriesList:
        
        return QueryRequester(urlString: "amiiboList")
    case .getSerie:
        
        return QueryRequester(urlString: "amiiboSeriesList")
    case .getGameSerie:
        
        return QueryRequester(urlString: "amiiboSeriesList")
    case let .getAmiiboImage(url):
        
        return QueryRequester(urlString: url)
    }
}
}
