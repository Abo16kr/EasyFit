//
//  ActivtyMolde.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import Foundation

struct Activty {
    let id = UUID()
    let title: String
    let subtitle: String
    let image: String
    let amount: String
}


struct DailyHealthData: Identifiable {
    let id = UUID()
    let date: Date
    var steps: Int
    var calories: Int
    var sleepHours: Double
}
