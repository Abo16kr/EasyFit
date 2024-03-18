//
//  DailyWaterDitelsView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 12.03.2024.
//

import SwiftUI


struct DailyWaterDitelsView: View {

    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var vmUserInfo : UserInfoViewModel
    @AppStorage("lastUpdateDate") var lastUpdateDate: String = ""

    private var waterBottleCount: Int {
        Int(vmUserInfo.waterIntake) / 100
    }
       
    private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        ZStack {
            Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
            VStack {
                sectionNavigtionBar
                ScrollView {
                    VStack {
                        
                        Text("You have drank \(vmUserInfo.waterIntake.formattedSting()) ml of water")
                            .font(.system(size: 22, weight: .semibold))
                            .frame(width: 160)
                            .padding(.top)
                        
                        
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 2.0)
                                .frame(width: 190, height: 190)
                            Circle()
                                .stroke(lineWidth: 3.0)
                                .foregroundStyle(Color.theme.GreenColorMain)
                                .frame(width: 190, height: 190)
                            VStack(alignment: .center, spacing: 10) {
                                Image(systemName: "waterbottle.fill")
                        TextField("", text: Binding(
                                   get: { String(format: "%.0f", vmUserInfo.waterIntake) },
                                   set: { vmUserInfo.waterIntake = Double($0) ?? 700 }
                               ))
                                .keyboardType(.numberPad)
                               .frame(width: 60)
                                    .font(.headline)
                                    .offset(x: 10)
                                    .font(.system(size: 16, weight: .regular))
                                Text("m")
                                    .foregroundStyle(Color.gray)
                            }
                        }.padding(.all)
                        
                        
                        LazyVGrid(columns: gridLayout, spacing: 20) {
                            ForEach(0..<waterBottleCount, id: \.self) { _ in
                                Button(action: {
                                    self.decrementWaterIntake(by: 100)
                                }, label: {
                                    Image(systemName: "waterbottle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color.blue)
                                        .frame(width: 80, height: 80)
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                })
                            }
                        }

                        
                    }.padding(.bottom,90)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    
    }
    private func decrementWaterIntake(by amount: Double) {
        vmUserInfo.waterIntake = max(vmUserInfo.waterIntake - amount, 0)
     }
     
     private func checkForNewDay() {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         let today = dateFormatter.string(from: Date())
         
         if lastUpdateDate != today {
             vmUserInfo.waterIntake = vmUserInfo.waterIntake
             lastUpdateDate = today
         }
     }
}

#Preview {
    DailyWaterDitelsView()
}

extension DailyWaterDitelsView {
    
    
    private var sectionNavigtionBar: some View {
        HStack {
            Button(action: {dismiss()}) {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(Color.theme.ColorCaredsSwiftch)
            }
            Spacer()
            Text("Daily Water")
            Spacer()
        }.padding(.horizontal)
        .padding(.top,10)
    }
    
}
