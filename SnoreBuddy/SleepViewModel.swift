//
//  SleepViewModel.swift
//  SnoreBuddy
//
//  Created by Tanay Shah on 6/25/24.
//

import HealthKit
import SwiftUI

class SleepViewModel: ObservableObject {
    @Published var sleepData: [String: TimeInterval] = ["Awake": 0, "Core": 0, "REM": 0, "Deep": 0]
    
    private let sleepDataStore = HealthKitManager()

    func fetchSleepData() {
        sleepDataStore.querySleepAnalysis { data, error in
            if let error = error {
                print("Failed to fetch sleep data: \(error.localizedDescription)")
            } else if let data = data {
                DispatchQueue.main.async {
                    self.sleepData = data
                }
            }
        }
    }
}

