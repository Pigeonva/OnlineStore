//
//  ProductModel.swift
//  OnlineStore
//
//  Created by Артур Фомин on 23.10.2022.
//

import Foundation

class ProductModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let welcomeDescription: String
    let category: Category
    let image: String
    let rating: Rating

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case welcomeDescription = "description"
        case category, image, rating
    }

    init(id: Int, title: String, price: Double, welcomeDescription: String, category: Category, image: String, rating: Rating) {
        self.id = id
        self.title = title
        self.price = price
        self.welcomeDescription = welcomeDescription
        self.category = category
        self.image = image
        self.rating = rating
    }
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
class Rating: Codable {
    let rate: Double
    let count: Int

    init(rate: Double, count: Int) {
        self.rate = rate
        self.count = count
    }
}

typealias Products = [ProductModel]
