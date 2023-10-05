//
//  AmiiboType.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 11/6/23.
//

import Foundation

enum AmiiboType: String, CaseIterable, Equatable {
    case figure = "Figure"
    case card = "Card"
    case yarn = "Yarn"
    case band = "Band"
    
    var image: String {
        switch self {
        case .figure:
            return "figure.stand"
        case .card:
            return "lanyardcard"
        case .yarn:
            return "teddybear.fill"
        case .band:
            return "face.dashed"
        }
    }
}
