//
//  FoodView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import SwiftUI

struct FoodView: View {
    
    @EnvironmentObject var vmUser: UserInfoViewModel
    @EnvironmentObject var vmFood: FoodMoldeView
    
    @State private var input = ""
    @State private var isScannerPresented = false
    @State private var showDetail = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter barcode or product name", text: $input)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Search") {
                    if input.allSatisfy(\.isNumber) {
                        vmFood.fetchProduct(barcode: input)
                    } else {
                        vmFood.searchProductByName(input)
                    }
                    showDetail = true
                }

                Button("Scan Barcode") {
                    isScannerPresented = true
                }
                .sheet(isPresented: $isScannerPresented) {
                    BarcodeScannerView { scannedBarcode in
                        vmFood.fetchProduct(barcode: scannedBarcode)
                        isScannerPresented = false
                        showDetail = true
                    }
                }
            }
            .padding()
            .navigationBarTitle("Product Lookup", displayMode: .inline)
            .sheet(isPresented: $showDetail) {
                FoodDetailView(viewModel: vmFood)
            }
        }
    }
}



extension FoodView  {
    
    private var SectionTabBar: some View {
        HStack {
            NavigationLink {
                AccountView()
            } label: {
                if let image = vmUser.imageProfiles {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Circle())
                } else if vmUser.imageProfiles == nil {
                   Image(systemName: "person.and.background.dotted")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35, height: 35)
                        .foregroundStyle(Color.gray.opacity(0.5))
                        .frame(width: 45, height: 45)
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Circle())
                }
            }
            Spacer()
            Text("Food")
                .font(.system(size: 18, weight: .regular))
            Spacer()

            NavigationLink {
                Text("No Nativations")
            } label: {
                Image(systemName: "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .frame(width: 45, height: 45)
//                    .background(RoundedRectangle(cornerRadius: .infinity)
//                        .stroke(lineWidth: 1.0).foregroundStyle(Color.gray.opacity(0.5)))
            }

        }.padding(.horizontal)
    }
    
}







