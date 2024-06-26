//
//  DebtView.swift
//  SnoreBuddy
//
//  Created by Tanay Shah on 5/28/24.
//

import SwiftUI

struct DebtView: View {
    var debt: Double // Add a property to accept the sleep debt metric

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
                        Text("Debt")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom, 2)
                        Text(timeIntervalToString(debt))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding()
                )
            
            Image("insomnia")
                .resizable()
                .frame(width: 24, height: 24)
                .padding([.top, .trailing], 10)
        }
    }

    func timeIntervalToString(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = Int(interval) % 3600 / 60
        return "\(hours)h \(minutes)m"
    }
}

#Preview {
    DebtView(debt: 2 * 3600 + 30 * 60) // Provide a sample debt value for preview (2 hours 30 minutes)
}

