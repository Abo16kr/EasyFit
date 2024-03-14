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
                        if viewModel.isLoadingData {
                            VStack {
                                ProgressView()
                            }.padding(.top,90)
                        } else if viewModel.noDataAvailable {
                            Text("No data available")
                                .font(.title)
                                .foregroundColor(.gray)
                        } else if let product = viewModel.productDetail {
                            SectionDitelsPreodates
                        }
                    }
                }
                
                Button(action: {
                    if var currentProduct = viewModel.productDetail {
                        currentProduct.addedDate = Date()
                        currentProduct.quantity = String(viewModel.gramsConsumed)
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



extension FoodDetailView {
    
    private var SectionDitelsPreodates: some View {
        VStack(alignment: .leading) {
            if let product = viewModel.productDetail {
                
                if let imageUrl = product.imageUrl{
                    ZStack(alignment: .bottomLeading) {
                        
                        LoadingImage(urlImage: imageUrl)
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(22, corners: [.bottomLeft,.bottomRight])
                        
                        BackdropBlurView(radius: 6)
                            .background(Color.black.opacity(0.3))
                            .frame(height: 40)
                        
                        Text(product.name ?? "Product Name")
                            .padding(.all)
                            .lineLimit(2)
                            .font(.system(size: 22, weight: .semibold))
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundStyle(Color.white)
                            .cornerRadius(22, corners: [.bottomLeft,.bottomRight])
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                            .padding(.all)
                            .onTapGesture { dismiss() }
                    }
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(22, corners: [.bottomLeft,.bottomRight])
                    
                }
                
                VStack(alignment: .leading) {
                    Text("Brand: \(product.brands ?? "N/A")")
                    Text("Quantity: \(product.quantity ?? "N/A")")
                }.padding(.all)
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Calories \(String(format: "%.2f", viewModel.calculateCalories(for: product, gramsConsumed: viewModel.gramsConsumed)))")
                        .font(.system(size: 22, weight: .semibold))

                    Text("Ingredients: \(product.ingredientsText ?? "N/A")")
                        .font(.system(size: 15,weight: .regular))
                }
                .padding(.all)
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 22)
                    .stroke(lineWidth: 1.0)
                    .foregroundStyle(Color.theme.Green2manColor))
                .padding(.all)
                
              
                Stepper(value: $viewModel.gramsConsumed, in: 0...1000, step: 10) {
                    Text("Grams consumed: \(Int(viewModel.gramsConsumed))g")
                }
                .padding(.horizontal)
                
                if let nutriments = product.nutriments {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Protein")
                                .font(.system(size: 15, weight: .regular))
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: 100, height: 4)
                                    .clipShape(.rect(cornerRadius: 16))
                                Rectangle()
                                    .frame(width: CGFloat(nutriments.proteins ?? 0 * viewModel.gramsConsumed / 100), height: 4)
                                    .clipShape(.rect(cornerRadius: 16))
                                    .foregroundStyle(Color.theme.Green2manColor)
                            }
                            Text(String(format: "%.2f g", nutriments.proteins ?? 0 * viewModel.gramsConsumed / 100))
                                .font(.system(size: 15, weight: .regular))
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Fat")
                                .font(.system(size: 15, weight: .regular))
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: 100, height: 4)
                                    .clipShape(.rect(cornerRadius: 16))
                                Rectangle()
                                    .frame(width: CGFloat(nutriments.fat ?? 0 * viewModel.gramsConsumed / 100), height: 4)
                                    .clipShape(.rect(cornerRadius: 16))
                                    .foregroundStyle(Color.theme.Green2manColor)
                            }
                            Text(String(format: "%.2f g", nutriments.fat ?? 0 * viewModel.gramsConsumed / 100))
                                .font(.system(size: 15, weight: .regular))
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Carbs")
                                .font(.system(size: 15, weight: .regular))
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: 100, height: 4)
                                    .clipShape(.rect(cornerRadius: 16))
                                Rectangle()
                                    .frame(width: CGFloat(nutriments.carbohydrates ?? 0 * viewModel.gramsConsumed / 100), height: 4)
                                    .clipShape(.rect(cornerRadius: 16))
                                    .foregroundStyle(Color.theme.Green2manColor)
                            }
                            Text(String(format: "%.2f g", nutriments.carbohydrates ?? 0 * viewModel.gramsConsumed / 100))
                                .font(.system(size: 15, weight: .regular))
                        }
                    }
                    .padding(.all)
                    .background(Color.theme.ColorCareds)
                    .clipShape(.rect(cornerRadius: 16))
                    .padding(.all)
                }
                
                
                
                VStack(alignment: .leading) {
                    if let nutriments = product.nutriments {
                        Text("Nutritional Information per \(Int(viewModel.gramsConsumed))g:")
                            .font(.headline)
                            .padding(.bottom)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Energy: \(String(format: "%.2f", (nutriments.energy ?? 0) * viewModel.gramsConsumed / 100)) kJ")
                            Text("Proteins: \(String(format: "%.2f", (nutriments.proteins ?? 0) * viewModel.gramsConsumed / 100)) g")
                            Text("Fat: \(String(format: "%.2f", (nutriments.fat ?? 0) * viewModel.gramsConsumed / 100)) g")
                            Text("Carbohydrates: \(String(format: "%.2f", (nutriments.carbohydrates ?? 0) * viewModel.gramsConsumed / 100)) g")
                            Text("Sugars: \(String(format: "%.2f", (nutriments.sugars ?? 0) * viewModel.gramsConsumed / 100)) g")
                            Text("Salt: \(String(format: "%.2f", (nutriments.salt ?? 0) * viewModel.gramsConsumed / 100)) g")
                            Text("Fiber: \(String(format: "%.2f", (nutriments.fiber ?? 0) * viewModel.gramsConsumed / 100)) g")
                        }
                    }
                }
                .padding(.all)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.theme.ColorCareds)
                .clipShape(.rect(cornerRadius: 16))
                .padding(.all)
                
                
            }
        }.padding(.bottom,90)

    }
}
