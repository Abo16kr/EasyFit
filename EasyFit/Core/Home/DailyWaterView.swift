//
//  DailyWaterView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 12.03.2024.
//

import SwiftUI

struct DailyWaterView: View {
    @EnvironmentObject var vmUserInfo : UserInfoViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Water")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
                Image(systemName: "drop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
            }
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 2.0)
                    .frame(width: 100, height: 100)
                Circle()
                    .stroke(lineWidth: 3.0)
                    .foregroundStyle(Color.theme.GreenColorMain)
                    .frame(width: 100, height: 100)
                VStack {
                    Text("\(vmUserInfo.waterIntake.formattedSting())")
                        .font(.system(size: 16, weight: .regular))
                    Text("m")
                        .foregroundStyle(Color.gray)
                }
            }
                
            
        }.padding(.all)
        .frame(width: 130,height: 160)
        .background(Color.theme.ColorCareds)
        .clipShape(.rect(cornerRadius: 16))
    }
}


struct DailyWaterView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWaterView()
            .padding(.all)
            .previewLayout(.sizeThatFits)
    }
}
