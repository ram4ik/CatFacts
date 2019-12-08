//
//  NetworkManager.swift
//  CatFacts
//
//  Created by Ramill Ibragimov on 08.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import Foundation

let endpointLink = "https://cat-fact.herokuapp.com/facts/random"

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

class NetworkManager {
    
    static func fetchPage(_ path: String? = nil, completionHandler: @escaping (CatalogPage) -> Void) {
        if let url = URL.init(string: path ?? endpointLink) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let page: CatalogPage = try? JSONDecoder().decode(CatalogPage.self, from: data!) {
                    completionHandler(page)
                }
            })
            task.resume()
        }
    }
}
