//
//  HealthManger.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import Foundation
import SwiftUI
import HealthKit

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}



class HealthManger: ObservableObject {
    
    let healthStore = HKHealthStore()
      
      @Published var activities: [String : Activty] = [:]
      
      init() {
          
          let steps = HKQuantityType.quantityType(forIdentifier: .stepCount)!
          let calories = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
          let sleep = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
          let healthTypesToRead: Set<HKObjectType> = [steps, calories, sleep]
          
          Task {
              do {
                  try await healthStore.requestAuthorization(toShare: [], read: healthTypesToRead)
                  fetchTodaySteps()
                  fetchTodayCalories()
                  fetchTodaySleep()
              } catch {
                  print("Error fetching Health data")
              }
          }
      }
    
    private func fetchStatisticsForQuantityType(_ quantityType: HKQuantityType, unit: HKUnit, activityTitle: String, activitySubtitle: String, activityImage: String, goal: String, key: String) {
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date(), options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: [.cumulativeSum]) { _, result, error in
            DispatchQueue.main.async {
                guard let quantity = result?.sumQuantity(), error == nil else {
                    // Log the error if there is one
                    if let error = error {
                        print("Error fetching \(activityTitle) data: \(error.localizedDescription)")
                    } else {
                        print("No \(activityTitle) data available for today.")
                    }
                    
                    // Set a default state or message for no data
                    self.activities[key] = Activty(
                        title: activityTitle,
                        subtitle: "No data",
                        image: activityImage,
                        amount: "N/A" // You could also use "0" or any placeholder you prefer
                    )
                    return
                }
                
                let value = quantity.doubleValue(for: unit)
                let formattedString = self.formatValue(value, forUnit: unit)

                let activity = Activty(
                    title: activityTitle,
                    subtitle: activitySubtitle,
                    image: activityImage,
                    amount: formattedString
                )

                self.activities[key] = activity
            }
        }
        healthStore.execute(query)
    }



       func fetchTodaySteps() {
           guard let stepsType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
               print("Steps type is not available")
               return
           }
           fetchStatisticsForQuantityType(stepsType, unit: HKUnit.count(), activityTitle: "Today's Steps", activitySubtitle: "Goal 10000", activityImage: "figure.walk", goal: "10000", key: "todaySteps")
       }

       func fetchTodayCalories() {
           guard let caloriesType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
               print("Calories type is not available")
               return
           }
           fetchStatisticsForQuantityType(caloriesType, unit: HKUnit.kilocalorie(), activityTitle: "Today's Calories", activitySubtitle: "Goal 900", activityImage: "flame", goal: "900", key: "todayCalories")
       }

       func fetchTodaySleep() {
           guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
               print("Sleep type is not available")
               return
           }

           let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date(), options: .strictStartDate)
           let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, error in
               guard let sleepResults = results as? [HKCategorySample], error == nil else {
                   print("Error fetching today's sleep data: \(String(describing: error))")
                   return
               }

               let totalSleep = sleepResults.filter({ $0.value == HKCategoryValueSleepAnalysis.asleep.rawValue }).reduce(0) {
                   $0 + $1.endDate.timeIntervalSince($1.startDate)
               }
               
               let formattedSleepDuration = self.formatDuration(totalSleep)

               DispatchQueue.main.async {
                   let activity = Activty(title: "Today's Sleep", subtitle: "Goal: 8 hours", image: "bed.double.fill", amount: formattedSleepDuration)
                   self.activities["todaySleep"] = activity
               }

               print("Fetched sleep duration: \(formattedSleepDuration)")
           }

           healthStore.execute(query)
       }

    private func formatValue(_ value: Double, forUnit unit: HKUnit) -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal

        if unit == HKUnit.count() {
            // For steps, we don't need any decimal places
            formatter.maximumFractionDigits = 0
        } else if unit == HKUnit.kilocalorie() {
            // For calories, typically shown without decimal places as well
            formatter.maximumFractionDigits = 0
        }
        // You can add more units and their specific formatting here

        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }


       private func formatDuration(_ duration: TimeInterval) -> String {
           // Your code to format the duration, e.g., sleep time
           let hours = Int(duration) / 3600
           let minutes = Int(duration) % 3600 / 60
           return "\(hours) hours \(minutes) minutes"
       }


    
}

