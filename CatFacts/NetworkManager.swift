//
//  NetworkManager.swift
//  CatFacts
//
//  Created by Ramill Ibragimov on 08.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import Foundation

let endpointLink = "https://cat-fact.herokuapp.com"
let facts = "/facts"

struct CatalogPage: Decodable {
    let used: Bool?
    let source: String?
    let type: String?
    let deleted: Bool?
    let _id: String?
    let user: String?
    let text: String?
    let createdAt: String?
    let updatedAt: String?
    let __v: Int?
}

struct AllItems: Decodable {
    let all: [Item]
}

struct Item: Decodable {
    let id: UUID = UUID()
    let _id: String?
    let text: String?
    let type: String?
    let user: User?
    let upvotes: Int?
    let userUpvoted: String?
}

struct User: Decodable {
    let _id: String?
    let name: Name?
}

struct Name: Decodable {
    let first: String?
    let last: String?
}

class NetworkManager {
    
    static func fetchPage(_ path: String? = nil, completionHandler: @escaping (CatalogPage) -> Void) {
        if let url = URL.init(string: path ?? endpointLink + facts + "/random") {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let page: CatalogPage = try? JSONDecoder().decode(CatalogPage.self, from: data!) {
                    completionHandler(page)
                }
            })
            task.resume()
        }
    }
    
    static func fetchAllPages(_ path: String? = nil, completionHandler: @escaping (AllItems) -> Void) {
        if let url = URL.init(string: path ?? endpointLink + facts) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let page: AllItems = try? JSONDecoder().decode(AllItems.self, from: data!) {
                    completionHandler(page)
                } 
            })
            task.resume()
        }
    }
}
