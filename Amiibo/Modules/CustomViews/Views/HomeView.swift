//
//  HomeView.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            AmiiboListView(amiiboRoute: AmiiboRoute.Series)
                .tabItem {
                    Image(systemName: "globe.americas")
                    Text("Series")
                }
            
            AmiiboListView(amiiboRoute: AmiiboRoute.GameSeries)
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Game Series")
                }
        }
    }
}
