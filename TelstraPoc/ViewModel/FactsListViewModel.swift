//
//  FactsListViewModel.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 11/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import Foundation

// Protocal to notify tableview content is fetched
protocol NotificationProtocal {
    func updateContentOnView()
    func updateError()
}

class FactsListViewModel: NSObject {
    
    let networkManager = NetworkManager()
    var delegate : NotificationProtocal?
    var datalist = [Fact]()
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
                DispatchQueue.main.async{
                    self?.delegate?.updateError()
                }
                
                return
            }
            guard let list = productList else {
                return
            }
            
            guard let tittle = list.factTittle else {
                return
            }
            
            weakSelf.headerTittle = tittle
            weakSelf.datalist = list.factslist
            weakSelf.delegate?.updateContentOnView()
        }
    }
}
