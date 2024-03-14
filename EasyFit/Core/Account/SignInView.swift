//
//  SignInView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 12.03.2024.
//

import SwiftUI
import Firebase

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var sectionPassword: Bool = false
    @State private var sectionEmail: Bool = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth : AuthViewModel
    @State var showOnboarding: Bool = false 
    var body: some View {
        ZStack {
            Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
            VStack {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .padding(.all)
                    .onTapGesture {
                        dismiss()
                    }
                VStack {
                    Text("Sign In")
                        .font(.system(size: 30, weight: .bold))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading)
                    
                    if !vmAuth.errorMessage.isEmpty {
                        Text(vmAuth.errorMessage)
                            .foregroundColor(.red)
                    }
                    TextField("Email", text: $email)
                        .padding(.all)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(lineWidth: 1.0)
                                .foregroundStyle(sectionEmail ? Color.theme.GreenColorMain : Color.gray.opacity(0.4))
                        )
                        .background(Color.theme.ColorCareds)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .onTapGesture {
                            sectionEmail = true
                            sectionPassword = false
                        }
                        .onChange(of: email) { _ in
                            sectionEmail = !email.isEmpty
                        }
                    
                    SecureField("Password", text: $password)
                        .padding(.all)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(lineWidth: 1.0)
                                .foregroundStyle(sectionPassword ? Color.theme.GreenColorMain : Color.gray.opacity(0.4))
                        )
                        .background(Color.theme.ColorCareds)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .onTapGesture {
                            sectionPassword = true
                            sectionEmail = false
                        }
                        .onChange(of: password) { _ in
                            sectionPassword = !password.isEmpty
                        }
                        .padding(.top,10)
                    Spacer()

                    Button(action: {
                        vmAuth.signIn(email: email, password: password)

                        if vmAuth.isSignedIn {
                            showOnboarding = true
                        }
                    }, label: {
                        Text("Sign In")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.all)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.theme.ColorCaredsSwiftch)
                            .background(Color.theme.ColorCareds)
                            .clipShape(.rect(cornerRadius: 10))
                            .padding(.all)
                    })
                    .fullScreenCover(isPresented: $showOnboarding) {
                        OnboardingView()
                    }
                }.padding(.top,60)
                    .ignoresSafeArea(.keyboard)
            }
        }
    }
}


#Preview {
    SignInView()
}
