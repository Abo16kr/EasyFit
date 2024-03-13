//
//  LaunchView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 11.03.2024.
//

import SwiftUI

struct LaunchView: View {
    @Binding var showLaunchView: Bool
    @State var showImages: Bool = false
    @State var showImagesMan: Bool = false
    @State var showImagesWonems: Bool = false
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var scaleValue: CGFloat = 0

    var body: some View {
        ZStack {
            Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
            VStack {
                Spacer()
                HStack(alignment: .bottom,spacing: 0) {
                    Text("EasyFit")
                        .font(.system(size: 40, weight: .bold, design: .monospaced))
                        .offset(x: showImagesWonems ? 0 : -250)
                        .opacity(showImagesWonems ? 1 : 0)
                    
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(Color(red: 0.633, green: 0.929, blue: 0.231))
                        .offset(y: -5)
                        .offset(x: showImagesMan ? 0 : 300)
                        .opacity(showImagesMan ? 1 : 0)
                }.offset(y: 40)
                Spacer()
                ActivityIndicator()
                    .frame(width: 70, height: 70)
               
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)){
                    showImages.toggle()
                    showImagesMan.toggle()
                    showImagesWonems.toggle()
                }
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.scaleValue = 1.0
                }
            }
            .onReceive(timer) { _ in
                withAnimation(.spring) {
                    showLaunchView = false
                }
            }
        }
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
