//
//  InformationUser.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 12.03.2024.
//

import SwiftUI


struct InformationUser: View {
    
    @State private var sectionSex: sectionSex = .female
    

    let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateStyle = .long
           return formatter
       }()

    @ObservedObject var vmUser: UserInfoViewModel
    @State private var birthDate = Date()
    @State private var age: DateComponents = DateComponents()
        
    var body: some View {
        ZStack {
            Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
            VStack {
                VStack(spacing: 16) {
                    Text("Personalize EasyFit and Health")
                        .font(.system(size: 40,weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding(.top,55)
                    
                    Text("This information ensures fitness and Health data are as accurate as possible.These details are not shared with Apple.")
                        .font(.system(size: 16,weight: .regular))
                        .multilineTextAlignment(.center)
                }
               
                GroupBox {
                    
                    VStack {
                        DatePicker("Date of Birth", selection: $birthDate, in: ...Date(), displayedComponents: .date)
                            .onChange(of: birthDate, perform: { value in
                                age = Calendar.current.dateComponents([.year, .month, .day], from: birthDate, to: Date())
                            })
                    }
                  
                    Divider()

                    HStack {
                        Text("Height")
                        Spacer()
                        TextField("5’10”", value: vmUser.$currentUserHeight, formatter: NumberFormatter())
                            .frame(width: 40)
                    }
                    Divider()
                    
                    HStack {
                        Text("Weight")
                        Spacer()
                 
                        TextField("183 lb", value: vmUser.$currentUserWeight, formatter: NumberFormatter())
                            .frame(width: 40)
                    }
             
                    
                }.padding(.horizontal,22)
                    .padding(.top,41)
                Spacer()
            }
        }
      
    }
}

#Preview {
    InformationUser(vmUser: UserInfoViewModel())
}