//
//  AmiiboListViewModel.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import Foundation
import Combine

enum AmiiboRoute: Int {
    case Series
    case GameSeries
    
    var title: String {
        switch self {
        case .Series:
            return "Series"
        case .GameSeries:
            return "Game Series"
        }
    }
}

class AmiiboListViewModel: ObservableObject {
    typealias Dependencies = HasAmiiboServiceType & HasNetworkMonitorType
    
    // MARK: - Published variables
    @Published var amiibosListFilter: [AmiiboListDetail] = []
    @Published var searchText: String = ""
    @Published var error: String = ""
    @Published var showAlert: Bool = false
    
    // MARK: - Properties
    private var dependencies: Dependencies
    private var cancellables: Set<AnyCancellable> = []
    private var amiibosList: [AmiiboListDetail] = []
    private var amiiboRoute: AmiiboRoute = .Series
    
    // MARK: - Initialization
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Setup
    func setup(amiiboRoute: AmiiboRoute) {
        self.amiiboRoute = amiiboRoute
        
        setBindings()
        networkMonitor()
        fetchAmiiboList()
    }
    
    private func setBindings() {
        $searchText
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                if value == "" {
                    self?.amiibosListFilter = self?.amiibosList ?? []
                } else {
                    self?.amiibosListFilter = self?.amiibosList.filter({ ($0.name?.lowercased().contains(value.lowercased()) ?? false) }) ?? []
                }
            }
            .store(in: &cancellables)
    }
    
    private func networkMonitor() {
        dependencies.networkMonitor.start()
        
        dependencies
            .networkMonitor
            .isConnected
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] status in
                self?.showAlert = !status
            })
            .store(in: &cancellables)
    }
    
    private func fetchAmiiboList() {
        switch amiiboRoute {
        case .Series:
            fetchAmiiboSeriesList()
        case .GameSeries:
            fetchAmiiboGameSeriesList()
        }
    }
    
    private func fetchAmiiboSeriesList() {
        dependencies
            .amiiboServiceType
            .getSeriesList()
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] response in
                guard case let .failure(error) = response else { return }
                
                self?.error = error.localizedDescription
            } receiveValue: { [weak self] result in
                guard let amiibos = result.amiibo else { return }
                
                self?.amiibosList = amiibos
                self?.amiibosListFilter = amiibos
            }.store(in: &cancellables)
    }
    
    private func fetchAmiiboGameSeriesList() {
        dependencies
            .amiiboServiceType
            .getGameSeriesList()
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] response in
                guard case let .failure(error) = response else { return }
                
                self?.error = error.localizedDescription
            } receiveValue: { [weak self] result in
                guard let amiibos = result.amiibo else { return }
                
                self?.amiibosList = amiibos
                self?.amiibosListFilter = amiibos
            }.store(in: &cancellables)
    }
}

struct AmiiboListViewModelDependencies: HasAmiiboServiceType, HasNetworkMonitorType {
    var amiiboServiceType: AmiiboServiceType {
        AmiiboService(dependencies: AmiiboServiceDependencies())
    }
    var networkMonitor: NetworkMonitorType = NetworkMonitor()
}
