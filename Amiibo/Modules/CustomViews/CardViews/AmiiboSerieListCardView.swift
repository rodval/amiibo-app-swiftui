//
//  AmiiboSerieListCardView.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 10/6/23.
//

import SwiftUI

struct AmiiboSerieListCardView: View {
    // MARK: Properties
    let amiibo: AmiiboSerieDetail
    
    // MARK: Body
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(amiibo.name)
                    .bold()
                Spacer()
                AsyncImage(url: URL(string: amiibo.image), content: view)
                    .frame(width: 200, height: 200)
            }
            .padding()
            Divider()
        }
    }
    
    @ViewBuilder
    private func view(for phase: AsyncImagePhase) -> some View {
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

struct AmiiboSerieListCardView_Previews: PreviewProvider {
    static var previews: some View {
        AmiiboSerieListCardView(amiibo: AmiiboSerieDetail(amiiboSeries: "",
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
