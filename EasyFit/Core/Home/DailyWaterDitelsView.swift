//
//  DailyWaterDitelsView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 12.03.2024.
//

import SwiftUI

struct DailyWaterDitelsView: View {
    let rowsCuems = [GridItem(.fixed(76)),
                     GridItem(.fixed(76)),
                     GridItem(.fixed(76)),
                     GridItem(.fixed(76))]
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
            VStack {
                sectionNavigtionBar
                ScrollView {
                    VStack {
                        
                        Text("You have drank 750 ml of water")
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
                                Text("799")
                                    .font(.system(size: 16, weight: .regular))
                                Text("m")
                                    .foregroundStyle(Color.gray)
                            }
                        }.padding(.all)
                        
                        
                        LazyVGrid(columns: rowsCuems){
                            ForEach(0 ..< 10) { item in
                                Button(action: {}) {
                                    Image(systemName: "waterbottle.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color.theme.GreenColorMain)
                                        .frame(width: 80,height: 80)
                                        .background(Color.theme.ColorCaredsSwiftch)
                                        .clipShape(.rect(cornerRadius: 14))
                                }
                            }
                        }
                  
                        
                        
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
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
