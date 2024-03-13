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
    @StateObject var vmTabBar = ModleViewTabBar()
    
    @State private var showLaunchView: Bool = true
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @AppStorage("isDarkMode") private var isDarkMode = false
        
    var body: some Scene {
        WindowGroup {
            ZStack {
                if  isOnboarding {
                    OnboardingView()
                } else {
                    TabBarView(isDarkMode: $isDarkMode)
                        .environmentObject(healthManger)
                        .environmentObject(vmUser)
                        .environmentObject(vmFood)
                        .environmentObject(vmTabBar)
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                }
                if showLaunchView {
                    LaunchView(showLaunchView: $showLaunchView)
                }
            }
        }
    }
}

