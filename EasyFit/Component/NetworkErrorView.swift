//
//  NetworkErrorView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 21.03.2024.
//

import SwiftUI

struct NetworkErrorView: View {
    @Binding var isError: Bool
    var body: some View {
        HStack {
            Text("Internal Server Error")
                .font(.system(size: 18, weight: .regular,design: .monospaced))
                .foregroundStyle(Color.white)
        }.padding(.all)
        .frame(maxWidth: .infinity,alignment: .center)
        .background(Color.black.opacity(0.4))
        .background(isError ? Color.theme.GreenColorMain :  Color.red)
    }
}


struct NetworkErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NetworkErrorView(isError: .constant(false))
                .previewLayout(.sizeThatFits)
            
            NetworkErrorView(isError: .constant(true))
                .previewLayout(.sizeThatFits)
        }
        
    }
}
