//
//  AmiiboCardView.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 31/5/23.
//

import SwiftUI

struct AmiiboListCardView: View {
    // MARK: Properties
    let amiibo: AmiiboListDetail
    
    // MARK: Body
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(amiibo.key ?? "")
                    .bold()
                Text(" - ")
                Text(amiibo.name ?? "")
            }
            Divider()
        }
    }
}

struct AmiiboCardView_Previews: PreviewProvider {
    static var previews: some View {
        AmiiboListCardView(amiibo: AmiiboListDetail(key: "xxx",
                                                name: "amiibo"))
    }
}
