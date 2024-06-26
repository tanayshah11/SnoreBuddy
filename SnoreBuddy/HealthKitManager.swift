//
//  HealthKitManager.swift
//  SnoreBuddy
//
//  Created by Tanay Shah on 6/24/24.
//

import HealthKit

class HealthKitManager {
    static let shared = HealthKitManager()
    let healthStore = HKHealthStore()

    func requestHealthKitAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, NSError(domain: "HealthKit", code: 1, userInfo: [NSLocalizedDescriptionKey: "Health data is not available"]))
            return
        }

        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else { return }

        healthStore.requestAuthorization(toShare: [], read: [sleepType]) { (success, error) in
            completion(success, error)
        }
    }

    func querySleepAnalysis(completion: @escaping ([String: TimeInterval]?, Error?) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(nil, NSError(domain: "HealthKit", code: 2, userInfo: [NSLocalizedDescriptionKey: "Sleep Analysis Type is not available"]))
            return
        }

        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())

        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)

        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            guard let results = results as? [HKCategorySample] else {
                completion(nil, error)
                return
            }

            var sleepData: [String: TimeInterval] = ["Awake": 0, "Core": 0, "REM": 0, "Deep": 0]

            for sample in results {
                let duration = sample.endDate.timeIntervalSince(sample.startDate)
                switch sample.value {
                case HKCategoryValueSleepAnalysis.awake.rawValue:
                    sleepData["Awake"]! += duration
                case HKCategoryValueSleepAnalysis.asleepCore.rawValue:
                    sleepData["Core"]! += duration
                case HKCategoryValueSleepAnalysis.asleepREM.rawValue:
                    sleepData["REM"]! += duration
                case HKCategoryValueSleepAnalysis.asleepDeep.rawValue:
                    sleepData["Deep"]! += duration
                default:
                    break
                }
            }

            completion(sleepData, nil)
        }

        healthStore.execute(query)
    }
}
