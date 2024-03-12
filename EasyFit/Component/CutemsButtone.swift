//
//  CutemsButtone.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 11.03.2024.
//

import SwiftUI

struct CutemsButtone: View {
    let title: String
    let cornerRadius: CGFloat
    @State var iconeHave: Bool
    var body: some View {
        HStack {
     
            Text(title)
            if iconeHave {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 15, height: 15)
            }
        }
        .font(.system(size: 18, weight: .semibold))
        .foregroundStyle(Color.black)
        .frame(width: 350,height: 45)
        .background(Color(red: 0.633, green: 0.929, blue: 0.231))
        .clipShape(.rect(cornerRadius: cornerRadius))
        
    }
}

#Preview {
    CutemsButtone(title: "loading", cornerRadius: 10, iconeHave: true)
}

struct ButtonView: View {
    let title: String
    let background: Color
    let foregroundStyle: Color
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 18,weight: .semibold))
                .foregroundStyle(foregroundStyle)
        }
            .frame(maxWidth: .infinity)
            .frame(height: 53)
            .background(background)
            .clipShape(.rect(cornerRadius: 14))
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Continue", background: Color.white, foregroundStyle:Color.red)
            .padding(.all)
            .previewLayout(.sizeThatFits)
        
    }
}


struct PLusMinusButton: View {
    @State var SectionPLusMinus : PLusMinus
    var body: some View {
        ZStack {
            switch SectionPLusMinus {
            case .Minus:
                Image(systemName: "minus")
                    .resizable()
                    .frame(width: 24, height: 4)
                    .font(.system(size: 17,weight: .regular))
                    .frame(width: 50, height: 50)
                    .background(Color.theme.ColorCareds)
                    .clipShape(Circle())
                       
            case .PLus:
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .font(.system(size: 17,weight: .regular))
                    .frame(width: 50, height: 50)
                    .background(Color.theme.ColorCareds)
                    .clipShape(Circle())
                                
            }
        }
          
    }
}

struct PLusMinusButton_Previews: PreviewProvider {
    static var previews: some View {
        PLusMinusButton(SectionPLusMinus: .Minus)
            .padding(.all)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}




enum PLusMinus {
    case Minus
    case PLus
}

