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
                    VStack {
                        Text("Welcome to EasyFit")
                            .font(.system(size: 40,weight: .semibold))
                            .padding(.vertical,55)
                        
                        VStack(spacing: 38) {
                            HStack(alignment: .center,spacing: 12) {
                                VStack(alignment: .leading,spacing: 2) {
                                    Text("See Your Activity")
                                        .font(.system(size: 16,weight: .regular))
                                    Text("Skeep up with your rings, workouts, awards, and trends.")
                                        .font(.system(size: 16,weight: .regular))
                                        .foregroundStyle(Color.gray)
                                }
                            }
                            
                            HStack(alignment: .center,spacing: 12) {
                                
                                VStack(alignment: .leading,spacing: 2) {
                                    Text("See Your Activity")
                                        .font(.system(size: 16,weight: .regular))
                                    Text("Skeep up with your rings, workouts, awards, and trends.")
                                        .font(.system(size: 16,weight: .regular))
                                        .foregroundStyle(Color.gray)
                                }
                            }
                            
                            HStack(alignment: .center,spacing: 12) {
                                VStack(alignment: .leading,spacing: 2) {
                                    Text("See Your Activity")
                                        .font(.system(size: 16,weight: .regular))
                                    Text("Skeep up with your rings, workouts, awards, and trends.")
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
