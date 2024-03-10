//
//  ActivtyCstmesView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import SwiftUI

struct ActivtyCstmesView: View {
    @State var activty: Activty
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            
            Text(activty.title)
                .font(.system(size: 15,weight: .regular))
                .foregroundStyle(Color.black)
            
            
            Text(activty.amount)
                .foregroundStyle(Color.black)
                .font(.system(size: 25,weight: .regular))
            
            Image(systemName: activty.image)
                .font(.system(size: 18,weight: .regular))
                .foregroundStyle(Color.gray)
                .padding(.leading,5)
            
            
        }.padding(.all)
            .frame(maxWidth: .infinity,alignment: .leading)
            .frame(height: 150)
            .background(RoundedRectangle(cornerRadius: 20)
            .stroke(lineWidth: 1)
            .foregroundColor(Color.gray.opacity(0.4)))
            .background(Color(red: 0.957, green: 0.957, blue: 0.957))
            .clipShape(.rect(cornerRadius: 20))
            .padding(.horizontal)
    }
}
