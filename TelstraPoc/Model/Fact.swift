//
//  Product.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import Foundation

// Model to map data from Json
struct Fact {
    var factName : String?
    var factImage : String?
    var factDesc : String?
}

// Model to map data from Json
struct FactsList {
    var factTittle : String?
    var factslist : [Fact]
    init?(with tittle:String,_ list:[Fact]) {
        self.factTittle = tittle
        self.factslist = list
    }
}
