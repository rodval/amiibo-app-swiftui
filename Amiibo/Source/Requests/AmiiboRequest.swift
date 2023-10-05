//
//  AmiiboListRequest.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import Foundation

enum AmiiboRequest {
    case getSeriesList
    case getGameSeriesList
    case getSerie(input: String)
    case getGameSerie(input: String)
    case getAmiiboImage(url: String)
}

extension AmiiboRequest: RequestType {
    var builder: NetworkRequesterType {
        switch self {
        case .getSeriesList:
            
            return QueryRequester(urlString: "https://amiiboapi.com/api/amiiboseries/")
        case .getGameSeriesList:
            
            return QueryRequester(urlString: "https://amiiboapi.com/api/gameseries/")
        case let .getSerie(serie):
            
            return QueryRequester(urlString: "https://amiiboapi.com/api/amiibo/?amiiboSeries=" + serie)
        case let .getGameSerie(gameSerie):
            
            return QueryRequester(urlString: "https://amiiboapi.com/api/amiibo/?gameseries=" + gameSerie)
        case let .getAmiiboImage(url):
            
            return QueryRequester(urlString: url)
        }
    }
}
