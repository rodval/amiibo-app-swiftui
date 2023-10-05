//
//  NetworkMonitor.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import Foundation
import Network

// MARK: Protocol
protocol NetworkMonitorType {
    var isConnected: Published<Bool>.Publisher { get }
    
    func start()
}

// MARK: Dependency Protocol
protocol HasNetworkMonitorType {
    var networkMonitor: NetworkMonitorType { get }
}

class NetworkMonitor: ObservableObject, NetworkMonitorType {
    @Published private var networkState: Bool = false
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    var isConnected: Published<Bool>.Publisher { $networkState }
    
    init() {
        monitor = NWPathMonitor()
    }
    
    func start() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.networkState = path.status == .satisfied ? true : false
        }
    }
}
