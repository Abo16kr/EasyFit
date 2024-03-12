//
//  FoodDetailView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import SwiftUI

struct FoodDetailView: View {
    @ObservedObject var viewModel: FoodMoldeView
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        if let product = viewModel.productDetail {
                            
                            if let imageUrl = product.imageUrl{
                                ZStack(alignment: .bottomLeading) {
                                    
                                    LoadingImage(urlImage: imageUrl)
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 300)
                                        .background(Color.gray.opacity(0.5))
                                        .cornerRadius(22, corners: [.bottomLeft,.bottomRight])
                                    
                                    BackdropBlurView(radius: 6)
                                        .background(Color.black.opacity(0.3))
                                        .frame(height: 40)
                                    
                                    Text(product.name ?? "Product Name")
                                        .padding(.all)
                                        .font(.system(size: 22, weight: .semibold))
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .foregroundStyle(Color.white)
                                        .cornerRadius(22, corners: [.bottomLeft,.bottomRight])
                                    
                                }
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(22, corners: [.bottomLeft,.bottomRight])

                            }
                            
                            VStack(alignment: .leading) {
                                Text("Brand: \(product.brands ?? "N/A")")
                                Text("Quantity: \(product.quantity ?? "N/A")")
                            }.padding(.all)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("218 cal")
                                    .font(.system(size: 22,weight: .semibold))
                                Text("Ingredients: \(product.ingredientsText ?? "N/A")")
                                    .font(.system(size: 15,weight: .regular))
                            }.padding(.all)
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 22)
                                .stroke(lineWidth: 1.0)
                                .foregroundStyle(Color.theme.Green2manColor))
                                .padding(.all)
                            
                            if let nutriments = product.nutriments {
                                HStack(alignment: .center) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Protein")
                                            .font(.system(size: 15,weight: .regular))
                                        ZStack(alignment: .leading) {
                                            Rectangle()
                                                .frame(width: 100, height: 4)
                                                .clipShape(.rect(cornerRadius: 16))
                                            Rectangle()
                                                .frame(width: nutriments.proteins ?? 0, height: 4)
                                                .clipShape(.rect(cornerRadius: 16))
                                                .foregroundStyle(Color.theme.Green2manColor)
                                        }
                                        Text("\(nutriments.proteins ?? 0) g")
                                            .font(.system(size: 15, weight: .regular))
                                    }
                                    VStack(alignment: .leading, spacing: 8) {
                                        
                                        Text("Fat")
                                            .font(.system(size: 15,weight: .regular))
                                        ZStack(alignment: .leading) {
                                            Rectangle()
                                                .frame(width: 100, height: 4)
                                                .clipShape(.rect(cornerRadius: 16))
                                            Rectangle()
                                                .frame(width: nutriments.fat ?? 0, height: 4)
                                                .clipShape(.rect(cornerRadius: 16))
                                                .foregroundStyle(Color.theme.Green2manColor)
                                        }
                                        Text("\(nutriments.fat ?? 0) g")
                                            .font(.system(size: 15, weight: .regular))
                                    }
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Carbs")
                                            .font(.system(size: 15,weight: .regular))
                                        ZStack(alignment: .leading) {
                                            Rectangle()
                                                .frame(width: 100, height: 4)
                                                .clipShape(.rect(cornerRadius: 16))
                                            Rectangle()
                                                .frame(width: nutriments.carbohydrates ?? 0, height: 4)
                                                .clipShape(.rect(cornerRadius: 16))
                                                .foregroundStyle(Color.theme.Green2manColor)
                                        }
                                        Text("\(nutriments.carbohydrates ?? 0) g")
                                            .font(.system(size: 15, weight: .regular))
                                            
                                    }
                                    
                                }.padding(.all)
                                    .background(Color.theme.ColorCareds)
                                    .clipShape(.rect(cornerRadius: 16))
                                    .padding(.all)
                            }
                            
                            // Nutritional information
                            VStack(alignment: .leading) {
                                if let nutriments = product.nutriments {
                                    Text("Nutritional Information per 100g:")
                                        .font(.headline)
                                        .padding(.bottom)
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("Energy: \(nutriments.energy ?? 0) kJ")
                                        Text("Proteins: \(nutriments.proteins ?? 0) g")
                                        Text("Fat: \(nutriments.fat ?? 0) g")
                                        Text("Carbohydrates: \(nutriments.carbohydrates ?? 0) g")
                                        Text("Sugars: \(nutriments.sugars ?? 0) g")
                                        Text("Salt: \(nutriments.salt ?? 0) g")
                                        Text("Fiber: \(nutriments.fiber ?? 0) g")
                                    }
                                }
                            }.padding(.all)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .background(Color.theme.ColorCareds)
                                .clipShape(.rect(cornerRadius: 16))
                                .padding(.all)
                        }
                    }.padding(.bottom,90)
                   
                }
                Button(action: {
                    if let currentProduct = viewModel.productDetail {
                        viewModel.addedProducts.append(currentProduct)
                        viewModel.saveProducts()
                        dismiss()
                    }
                }) {
                    CutemsButtone(title: "Add", cornerRadius: 10, iconeHave: true)
                }

            }
        }
    }
}


