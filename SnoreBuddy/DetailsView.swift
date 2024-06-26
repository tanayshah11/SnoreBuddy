//
//  DetailsView.swift
//  SnoreBuddy
//
//  Created by Tanay Shah on 5/28/24.
//

import SwiftUI
import HealthKit

struct DetailsView: View {
    @Binding var sleepData: [String: TimeInterval]

    var body: some View {
        VStack {
            if sleepData.isEmpty {
                Text("No sleep data available")
                    .foregroundColor(.white)
            } else {
                VStack(alignment: .listRowSeparatorLeading, spacing: 10) {
                    ForEach(sleepData.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        HStack {
                            Text(stageTypeDescription(for: key))
                                .frame(width: 80, alignment: .leading)
                                .foregroundColor(.white)
                            Rectangle()
                                .fill(color(for: key))
                                .frame(width: CGFloat(value) / 60.0, height: 20)
                            Text(timeIntervalToString(value))
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                        }
                    }
                }
            }
        }
        .foregroundColor(.clear)
        .frame(width: 362, height: 214)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.smallTab, Color.bigTab]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
    }

    func color(for type: String) -> Color {
        switch type {
        case "Awake":
            return .pink
        case "Core":
            return .cyan
        case "Deep":
            return .blue
        case "REM":
            return .lightBlue
        default:
            return .gray
        }
    }

    func stageTypeDescription(for type: String) -> String {
        switch type {
        case "Awake":
            return "Awake"
        case "Core":
            return "Core"
        case "Deep":
            return "Deep"
        case "REM":
            return "REM"
        default:
            return "Other"
        }
    }

    func timeIntervalToString(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = Int(interval) % 3600 / 60
        return "\(hours)h \(minutes)m"
    }
}

extension Color {
    static let lightBlue = Color(red: 173 / 255, green: 216 / 255, blue: 230 / 255)
}

#Preview {
    DetailsView(sleepData: .constant(["Awake": 960.0, "Core": 8940.0, "REM": 3690.0, "Deep": 2670.0]))
}
