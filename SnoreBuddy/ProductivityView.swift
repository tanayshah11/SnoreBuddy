//
//  ProductivityView.swift
//  SnoreBuddy
//
//  Created by Tanay Shah on 5/28/24.
//

import SwiftUI

struct ProductivityView: View {
    var productivity: Double // Add a property to accept the productivity score
    var isProductive: Int // Add a property to indicate productivity status (1 for productive, 0 for not productive)

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
                        Text("\(String(format: "%.1f", productivity))%")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(isProductive == 1 ? .green : .red) // Conditional styling
                    }
                )
            
            Image("bed")
                .resizable()
                .frame(width: 24, height: 24)
                .padding([.top, .trailing], 10)
        }
    }
}

#Preview {
    ProductivityView(productivity: 90.0, isProductive: 1) // Provide a sample productivity value for preview
}
