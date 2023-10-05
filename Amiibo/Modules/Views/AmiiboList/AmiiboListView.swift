//
//  AmiiboListView.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import SwiftUI

struct AmiiboListView: View {
    // MARK: - Properties
    @StateObject private var viewModel = AmiiboListViewModel(
        dependencies: AmiiboListViewModelDependencies()
    )
    
    let amiiboRoute: AmiiboRoute
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $viewModel.searchText)
                
                amiibosList
                    .padding()
            }
            .onLoad {
                viewModel.setup(amiiboRoute: amiiboRoute)
            }
            .padding()
            .navigationBarHidden(true)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("No internet connection!"),
                    message: Text("You are probably seeing outdated data"),
                    dismissButton: .default(Text("Ok"), action: {})
                )
            }
        }
    }
    
    var amiibosList: some View {
        ScrollView {
            LazyVStack(alignment: .center, spacing: 20) {
                ForEach(viewModel.amiibosListFilter, id: \.self, content: { item in
                    NavigationLink {
                        AmiiboSerieListView(amiiboRoute: amiiboRoute,
                                            serie: item.key)
                    } label: {
                        AmiiboListCardView(amiibo: item)
                    }
                })
            }
        }
    }
}

struct AmiiboListView_Previews: PreviewProvider {
    static var previews: some View {
        AmiiboListView(amiiboRoute: AmiiboRoute.Series)
    }
}
