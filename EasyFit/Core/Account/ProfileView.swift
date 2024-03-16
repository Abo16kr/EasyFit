//
//  ProfileView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 11.03.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var vmUser : UserInfoViewModel
    @State var image = UIImage()
    @State private var showSheet = false

    @Binding var isDarkMode: Bool
    @State private var birthDate = Date()
    @State private var age: DateComponents = DateComponents()
    @State var showInfoShere = false
    @EnvironmentObject var vmTabBar: ModleViewTabBar
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
                ScrollView {
                    VStack {

                      SecationEditAccount
                        
                        GroupBox {
                            
                            TextField("NameUser", text: $vmUser.currentUserName)
                            
                        }.padding(.top,41)
                        GroupBox {
                            
                            VStack {
                                DatePicker("Date of Birth", selection: $birthDate, in: ...Date(), displayedComponents: .date)
                                    .onChange(of: birthDate, perform: { value in
                                        age = Calendar.current.dateComponents([.year, .month, .day], from: birthDate, to: Date())
                                    })
                            }
                          
                            Divider()

                            HStack {
                                Text("Height")
                                Spacer()
                                TextField("5’10”", value: vmUser.$currentUserHeight, formatter: NumberFormatter())
                                    .frame(width: 40)
                            }
                            Divider()
                            
                            HStack {
                                Text("Weight")
                                Spacer()
                         
                                TextField("183 lb", value: vmUser.$currentUserWeight, formatter: NumberFormatter())
                                    .frame(width: 40)
                            }
                            Divider()
                            NavigationLink { GoalUserView(vmUser: vmUser) } label: {
                                HStack {
                                    Text("Calories Goal")
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                }.padding(.trailing)
                            }
                            Divider()
                            Button(action: { showInfoShere.toggle() }){
                                HStack {
                                    Text("Shere Info")
                                    Spacer()
                                    Image(systemName: "square.and.arrow.up")
                                }.padding(.trailing)
                            }
                            .fullScreenCover(isPresented: $showInfoShere) {
                                HealthChartView()
                            }
                        }

                        Toggle(isOn: $isDarkMode, label: { Text("Dark Mode") })
                            .padding(.all)
                    }.padding(.all)
                        .foregroundStyle(Color.theme.ColorCaredsSwiftch)
                        .padding(.bottom,90)

                }
            }
            .navigationTitle("Account").navigationBarTitleDisplayMode(.inline)
            .onAppear {
                vmUser.loadImage(forKey: "imagePrilesKeySaved")
                vmTabBar.dissmisBarSaerch = false
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isDarkMode: .constant(true))
            .environmentObject(UserInfoViewModel())
            .environmentObject(FoodMoldeView())
            .environmentObject(HealthManger())
            .environmentObject(ModleViewTabBar())
           
    }
}



extension ProfileView {
    
    private var SecationEditAccount: some View {
        VStack {
            ZStack {
                if let image = vmUser.imageProfiles {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .padding(1)
                        .background(
                            RoundedRectangle(cornerRadius: .infinity)
                                .stroke(lineWidth: 1.0)
                                .shadow(color: .white, radius: 10)
                                .foregroundStyle(Color.gray.opacity(0.5))
                        )
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 180, height: 180)
                        .padding(1)
                        .background(
                            RoundedRectangle(cornerRadius: .infinity)
                                .stroke(lineWidth: 1.0)
                                .shadow(color: .white, radius: 10)
                                .foregroundStyle(Color.gray.opacity(0.5))
                        )
                }
            }
            HStack {
                Button(action: { showSheet.toggle() }) {
                    Text(vmUser.selectedImage == nil ? "Select Image" : "Change Image")
                        .font(.system(size: 14, weight: .regular))

                }.padding(.all,14)
                    .background(Color.theme.ColorCareds)
                    .clipShape(.rect(cornerRadius: 10))
                
                Button(action: {
                    if let image = vmUser.selectedImage {
                        vmUser.saveImage(imageName: "imagePrilesKeySaved", image: image, key: "imagePrilesKeySaved")
                    }
                }) {
                    Text("Save")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.theme.ColorCaredsSwiftch)
                }.padding(.all,14)
                .background(Color.theme.ColorCareds)
                .clipShape(.rect(cornerRadius: 10))
            }.padding(.top, 10)
          
            .sheet(isPresented: $showSheet) {
                ImagePicker(selectedImage: $vmUser.selectedImage)
            }

           
        }
    }

    
    
    
    
}
