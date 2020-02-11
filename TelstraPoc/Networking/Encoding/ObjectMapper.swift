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
    
    var factsList:FactsList?

    private var datalist = [Fact]()
    
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
            datalist.append(Fact(factName: json["title"] as? String ?? "No value", factImage: json["imageHref"] as? String ?? "", factDesc: json["description"] as? String ?? "No Value"))
        }
        factsList = FactsList(with: tittle, datalist)
    }
}

