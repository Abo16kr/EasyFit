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
            ZStack {
                Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
                VStack {
                    ScrollView {
                        VStack {
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Consumed today")
                                    .font(.system(size: 15, weight: .regular))
                                HStack {
                                    Text("\(Int(vmFood.totalCalories))")
                                        .font(.system(size: 22, weight: .regular))
                                    Text("/")
                                    Text("1854 Kcal") // Assuming 1854 is your calorie goal
                                        .font(.system(size: 22, weight: .regular))
                                        .foregroundStyle(Color.gray)
                                }
                                // Calorie progress bar
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .frame(height: 10)
                                        .clipShape(.rect(cornerRadius: 5))
                                        .foregroundStyle(Color.gray.opacity(0.5))
                                    Rectangle()
                                        .frame(width: (vmFood.totalCalories / 1854) * UIScreen.main.bounds.width, height: 10) // Adjust width calculation as needed
                                        .clipShape(.rect(cornerRadius: 5))
                                        .foregroundStyle(Color.theme.Green2manColor)
                                }
                                
                                // Nutrient progress bars
                                HStack {
                                    // Protein
                                    nutrientProgressView(nutrientName: "Protein", total: vmFood.totalProtein, goal: vmFood.proteinGoal)
                                    // Carbs
                                    nutrientProgressView(nutrientName: "Carbs", total: vmFood.totalCarbs, goal: vmFood.carbsGoal)
                                    // Fats
                                    nutrientProgressView(nutrientName: "Fats", total: vmFood.totalFats, goal: vmFood.fatsGoal)
                                }
                            }
                            .padding(.all)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.theme.ColorCareds)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.all)
                            
                            VStack {
                                HStack {
                                    Text("Meals Day")
                                        .font(.system(size: 15, weight: .semibold))
                                    Spacer()
                                    Text("See all")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundStyle(Color.gray.opacity(0.5))
                                }
                                
                                VStack(spacing: 13) {
                                    ForEach(vmFood.addedProducts.indices, id: \.self) { item in
                                        let product = vmFood.addedProducts[item]
                                        HStack(alignment: .center) {
                                            LoadingImage(urlImage: product.imageUrl ?? "")
                                                .scaledToFill()
                                                .background(Color.gray.opacity(0.5))
                                                .frame(width: 80)
                                                .clipShape(.rect(cornerRadius: 10))
                                            
                                            VStack(alignment: .leading, spacing: 20) {
                                                Text(product.quantity ?? "N/A")
                                                    .font(.system(size: 18, weight: .semibold))
                                                
                                                Text("200gram")
                                                    .font(.system(size: 16, weight: .regular))
                                                    .foregroundStyle(Color.gray)
                                                    .padding(.bottom,5)
                                            }
                                            Spacer()
                                            
                                            HStack(alignment: .center, spacing: 2) {
                                                Image(systemName: "flame.fill")
                                                    .foregroundStyle(Color.theme.GreenColorMain)
                                                Text("\(vmFood.calculateCalories(for: product))")
                                                    .font(.system(size: 16, weight: .regular))
                                                Text("cal")
                                                    .font(.system(size: 14, weight: .regular))
                                                    .foregroundStyle(Color.gray)
                                            }
                                            .padding(.trailing)
                                            .padding(.bottom,5)
                                            Button(action: { vmFood.deleteProduct(at: item)}) {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 80)
                                    .background(Color.theme.ColorCareds)
                                    .clipShape(.rect(cornerRadius: 10))
                                }
                            }.padding(.horizontal)
                        }.padding(.bottom,180)
                    }
                }
                .onAppear {
                    withAnimation(.easeInOut){ vmFood.ShowBarSearch = true }
                    vmFood.loadProducts()
                }
                .sheet(isPresented: $isScannerPresented) {
                    BarcodeScannerView { scannedBarcode in
                        vmFood.fetchProduct(barcode: scannedBarcode)
                        isScannerPresented = false
                        showDetail = true
                    }
                }
                .overlay { SearchBarInfo }
            }
            .navigationTitle("Daily progress")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView()
            .environmentObject(FoodMoldeView())
        
    }
}

@ViewBuilder
private func nutrientProgressView(nutrientName: String, total: Double, goal: Double) -> some View {
    VStack(alignment: .leading, spacing: 10) {
        Text(nutrientName)
            .font(.system(size: 15, weight: .regular))
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 5)
                .clipShape(.rect(cornerRadius: 5))
                .foregroundStyle(Color.gray.opacity(0.5))
            Rectangle()
                .frame(width: max((total / goal) * 100, 5), height: 5) // Ensure at least 5 width for visibility
                .clipShape(.rect(cornerRadius: 5))
                .foregroundStyle(Color.theme.Green2manColor)
        }
    }
}



extension FoodView  {
 
    private var SearchBarInfo: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    if input.allSatisfy(\.isNumber) {
                        vmFood.fetchProduct(barcode: input)
                    } else {
                        vmFood.searchProductByName(input)
                    }
                    showDetail = true
                }) {
                    Image(systemName: "magnifyingglass")
                }
                TextField("Search Food or product", text: $input)
                Button(action: { isScannerPresented = true }) {
                    Image(systemName: "barcode.viewfinder")
                }
            }.padding(.all)
                .background(Color.theme.ColorCareds)
                .padding(.bottom,vmFood.ShowBarSearch ? 50 : -50)
                .sheet(isPresented: $showDetail) {
                    FoodDetailView(viewModel: vmFood)
                }
            
        }
    }
    
}







