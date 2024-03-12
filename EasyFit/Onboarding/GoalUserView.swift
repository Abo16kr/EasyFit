//
//  GoalUserView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 12.03.2024.
//

import SwiftUI

struct GoalUserView: View {
    
    @ObservedObject var vmUser : UserInfoViewModel
    
    var body: some View {
        ZStack {
            Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)

            VStack {
                VStack(spacing: 16) {
                    Text("Your Daily Calories Goal")
                        .font(.system(size: 40,weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding(.top,55)
                    
                    Text("Set a goal based on how active you are. or how active you’d like to be, each day.")
                        .font(.system(size: 16,weight: .regular))
                        .multilineTextAlignment(.center)
                }.padding(.horizontal)
           
                VStack {
                    HStack {
                        Button(action: {
                            vmUser.currentUserCaloresDay -= 1
                        }){
                            PLusMinusButton(SectionPLusMinus: .Minus)
                        }
                        TextField("\(vmUser.currentUserCaloresDay)", value:$vmUser.currentUserCaloresDay, formatter: NumberFormatter())
                            .frame(width: 200)
                            .font(.system(size: 50,weight: .semibold))
                            .offset(x: 40)
                        Button(action: {
                            vmUser.currentUserCaloresDay += 1
                        }){
                            PLusMinusButton(SectionPLusMinus: .PLus)
                        }
                      
                    }
                    Text("CALORIES/DAY")
                        .font(.system(size: 22,weight: .medium))
                        .padding(.top)
                }.padding(.top,52)
                Spacer()
                
            }
        }
      
    }
}

#Preview {
    GoalUserView(vmUser: UserInfoViewModel())
}
