//
//  ProductDetail.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import Foundation

struct SearchResponse: Decodable {
    var products: [ProductDetail]?
}
// Define a root response structure
struct ProductResponse: Decodable {
    var product: ProductDetail?
}

// Detail model of the product
struct ProductDetail: Codable {
    var id: String?
    var name: String?
    var brands: String?
    var quantity: String?
    var ingredientsText: String?
    var nutriments: Nutriments?
    var imageUrl: String?
    var calories: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "code"
        case name = "product_name"
        case brands
        case quantity
        case ingredientsText = "ingredients_text"
        case nutriments
        case calories
        case imageUrl = "image_front_url"
    }
}

// Nutritional information model
struct Nutriments: Codable {
    var energy: Double?
    var proteins: Double?
    var fat: Double?
    var carbohydrates: Double?
    var sugars: Double?
    var salt: Double?
    var fiber: Double?

    enum CodingKeys: String, CodingKey {
        case energy = "energy_100g"
        case proteins = "proteins_100g"
        case fat = "fat_100g"
        case carbohydrates = "carbohydrates_100g"
        case sugars = "sugars_100g"
        case salt = "salt_100g"
        case fiber = "fiber_100g"
    }
}
