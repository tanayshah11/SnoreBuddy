//
//  RecoveryView.swift
//  SnoreBuddy
//
//  Created by Tanay Shah on 5/28/24.
//

import SwiftUI

struct RecoveryView: View {
    var recovery: String // Add a property to accept the recovery status text
    var isRecoverable: Int // Add a property to indicate recoverability (1 for recoverable, 0 for not recoverable)

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 175, height: 123)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.smallTab, Color.bigTab]), startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                .overlay(
                    VStack {
                        Text(recovery)
                            .font(.system(size: 23))
                            .fontWeight(.bold)
                            .foregroundColor(isRecoverable == 1 ? .green : .red) // Conditional styling
                    }
                    .padding()
                )
            
            Image("score")
                .resizable()
                .frame(width: 24, height: 24)
                .padding([.top, .trailing], 10)
        }
    }
}

#Preview {
    RecoveryView(recovery: "Recoverable", isRecoverable: 1) // Provide a sample recovery status for preview
}
