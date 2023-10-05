//
//  NetworkConfiguration.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import Foundation
import Combine

protocol RequestType {
    var builder: NetworkRequesterType { get }
}

protocol NetworkRequesterType {
    func performRequest() -> AnyPublisher<Data, Error>
}
