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
    
    let networkManager = NetworkManager()
    
    var delegate : NotificationProtocal?
    var datalist = [Product]()
    var headerTittle:String?
    
    override init() {
    }
    
    
    // Function to Fetch Data
    func fetchData() {
        
        networkManager.getNewFacts(page: 1) { [weak self] productList , error in
            guard let weakSelf = self else {
                return
            }
            guard error == nil else {
                print(error!)
                self?.delegate?.updateError()
                return
            }
            guard let list = productList else {
                return
            }
            
            guard let tittle = list.productTittle else {
                return
            }
            
            weakSelf.headerTittle = tittle
            weakSelf.datalist = list.productlist
            weakSelf.delegate?.updateContentOnView()
        }
    }
}
