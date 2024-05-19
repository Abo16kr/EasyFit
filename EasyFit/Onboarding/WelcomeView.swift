//
//  WelcomeView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 12.03.2024.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
                VStack {
                    VStack(alignment: .leading,spacing: 10) {
                        Text("Welcome to EasyFit")
                            .font(.system(size: 40,weight: .semibold))
                            .padding(.vertical,55)
                        
                        VStack(alignment: .leading,spacing: 38) {
                            HStack(alignment: .center,spacing: 12) {
                                VStack(alignment: .leading,spacing: 2) {
                                    Text("See Your Activity")
                                        .font(.system(size: 16,weight: .regular))
                                    Text("See how much you work in the day and how much spend calories.")
                                        .font(.system(size: 16,weight: .regular))
                                        .foregroundStyle(Color.gray)
                                }
                            }
                            
                            HStack(alignment: .center,spacing: 12) {
                                
                                VStack(alignment: .leading,spacing: 2) {
                                    Text("See Your Meals")
                                        .font(.system(size: 16,weight: .regular))
                                    Text("See what you eat in the day and all the month.")
                                        .font(.system(size: 16,weight: .regular))
                                        .foregroundStyle(Color.gray)
                                }
                            }
                            
                            HStack(alignment: .center,spacing: 12) {
                                VStack(alignment: .leading,spacing: 2) {
                                    Text("See Your Calories")
                                        .font(.system(size: 16,weight: .regular))
                                    Text("See your protein and carb and bread carbohydrates.")
                                        .font(.system(size: 16,weight: .regular))
                                        .foregroundStyle(Color.gray)
                                }
                            }
                        }
                        
                    }.padding()
                    
                    Spacer()
                       
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
     
}
