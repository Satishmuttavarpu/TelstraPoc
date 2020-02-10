//
//  ProductListViewController.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import UIKit

class ProductListViewController: UITableViewController,NotificationProtocal {

    internal let refreshcontrol : UIRefreshControl = {
        let rc = UIRefreshControl()
        let title = NSLocalizedString(pullToRefresh, comment: pullToRefresh)
        rc.attributedTitle = NSAttributedString(string: title)
        rc.addTarget(self, action: #selector(refreshOptions(sender:)), for: UIControl.Event.valueChanged)
        return rc
    }()
    
    var productviewmodel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshcontrol
        } else {
            tableView.addSubview(refreshcontrol)
        }
        
        //
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        //
        tableView.register(ProductCustomCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsSelection = false
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //For
        retrieveAPIData()
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        // Perform actions to refresh the content
        retrieveAPIData()
    }
    
    //Funtion to retrieveAPIData
    private func retrieveAPIData() {
        if ReachabilityTest.isConnectedToNetwork() {
            productviewmodel.delegate = self
            productviewmodel.fetchData();
            
            //Calling Viewmodel class to fetchdata
        }
        else{
            let alert = UIAlertController(title: internetConnection, message: noInternetAvailable , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: cancel , style: .cancel, handler: {[weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.refreshcontrol.endRefreshing()
            }))
            self.present(alert, animated: true, completion: nil)
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        }
    }
}

extension ProductListViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCustomCell
        let currentLastItem = productviewmodel.datalist[indexPath.row]
        cell.updateContentOnCell(product: currentLastItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productviewmodel.datalist.count
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func updateContentOnView(){
        DispatchQueue.main.async{ [weak self] in
            guard let weakSelf = self else { return }
            // and then dismiss the control
            weakSelf.refreshControl?.endRefreshing()
            weakSelf.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            weakSelf.tableView.reloadData()
            self?.navigationItem.title = self?.productviewmodel.headerTittle
        }
    }
    func updateError()
    {
        let alert = UIAlertController(title: secureError, message: noData , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: {[weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.refreshcontrol.endRefreshing()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
