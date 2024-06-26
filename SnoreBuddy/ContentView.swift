//
//  ContentView.swift
//  SnoreBuddy
//
//  Created by Tanay Shah on 5/28/24.

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var sleepGoal: Double = 8 * 3600 // Assuming an 8-hour sleep goal in seconds
    @State private var sleepDebt: Double = 0.0
    @State private var sleepQuality: Double = 0.0
    @State private var recoveryStatus: String = "Not Recoverable"
    @State private var isRecoverable: Int = 0
    @State private var productivityScore: Double = 0.0
    @State private var isProductive: Int = 0
    @State private var authorizationStatus: String = "Not authorized"
    @State private var sleepData: [String: TimeInterval] = ["Awake": 0, "Core": 0, "REM": 0, "Deep": 0]

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0, content: {
                
                Text("Sleep Details")
                    .font(
                        Font.custom("Inter", size: 20)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(width: 322, height: 53, alignment: .center)
                
                DetailsView(sleepData: $sleepData)
                
                Spacer().frame(height: 15)
                
                HStack(spacing: 9, content: {
                    QualityView(quality: sleepQuality) // Pass the sleep quality value here
                    DebtView(debt: sleepDebt)
                })
                
                Spacer().frame(height: 15)
                
                HStack(spacing: 9, content: {
                    RecoveryView(recovery: recoveryStatus, isRecoverable: isRecoverable)
                    ProductivityView(productivity: productivityScore, isProductive: isProductive)
                })
                
                Spacer().frame(height: 10)
                
                Text("When to Recover?")
                    .font(
                        Font.custom("Inter", size: 20)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(width: 324, height: 43, alignment: .center)
                
                Spacer().frame(height: 15)
                
                CalenderView()
                
                Spacer()
            })
        }
        .onAppear {
            requestAuthorizationAndFetchData()
        }
    }

    func requestAuthorizationAndFetchData() {
        HealthKitManager.shared.requestHealthKitAuthorization { success, error in
            if success {
                self.authorizationStatus = "Authorized"
                print("HealthKit authorization granted.")
                self.fetchSleepData()
            } else {
                self.authorizationStatus = "Not authorized: \(String(describing: error?.localizedDescription))"
                print("HealthKit authorization failed: \(String(describing: error?.localizedDescription))")
            }
        }
    }

    func fetchSleepData() {
        HealthKitManager.shared.querySleepAnalysis { sleepData, error in
            if let error = error {
                print("Failed to fetch sleep data: \(error.localizedDescription)")
            } else if let sleepData = sleepData {
                self.sleepData = sleepData
                self.calculateSleepMetrics(sleepData: sleepData)
                print("Fetched sleep data: \(sleepData)")
            }
        }
    }

    func calculateSleepMetrics(sleepData: [String: TimeInterval]) {
        let totalSleepTime = sleepData["Core"]! + sleepData["REM"]! + sleepData["Deep"]!
        self.sleepDebt = max(0, sleepGoal - totalSleepTime)
        
        // Calculate sleep quality as a percentage of the sleep goal
        self.sleepQuality = totalSleepTime / sleepGoal * 100
        
        // Determine if the sleep debt is recoverable today (e.g., if it can be made up within the day)
        self.recoveryStatus = sleepDebt <= 1 * 3600 ? "Recoverable" : "Not Recoverable" // Example logic: recoverable if debt <= 2 hours
        
        // Calculate productivity score based on sleep quality and amount slept
        self.productivityScore = (100 - sleepDebt / sleepGoal * 100).clamped(to: 0...100) // Example logic
    }

    func timeIntervalToString(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = Int(interval) % 3600 / 60
        return "\(hours)h \(minutes)m"
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

#Preview {
    ContentView()
}
