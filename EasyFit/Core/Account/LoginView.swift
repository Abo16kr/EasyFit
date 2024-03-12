//
//  LoginView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State var ImageAnmices: Bool = false
    let images = ["FitwomanImage1", "FitwomanImage2", "FitwomanImage3"]
    let textMativation = ["Live healthy, stay strong!","Track your goal!","Enérgize your lifestyle!"]
    @State private var currentIndex = 0
    @State private var isFirstCycle = true
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var scaleValue: CGFloat = 1.0
    
    @State private var ShowOpneSingView = false
    @State private var ShowOpneCreatinAcView = false
    
    
    var body: some View {
        ZStack {
            
            Image(images[currentIndex])
                .resizable()
                .scaledToFill()
                .scaleEffect(self.scaleValue)
                .onReceive(timer) { _ in
                    withAnimation(.spring) {
                        if currentIndex == images.count - 1 {
                            currentIndex = isFirstCycle ? 0 : 1
                            isFirstCycle = false
                        } else {
                            currentIndex += 1
                        }
                    }
                }
                .onDisappear {
                    timer.upstream.connect().cancel()
                }
                .ignoresSafeArea(.all)
            Color.black.opacity(0.6).ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                VStack {
                    HStack(alignment: .bottom,spacing: 0) {
                        Text("EasyFit")
                            .font(.system(size: 40, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color.white)
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(Color(red: 0.633, green: 0.929, blue: 0.231))
                            .offset(y: -5)
                    }
                    Text(textMativation[currentIndex])
                        .font(.system(size: 15, weight: .regular, design: .none))
                        .foregroundStyle(Color.white.opacity(0.8))
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 100, height: 5)
                            .foregroundStyle(Color.gray)
                            .clipShape(.rect(cornerRadius: 10))
                        if currentIndex == 0 {
                            Rectangle()
                                .frame(width: 30, height: 5)
                                .foregroundStyle(Color(red: 0.633, green: 0.929, blue: 0.231))
                                .clipShape(.rect(cornerRadius: 10))
                                .frame(maxWidth: .infinity,alignment:.leading)
                        } else if currentIndex == 1 {
                            Rectangle()
                                .frame(width: 30, height: 5)
                                .foregroundStyle(Color(red: 0.633, green: 0.929, blue: 0.231))
                                .clipShape(.rect(cornerRadius: 10))
                        } else if currentIndex == 2 {
                            Rectangle()
                                .frame(width: 30, height: 5)
                                .foregroundStyle(Color(red: 0.633, green: 0.929, blue: 0.231))
                                .clipShape(.rect(cornerRadius: 10))
                                .frame(maxWidth: .infinity,alignment: .trailing)
                        }
                    
                    }    
                    .frame(width: 100, height: 5)

                }.padding(.bottom)
                
                VStack(alignment: .center, spacing: 16) {
                    Button(action: {ShowOpneCreatinAcView.toggle()}){
                        Text("Create Account")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color.white)
                            .frame(width: 350,height: 45)
                            .background(Color(red: 0.094, green: 0.126, blue: 0.147))
                            .clipShape(.rect(cornerRadius: 30))
                            .padding(.horizontal)
                    }
                    .fullScreenCover(isPresented: $ShowOpneCreatinAcView) {
                        RegistrationView()
                    }
                    
                    Button(action: {
                        ShowOpneSingView.toggle()
                    }){
                        Text("Sign In")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color.black)
                            .frame(width: 350,height: 45)
                            .background(Color(red: 0.633, green: 0.929, blue: 0.231))
                            .clipShape(.rect(cornerRadius: 30))
                            .padding(.horizontal)
                        
                    }
                    .fullScreenCover(isPresented: $ShowOpneSingView) {
                        SignInView()
                    }
                }.padding(.bottom)
            }
            
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.scaleValue = 1.0
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
