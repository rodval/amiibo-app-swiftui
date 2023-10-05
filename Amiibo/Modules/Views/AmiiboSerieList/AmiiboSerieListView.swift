//
//  AmiiboSerieListView.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 7/6/23.
//

import SwiftUI

struct AmiiboSerieListView: View {
    // MARK: - Properties
    @StateObject private var viewModel = AmiiboSerieListViewModel(
        dependencies: AmiiboSerieListViewModelDependencies()
    )
    
    let amiiboRoute: AmiiboRoute
    let serie: String?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                SearchBarView(searchText: $viewModel.searchText)
                
                amiibosList
                    .padding()
            }
            .onLoad {
                viewModel.setup(amiiboRoute: amiiboRoute,
                                serie: serie)
            }
        }
        .navigationTitle(amiiboRoute.title)
        .navigationViewStyle(.stack)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var amiibosList: some View {
        ScrollView {
            LazyVStack(alignment: .center, spacing: 20) {
                ForEach(viewModel.amiibosListFilter, id: \.self, content: { item in
                    NavigationLink {
                        AmiiboDetailView(amiibo: item)
                    } label: {
                        AmiiboSerieListCardView(amiibo: item)
                    }
                })
            }
        }
    }
}

struct AmiiboSerieListView_Previews: PreviewProvider {
    static var previews: some View {
        AmiiboSerieListView(amiiboRoute: AmiiboRoute.Series,
                            serie: "")
    }
}
