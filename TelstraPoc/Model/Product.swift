//
//  Product.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import Foundation

// Model to map data from Json
struct Product {
    var productName : String?
    var productImage : String?
    var productDesc : String?
}

// Model to map data from Json
struct ProductList {
    var productTittle : String?
    var productlist : [Product]
    init?(with tittle:String,_ list:[Product]) {
        self.productTittle = tittle
        self.productlist = list
    }
}
