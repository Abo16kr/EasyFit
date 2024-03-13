//
//  FeedDetailsView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 13.03.2024.
//

import SwiftUI

struct FeedDetailsView: View {
    let recipe: Recipe
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Recipe image
                    if let imageUrl = recipe.image {
                        LoadingImage(urlImage: imageUrl)
                            .scaledToFit()
                            .cornerRadius(10)
                            .padding()
                    }
                    
                    // Recipe title
                    Text(recipe.title ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    // Recipe summary
                    Text(recipe.summary ?? "")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    // Recipe details
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Servings: \(recipe.servings ?? 0)")
                        Text("Ready in Minutes: \(recipe.readyInMinutes ?? 0)")
                        Text("Cuisines: \(recipe.cuisines?.joined(separator: ", ") ?? "")")
                        Text("Diets: \(recipe.diets?.joined(separator: ", ") ?? "")")
                        Text("Dish Types: \(recipe.dishTypes?.joined(separator: ", ") ?? "")")
                    }
                    .font(.body)
                    .padding(.horizontal)
                    
                    // Ingredients
                    if let ingredients = recipe.extendedIngredients {
                        Text("Ingredients:")
                            .font(.title2)
                        ForEach(ingredients) { ingredient in
                            Text(ingredient.name)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Instructions
                    if let instructions = recipe.instructions {
                        Text("Instructions:")
                            .font(.title2)
                        Text(instructions)
                            .font(.body)
                            .padding(.horizontal)
                    }
                }
                .navigationBarTitle(recipe.title ?? "", displayMode: .inline)
            }
        
    }
}
