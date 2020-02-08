//
//  EndPointType.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import UIKit



class ObjectMapper : NSObject{
    
    static public let objectmapper = ObjectMapper()
    
    var productList:ProductList?

    private var datalist = [Product]()
    
    public override init() {
        
    }
        
    func map(dict: [String: Any]?)  {
        datalist.removeAll()
        guard let json = dict else {
            print("No data")
            return
        }
        guard let tittle = json["title"] as? String else {
            return
        }
        
        //weakSelf.headerTittle = tittle
        
        guard let jsonArray = json["rows"] as? [[String: Any]] else {
            return
        }
        

        //print("Total Products:\(jsonArray)")
        for json in jsonArray
        {
            datalist.append(Product(productName: json["title"] as? String ?? "No value", productImage: json["imageHref"] as? String ?? "" , productDesc: json["description"] as? String ?? "No Value"))
        }
        productList = ProductList(with: tittle, datalist)
    }
}

