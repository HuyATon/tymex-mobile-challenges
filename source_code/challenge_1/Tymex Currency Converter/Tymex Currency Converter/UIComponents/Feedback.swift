//
//  Feedback.swift
//  CD TSN
//
//  Created by Huy Ton Anh on 07/11/2024.
//

import SwiftUI

struct Feedback: View {
    
    @Binding var message: String
    @Binding var status: Status
    
    var body: some View {
        
        switch status {
            case .notStarted:
                EmptyView()
                
            case .failed, .successful:
                Label(message, systemImage: status == .failed ? "bubble.left.and.exclamationmark.bubble.right.fill" : "checkmark")
                    .symbolEffect(.pulse)
                    .padding()
                    .background(status == .successful ? .clear : .red)
                    .background(status == .successful ? AnyShapeStyle(.ultraThickMaterial) : AnyShapeStyle(.clear) )
                    .clipShape(.rect(cornerRadius: 15.0))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                            withAnimation {
                                self.status = .notStarted
                            }
                        })
                    }
        }
    }
}
