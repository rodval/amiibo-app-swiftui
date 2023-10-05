//
//  NetworkError.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import Foundation

enum NetworkError: Int, Error, LocalizedError {
    case badRequest = 400
    case notFound = 404
    case notAcceptable = 406
    case tooManyRequests = 429
    case internalServerError = 500
    case serviceUnavailable = 503
    case badURL
    
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .notFound:
            return "Not Found"
        case .notAcceptable:
            return "Not Acceptable"
        case .tooManyRequests:
            return "Too Many Requests"
        case .internalServerError:
            return "Internal Server Error"
        case .serviceUnavailable:
            return "Service Unavailable"
        case .badURL:
            return "The url is not correct"
        }
    }
}
