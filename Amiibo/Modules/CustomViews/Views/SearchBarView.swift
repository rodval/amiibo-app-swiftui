//
//  SearchBarView.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @FocusState var isFocused: Bool

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(uiColor: .systemGray4))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search...", text: $searchText)
                    .focused($isFocused)
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 1)
                            .onTapGesture {
                                searchText = ""
                            }
                        , alignment: .trailing
                    )
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
        .onAppear(perform: {
            isFocused = true
        })
    }
}


