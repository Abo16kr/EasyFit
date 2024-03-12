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
    
    @State private var isAccountEditing = false
    @Namespace private var AccountImage
    @Namespace private var AccountName
    @Namespace private var AccountDissmias
    @Namespace private var ButtoneSave
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading) {

                        if isAccountEditing { SecationEditAccount } else { SecationAccount }
                        
                    }.padding(.all)
                    
                }
            }
            .navigationTitle("Account")
            .onAppear { vmUser.loadImage(forKey: "imagePrilesKeySaved") }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserInfoViewModel())
           
    }
}



extension ProfileView {

    private var SecationAccount: some View {
        HStack(alignment: .center,spacing: 10) {
            ZStack {
                if let image = vmUser.imageProfiles {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60,height: 60)
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Circle())
                } else if vmUser.imageProfiles == nil {
                    Image("")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60,height: 60)
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Circle())
                }
            }
            .matchedGeometryEffect(id: "imageProfes", in: AccountImage)
            
            Text(vmUser.currentUserName)
                .font(.system(size: 18,weight: .regular))
                .matchedGeometryEffect(id: "UserName", in: AccountName)
            Spacer()
            Button {
                withAnimation(.spring) {
                    isAccountEditing.toggle()
                }
            } label: {
                Image(systemName: "pencil.line")
                    .font(.system(size: 22, weight: .regular))
                    .padding(.trailing)
            }
            .matchedGeometryEffect(id: "AccountDissmias", in: AccountDissmias)
            
        }.padding(.all,10)
            .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1)
            .foregroundStyle(Color.gray))
            .background(
                Image("RetangelsGr2")
                    .resizable()
                    .opacity(0.4)
            )
//            .background(Color.gray.opacity(0.5))
            .clipShape(.rect(cornerRadius: 10))

    }
    
    private var SecationEditAccount: some View {
        VStack {
            Button {
                withAnimation(.spring) {
                    isAccountEditing.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 22, weight: .regular))
                    .padding(.trailing)
            }
            .matchedGeometryEffect(id: "AccountDissmias", in: AccountDissmias)
            .frame(maxWidth: .infinity,alignment: .trailing)
            
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
            .matchedGeometryEffect(id: "imageProfes", in: AccountImage)
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
                        .matchedGeometryEffect(id: "AccountName", in: AccountName)
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
            }.matchedGeometryEffect(id: "UserName", in: AccountName)


        }
    }
    
    
}
