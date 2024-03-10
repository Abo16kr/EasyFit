//
//  FoodDetailView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import SwiftUI


struct FoodDetailView: View {
    @ObservedObject var viewModel: FoodMoldeView

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                if let product = viewModel.productDetail {
                    // Image and basic product info
                    if let imageUrl = product.imageUrl, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable().aspectRatio(contentMode: .fit).frame(maxWidth: 300, maxHeight: 300)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    Text(product.name ?? "Product Name").font(.title).bold()
                    Text("Brand: \(product.brands ?? "N/A")")
                    Text("Quantity: \(product.quantity ?? "N/A")")
                    Text("Ingredients: \(product.ingredientsText ?? "N/A")")
                    
                    // Nutritional information
                    if let nutriments = product.nutriments {
                        Text("Nutritional Information per 100g:").font(.headline).padding(.top)
                        Group {
                            Text("Energy: \(nutriments.energy ?? 0) kJ")
                            Text("Proteins: \(nutriments.proteins ?? 0) g")
                            Text("Fat: \(nutriments.fat ?? 0) g")
                            Text("Carbohydrates: \(nutriments.carbohydrates ?? 0) g")
                            Text("Sugars: \(nutriments.sugars ?? 0) g")
                            Text("Salt: \(nutriments.salt ?? 0) g")
                            Text("Fiber: \(nutriments.fiber ?? 0) g")
                        }.padding(.leading)
                    }
                }
            }
            .padding()
        }
    }
}
