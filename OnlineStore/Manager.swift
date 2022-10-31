//
//  Manager.swift
//  OnlineStore
//
//  Created by Артур Фомин on 23.10.2022.
//

import Foundation

class Manager {
    
    static let shared = Manager()
    
    private init() {}
    
    func fetchAllProducts(completion: @escaping (Products)->Void) {
       
        let urlString = "https://fakestoreapi.com/products"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let safeData = data else { return }
            do {
                let decode = try JSONDecoder().decode(Products.self, from: safeData)
                completion(decode)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchCategories(completion: @escaping (Categories)->Void) {
        
        let urlString = "https://fakestoreapi.com/products/categories"
        guard let url = URL(string: urlString) else { return }
        var request  = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let safeData = data else { return }
            do {
                let decode = try JSONDecoder().decode(Categories.self, from: safeData)
                completion(decode)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
