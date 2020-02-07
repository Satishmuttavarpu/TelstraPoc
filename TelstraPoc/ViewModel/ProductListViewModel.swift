//
//  ProductListViewModel.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import Foundation

// Protocal to notify tableview content is fetched
protocol NotificationProtocal {
    func updateContentOnView()
    func updateError()
}


class ProductListViewModel: NSObject {
    
    var delegate : NotificationProtocal?
    var datalist = [Product]()
    var headerTittle:String?
    
    override init() {
    }
    
    // Function to Fetch Data
    func fetchData() {
        
        
    }
}
