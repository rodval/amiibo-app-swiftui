//
//  AmiiboDetailResponse.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import Foundation

struct AmiiboSerieDetailListResponse: Decodable {
    let amiibo: [AmiiboSerieDetail]?
}

struct AmiiboSerieDetail: Decodable, Hashable, Identifiable  {
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let head: String
    let image: String
    let name: String
    let release: ReleaseDate?
    let tail: String
    let type: String
    
    var id: String {
        head + tail
    }
    
    var imageURL: URL {
        guard let url = URL(string: image) else {
            preconditionFailure("Invalid URL")
        }
        
        return url
    }
    
    var amiiboType: AmiiboType {
        AmiiboType(rawValue: self.type) ?? .figure
    }
}

struct ReleaseDate: Decodable, Hashable, Equatable {
    let au: String?
    let eu: String?
    let jp: String?
    let na: String?
}
