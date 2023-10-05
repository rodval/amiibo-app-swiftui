//
//  AmiiboSerieListViewModel.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 7/6/23.
//

import Foundation
import Combine

class AmiiboSerieListViewModel: ObservableObject {
    typealias Dependencies = HasAmiiboServiceType
    
    // MARK: - Published variables
    @Published var amiibosListFilter: [AmiiboSerieDetail] = []
    @Published var searchText: String = ""
    @Published var error: String = ""
    
    // MARK: - Properties
    private var dependencies: Dependencies
    private var cancellables: Set<AnyCancellable> = []
    private var amiibosList: [AmiiboSerieDetail] = []
    private var amiiboRoute: AmiiboRoute = .Series
    private var serie: String = ""
    
    // MARK: - Initialization
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Setup
    func setup(amiiboRoute: AmiiboRoute, serie: String?) {
        self.amiiboRoute = amiiboRoute
        self.serie = serie ?? ""
        
        setBindings()
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
                    self?.amiibosListFilter = self?.amiibosList.filter({ ($0.name.lowercased().contains(value.lowercased())) }) ?? []
                }
            }
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
            .getSerieDetail(serie: serie)
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
            .getGameSerieDetail(gameSerie: serie)
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

struct AmiiboSerieListViewModelDependencies: HasAmiiboServiceType {
    var amiiboServiceType: AmiiboServiceType {
        AmiiboService(dependencies: AmiiboServiceDependencies())
    }
}
