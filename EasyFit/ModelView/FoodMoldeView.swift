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
    @Published private var showDetail = false

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
}
