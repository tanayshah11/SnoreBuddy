//
//  SleepDataStore.swift
//  SnoreBuddy
//
//  Created by Tanay Shah on 6/25/24.
//

import HealthKit

class SleepDataStore {
    let healthStore = HKHealthStore() // Initializes a HealthKit store instance to access HealthKit data.

    func fetchSleepAnalysis(completion: @escaping ([HKCategorySample]) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion([]) // If the sleep analysis data type is not available, call the completion handler with an empty array.
            return
        }

        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) // Define the start date as 7 days ago.
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: []) // Create a predicate to filter sleep data within the last 7 days.

        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, result, error) in
            guard let result = result as? [HKCategorySample], error == nil else {
                completion([]) // If there's an error or no results, call the completion handler with an empty array.
                return
            }
            completion(result) // Call the completion handler with the fetched sleep data.
        }

        healthStore.execute(query) // Execute the query on the HealthKit store.
    }
}

