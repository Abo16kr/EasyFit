//
//  EasyFitApp.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct EasyFitApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var vmUser = UserInfoViewModel()
    @StateObject var healthManger = HealthManger()
    @StateObject var vmFood = FoodMoldeView()
    @StateObject var vmTabBar = ModleViewTabBar()
    
    @State private var showLaunchView: Bool = true
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @AppStorage("isLooginIn") var isLooginIn: Bool = true
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject var vmAuth = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showLaunchView {
                    LaunchView(showLaunchView: $showLaunchView)
                } else if isOnboarding {
                    LoginView()
                        .environmentObject(vmAuth)
                        .environmentObject(vmUser)

                } else if vmAuth.isAuthenticated {
                    TabBarView(isDarkMode: $isDarkMode)
                        .environmentObject(healthManger)
                        .environmentObject(vmUser)
                        .environmentObject(vmFood)
                        .environmentObject(vmTabBar)
                        .environmentObject(vmAuth)
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                } 
            }
            .onAppear {
                vmAuth.checkAuthentication()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


extension AuthViewModel {
    func checkAuthentication() {
        if Auth.auth().currentUser != nil {
            // User is signed in
            self.isAuthenticated = true
        } else {
            // No user is signed in
            self.isAuthenticated = false
        }
    }
}
