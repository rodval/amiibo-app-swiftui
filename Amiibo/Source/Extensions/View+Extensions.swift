//
//  View+Extensions.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 30/5/23.
//

import SwiftUI

extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}
