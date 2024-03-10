//
//  EasyFitApp.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import SwiftUI

@main
struct EasyFitApp: App {
    
    @StateObject var vmUser = UserInfoViewModel()
    @StateObject var healthManger = HealthManger()
    @StateObject var vmFood = FoodMoldeView()
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(healthManger)
                .environmentObject(vmUser)
                .environmentObject(vmFood)
        }
    }
}

