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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading) {

                      SecationEditAccount
                        Toggle(isOn: $isDarkMode, label: { Text("Dark Mode") })
                    }.padding(.all)
                        .foregroundStyle(Color.theme.GreenColorMain)

                }
            }
            .navigationTitle("Account").navigationBarTitleDisplayMode(.inline)
            .onAppear { vmUser.loadImage(forKey: "imagePrilesKeySaved") }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isDarkMode: .constant(true))
            .environmentObject(UserInfoViewModel())
           
    }
}



extension ProfileView {
    
    private var SecationEditAccount: some View {
        VStack {
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .background(Color.gray.opacity(0.5))
                    .clipShape(Circle())
                    .padding(1)
                    .background(RoundedRectangle(cornerRadius: .infinity)
                            .stroke(lineWidth: 1.0)
                            .shadow(color: .white, radius: 10)
                            .foregroundStyle(Color.gray.opacity(0.5)))
                    .clipShape(Circle())
                
                if let image = vmUser.imageProfiles {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Circle())
                        .padding(1)
                        .background(RoundedRectangle(cornerRadius: .infinity)
                                .stroke(lineWidth: 1.0)
                                .shadow(color: .white, radius: 10)
                                .foregroundStyle(Color.gray.opacity(0.5))
                        .clipShape(Circle()))
                }
            }
            HStack {
                Button(action: {showSheet.toggle()}){
                    if vmUser.imageProfiles == nil { Text("Section Image") } else { Text("Change photo")}
                }
                    .font(.system(size: 16,weight: .regular))
                    .sheet(isPresented: $showSheet) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                
                
                Button(action: {
                    vmUser.saveImage(imageName: "imagePrilesKeySaved", image: image, key: "imagePrilesKeySaved")
                }){
                    Text("Save Photo")
                }
            }.padding(.top,10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Edit Name")
                    .font(.system(size: 16,weight: .regular))
                    .padding(.all,5)
                TextField("", text: $vmUser.currentUserName)
                    .frame(height: 50)
                    .padding(.leading)
                    .background(Color.gray.opacity(0.5))
                    .foregroundStyle(Color.gray.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 10))
            }
            


        }
    }
    
    
}
