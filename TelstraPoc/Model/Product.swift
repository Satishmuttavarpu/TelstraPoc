//
//  Product.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import Foundation


struct FactsApiResponse {
    let title: String
    let products: [Product]
}


extension FactsApiResponse: Decodable {
    
    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case title = "title"
        case products = "rows"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        products = try container.decode([Product].self, forKey: .products)
        
    }
}


struct Product {
    let productName : String
    let productImageUrl : String
    let productDesc : String
}

extension Product: Decodable {
    
    enum MovieCodingKeys: String, CodingKey {
        case productName = "title"
        case productImageUrl = "description"
        case productDesc = "imageHref"
    }
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        productName = try movieContainer.decode(String.self, forKey: .productName)
        productImageUrl = try movieContainer.decode(String.self, forKey: .productImageUrl)
        productDesc = try movieContainer.decode(String.self, forKey: .productDesc)
    }
}



