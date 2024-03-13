//
//  AccountView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var vmUser : UserInfoViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
                VStack {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .padding(.all)
                        .onTapGesture { dismiss() }
                    HStack {
                        Text("health statistics")
                        Spacer()
                        Text("\(Date().formatted(date: .numeric, time: .shortened))")
                    }.padding(.horizontal)
                    ScrollView {
                        VStack(alignment: .leading) {

                            
                        }.padding(.all)
                        
                    }
                }
            }
        }
    }
}


struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(UserInfoViewModel())
           
    }
}


