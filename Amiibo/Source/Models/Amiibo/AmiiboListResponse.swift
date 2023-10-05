//
//  AmiiboListResponse.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import Foundation

struct AmiiboListResponse: Decodable {
    let amiibo: [AmiiboListDetail]?
}

struct AmiiboListDetail: Decodable, Hashable, Identifiable {
    let key: String?
    let name: String?
    
    var id: String {
        (key ?? "") + (name ?? "")
    }
}
