//
//   FeedViewMolde.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 14.03.2024.
//

import Foundation


class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    
    func searchRecipes(query: String, cuisine: String, diet: String, intolerances: String) {
        isLoading = true
        
        let apiKey = "a767777e5d7f474084db9afab7804621"
        let baseUrl = "https://api.spoonacular.com/recipes/complexSearch"
        let parameters: [String: String] = [
            "apiKey": apiKey,
            "query": query,
            "cuisine": cuisine,
            "diet": diet,
            "intolerances": intolerances
        ]
        
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        let url = urlComponents.url!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipesResponse = try decoder.decode(RecipeSearchResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.recipes = recipesResponse.results
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}


struct Recipe: Codable, Identifiable {
    let id: Int
    var title: String?
    var image: String?
    var summary: String?
    let sourceUrl: String?
    let servings: Int?
    let readyInMinutes: Int?
    let cuisines: [String]?
    let diets: [String]?
    let dishTypes: [String]?
    let instructions: String?
    let extendedIngredients: [Ingredient]?
}


struct RecipeSearchResponse: Codable {
    let results: [Recipe]
}
struct Ingredient: Codable,Identifiable {
    let id: Int
    let name: String
    let image: String
}
