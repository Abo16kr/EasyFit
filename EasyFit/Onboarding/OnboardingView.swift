//
//  OnboardingView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 12.03.2024.
//

import SwiftUI

struct OnboardingView: View {
    @State private var image = UIImage()
    @ObservedObject var vmUser = UserInfoViewModel()
    
    @State var onboardingState: Int = 0
    
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    var body: some View {
        ZStack {
            
            ZStack {
                switch onboardingState {
                case 0:
                    WelcomeView()
                        .transition(transition)
                case 1:
                    InformationUser(vmUser: vmUser)
                        .transition(transition)
                case 2:
                    GoalUserView(vmUser: vmUser)
                        .transition(transition)
                case 3:
                    ZStack {
                        Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
                        Text("Welcome to EasyFit")
                            .font(.system(size: 40,weight: .semibold))
                            .padding(.vertical,55)
                    }
                default:
                   Text("")
                        .transition(transition)
                }
            }
         
            ZStack {
                switch onboardingState {
                case 0...2:
                    Button {
                        withAnimation(.spring) {
                            onboardingState += 1

                        }
                    } label: {
                        ButtonView(title: "Continue", background: Color.theme.ColorCareds, foregroundStyle: Color.theme.ColorCaredsSwiftch)
                            .padding()
                    }

                case 3:
                    Button(action: {
                        withAnimation(.spring) {
                            isOnboarding = false
                        }
                    }) {
                        ButtonView(title: "Start", background: Color.theme.ColorCareds, foregroundStyle: Color.theme.ColorCaredsSwiftch)
                            .padding(.horizontal)
                    }
                default:
                    Button(action: {
                        withAnimation(.spring) {
                            isOnboarding = false
                        }
                    }) {
                        ButtonView(title: "Start", background: Color.theme.ColorCareds, foregroundStyle: Color.theme.ColorCaredsSwiftch)
                            .padding(.horizontal)
                    }
                }
            }.frame(maxHeight: .infinity,alignment: .bottom)
          
        }  
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingView()
}





