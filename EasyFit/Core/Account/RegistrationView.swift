//
//  RegistrationView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 11.03.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var sectionUserName: Bool = false
    @State private var sectionPassword: Bool = false
    @State private var sectionEmail: Bool = false
    
    @State var SectionSex: sectionSex = .female
    @State private var sectionMale: Bool = false
    @State private var sectionfemale: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var showOnboarding : Bool = false
    
    @EnvironmentObject var vmUser : UserInfoViewModel

    @EnvironmentObject var vmAuth : AuthViewModel

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

                    Text("Registration")
                        .font(.system(size: 30, weight: .bold))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading)
                        .padding(.bottom)
                    if !vmAuth.errorMessage.isEmpty {
                        Text(vmAuth.errorMessage)
                            .foregroundColor(.red)
                    }
                    TextField("NameUser", text: $vmUser.currentUserName)
                        .padding(.all)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(lineWidth: 1.0)
                                .foregroundStyle(sectionUserName ? Color.theme.GreenColorMain : Color.gray.opacity(0.4))
                        )
                        .background(Color.theme.ColorCareds)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .onTapGesture {
                            sectionUserName = true
                            sectionEmail = false
                            sectionPassword = false
                        }
                        .onChange(of: email) { _ in
                            sectionEmail = !email.isEmpty
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
                            sectionUserName = false

                        }
                        .onChange(of: email) { _ in
                            sectionEmail = !email.isEmpty
                        }
                        .padding(.top,10)
                    
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
                            sectionUserName = false

                        }
                        .onChange(of: password) { _ in
                            sectionPassword = !password.isEmpty
                        }
                        .padding(.top,10)
                    
                    
                    HStack(spacing: 22) {
                        Button(action: {
                            SectionSex = .male
                            sectionMale = true
                            sectionfemale = false
                        }, label: {
                            VStack(spacing: 20) {
                                Image("ManICone")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 30)
                                Text("Male")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundStyle(sectionMale ? Color.black : Color.white)

                            }
                                .frame(width: 90,height: 90)
                                .background(sectionMale ? Color.white : Color.theme.ColorCareds)
                                .clipShape(.rect(cornerRadius: 10))
                        })
                   
                        Button(action: {
                            SectionSex = .female
                            sectionMale = false
                            sectionfemale = true
                        }, label: {
                            VStack(spacing: 20) {
                                Image("FemaleIcone")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 30)
                                Text("Female")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundStyle(sectionfemale ? Color.black : Color.white)
                            }
                                .frame(width: 90,height: 90)
                                .background(sectionfemale ? Color.white : Color.theme.ColorCareds)
                                .clipShape(.rect(cornerRadius: 10))
                        })
                  

                    }.padding(.all)
                    Spacer()

                    Button(action: {
                        vmAuth.registerUser(email: email, password: password)
                        if vmAuth.isUserAuthenticated {
                            showOnboarding = true
                        }
                    }, label: {
                        Text("Registration")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.all)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.theme.ColorCaredsSwiftch)
                            .background(Color.theme.ColorCareds)
                            .clipShape(.rect(cornerRadius: 10))
                            .padding(.all)
                    })
            
                }.ignoresSafeArea(.keyboard)
            }
            .fullScreenCover(isPresented: $showOnboarding) {
                OnboardingView()
            }
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(UserInfoViewModel())
        .environmentObject(AuthViewModel())
}

enum sectionSex {
    case male
    case female
}
