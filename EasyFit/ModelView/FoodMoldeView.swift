//
//  FoodMoldeView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import Foundation
import Combine

class FoodMoldeView: ObservableObject {
    
    @Published var productDetail: ProductDetail?
    
    // Add this line to store the list of added products
    @Published var addedProducts: [ProductDetail] = []
    
    @Published private var showDetail = false
    
    @Published var ShowBarSearch: Bool = false
    
    func fetchProduct(barcode: String) {
        let urlString = "https://world.openfoodfacts.org/api/v0/product/\(barcode).json"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(ProductResponse.self, from: data) {
                DispatchQueue.main.async {
                    self?.productDetail = decodedResponse.product
                }
            }
        }.resume()
    }
    
    
    func calculateTotalNutrition() -> (calories: Double, protein: Double, carbs: Double, fats: Double) {
        var totalCalories = 0.0
        var totalProtein = 0.0
        var totalCarbs = 0.0
        var totalFats = 0.0
        
        for product in addedProducts {
            if let nutriments = product.nutriments {
                // Assuming calories are stored as Double; adjust as necessary
                totalCalories += product.calories  ?? 0
                totalProtein += nutriments.proteins ?? 0
                totalCarbs += nutriments.carbohydrates ?? 0
                totalFats += nutriments.fat ?? 0
            }
        }
        
        return (totalCalories, totalProtein, totalCarbs, totalFats)
    }
      // Goals
       var proteinGoal: Double = 120 // Example goal, adjust as needed
       var carbsGoal: Double = 300 // Example goal
       var fatsGoal: Double = 70 // Example goal
       
       // Consumed macros
       var totalProtein: Double {
           addedProducts.reduce(0) { $0 + ($1.nutriments?.proteins ?? 0) }
       }
       
       var totalCarbs: Double {
           addedProducts.reduce(0) { $0 + ($1.nutriments?.carbohydrates ?? 0) }
       }
       
       var totalFats: Double {
           addedProducts.reduce(0) { $0 + ($1.nutriments?.fat ?? 0) }
       }
       
       var totalCalories: Double {
           addedProducts.reduce(0) { $0 + calculateCalories(for: $1) }
       }
       
       func calculateCalories(for product: ProductDetail) -> Double {
           // Assuming calories calculation is based on macros,
           // adjust as needed based on your actual data structure.
           let proteinCalories = (product.nutriments?.proteins ?? 0) * 4
           let fatCalories = (product.nutriments?.fat ?? 0) * 9
           let carbCalories = (product.nutriments?.carbohydrates ?? 0) * 4
           return proteinCalories + fatCalories + carbCalories
       }
    
    func addProduct() {
         if let productDetail = productDetail {
             DispatchQueue.main.async {
                 self.addedProducts.append(productDetail)
             }
         }
     }

    func saveProducts() {
        if let encoded = try? JSONEncoder().encode(addedProducts) {
            UserDefaults.standard.set(encoded, forKey: "AddedProducts")
            UserDefaults.standard.synchronize()
            print("Products saved successfully.")
        } else {
            print("Failed to encode products.")
        }
    }

    func loadProducts() {
        if let savedProducts = UserDefaults.standard.data(forKey: "AddedProducts") {
            if let decodedProducts = try? JSONDecoder().decode([ProductDetail].self, from: savedProducts) {
                self.addedProducts = decodedProducts
                print("Products loaded successfully, count: \(decodedProducts.count)")
            } else {
                print("Failed to decode products.")
            }
        }
    }
    
    func deleteProduct(at index: Int) {
        addedProducts.remove(at: index)
        saveProducts() 
    }



}


extension FoodMoldeView {
    func searchProductByName(_ query: String) {
        let formattedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://world.openfoodfacts.org/cgi/search.pl?search_terms=\(formattedQuery)&search_simple=1&action=process&json=1"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(SearchResponse.self, from: data),
               let firstProduct = decodedResponse.products?.first {
                DispatchQueue.main.async {
                    self?.productDetail = firstProduct
                    self?.showDetail = true
                }
            }
        }.resume()
    }
    
    func calculateCalories(for product: ProductDetail) -> Int {
        let proteinCalories = (product.nutriments?.proteins ?? 0) * 4
        let fatCalories = (product.nutriments?.fat ?? 0) * 9
        let carbCalories = (product.nutriments?.carbohydrates ?? 0) * 4
        return Int(proteinCalories + fatCalories + carbCalories)
    }

}

