//
//  AmiiboDetailView.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 7/6/23.
//

import SwiftUI

struct AmiiboDetailView: View {
    // MARK: Properties
    let amiibo: AmiiboSerieDetail
    
    // MARK: Body
    var body: some View {
        ZStack {
            VStack(spacing: 25) {
                image
                description
            }
            .padding()
        }
        .navigationTitle("Detail")
        .navigationViewStyle(.stack)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var image: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: amiibo.image), content: imageContent)
                .frame(width: 200, height: 200)
        }
    }
    
    private var description: some View {
        VStack {
            simpleRow(for: "Name", with: amiibo.name)
            simpleRow(for: "Character", with: amiibo.character)
            releaseDescription
            simpleRow(for: "Serie", with: amiibo.amiiboSeries)
            simpleRow(for: "Game Serie", with: amiibo.gameSeries)
            figureDescription
        }
    }
    
    private var releaseDescription: some View {
        VStack(alignment: .leading) {
            Text("Release:")
                .bold()
            
            Text("AU: \(amiibo.release?.au?.dateFormat ?? "")")
            Text("EU: \(amiibo.release?.eu?.dateFormat ?? "")")
            Text("JP: \(amiibo.release?.jp?.dateFormat ?? "")")
            Text("NA: \(amiibo.release?.na?.dateFormat ?? "")")
            
            Divider()
        }
    }
    
    private var figureDescription: some View {
        HStack {
            Text(amiibo.type)
                .bold()
                .foregroundColor(.white)
                .padding()
                .background {
                    Rectangle()
                            .fill(Color.blue)
                }
            
            Spacer()
            
            Image(systemName: amiibo.amiiboType.image)
                .resizable()
                .frame(width: 35, height: 45)
        }
    }
    
    @ViewBuilder
    private func simpleRow(for title: String, with description: String) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(title): ")
                    .bold()
                
                Text(description)
            }
            
            Divider()
        }
    }
    
    @ViewBuilder
    private func imageContent(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        case .failure(let error):
            VStack(spacing: 16) {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
                Text(error.localizedDescription)
                    .multilineTextAlignment(.center)
            }
        @unknown default:
            Text("Unknown")
                .foregroundColor(.gray)
        }
    }
}

struct AmiiboDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AmiiboDetailView(amiibo: AmiiboSerieDetail(amiiboSeries: "",
                                                   character: "",
                                                   gameSeries: "",
                                                   head: "",
                                                   image: "",
                                                   name: "",
                                                   release: nil,
                                                   tail: "",
                                                   type: ""))
    }
}
