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
    @State private var showLaunchView: Bool = true
    @AppStorage("isOnboarding") var isOnboarding: Bool = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if  isOnboarding {
                    OnboardingView()
                } else {
                    TabBarView()
                        .environmentObject(healthManger)
                        .environmentObject(vmUser)
                        .environmentObject(vmFood)
                }
                if showLaunchView {
                    LaunchView(showLaunchView: $showLaunchView)
                }
            }
        }
    }
}

