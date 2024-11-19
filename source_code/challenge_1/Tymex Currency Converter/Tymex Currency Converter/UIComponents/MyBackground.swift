//
//  MyBackground.swift
//  Tymex Currency Converter
//
//  Created by HUY TON on 16/11/24.
//

import SwiftUI

struct MyBackground: View {
    var body: some View {
        LinearGradient(colors: [Color("brandColor"), .purple.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

#Preview {
    MyBackground()
}
