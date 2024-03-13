//
//  FeedView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 13.03.2024.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = RecipeViewModel()
    @EnvironmentObject var vmTabBar: ModleViewTabBar
    @State private var query = ""
    @State private var cuisine = ""
    @State private var diet = ""
    @State private var intolerances = ""
    @State private var isSearchEnabled = false
    @State private var showBarSearch: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
                VStack {
                    ScrollView {
                        VStack {
                            if viewModel.isLoading {
                                ProgressView()
                            } else {
                                ForEach(viewModel.recipes) { recipeBinding in
                                    let recipe = recipeBinding
                                    VStack {
                                        LoadingImage(urlImage: recipe.image ?? "")
                                            .scaledToFill()
                                            .background(Color.gray)
                                            .frame(height: 150)
                                            .clipShape(Rectangle())
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(recipe.title ?? "")
                                                .font(.system(size: 16, weight: .regular))
                                            
                                            Text(recipe.summary ?? "")
                                                .font(.system(size: 14, weight: .regular))
                                                .foregroundStyle(Color.gray)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                        
                                        NavigationLink {
                                            FeedDetailsView(recipe: recipe)
                                        } label: {
                                            Text("View Recipe")
                                                .font(.system(size: 18, weight: .semibold))
                                                .padding()
                                                .frame(width: 140)
                                                .foregroundStyle(Color.theme.ColorTabBarSwitch)
                                                .background(Color.theme.GreenColorMain)
                                                .clipShape(Rectangle())
                                                .padding(.all)
                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                        }
                                    }
                                }

                                    .background(Color.theme.ColorCareds)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.all)
                                
                            }
                        }
                    }

                    SecationSaerchBar
                        .offset(y: vmTabBar.dissmisBarSaerchFeed ? 0 : 50)
                }
            }
            .navigationTitle("Feed").navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.searchRecipes(query: "", cuisine: "", diet: "", intolerances: "")
            withAnimation(.easeInOut){
                vmTabBar.dissmisBarSaerchFeed = true
                vmTabBar.dissmisBarSaerch = false
            }
        }
    }
}


struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

extension FeedView {
    
    private var SecationSaerchBar: some View {
        HStack {
            TextField("Search", text: $query)
            
            Button("Search") {
                if !query.isEmpty { 
                    viewModel.searchRecipes(query: query, cuisine: cuisine, diet: diet, intolerances: intolerances)
                }
            }.disabled(query.isEmpty)
        }.padding(.all)
            .background(Color.theme.ColorCareds)
        .padding(.bottom, showBarSearch ? 0 : (isKeyboardShown() ? 50 : 0))
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            self.showBarSearch = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            self.showBarSearch = false
        }
    }
    
    func isKeyboardShown() -> Bool {
         guard let currentWindow = UIApplication.shared.windows.first else {
             return false
         }
         return currentWindow.safeAreaInsets.bottom > 0
     }
}


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
