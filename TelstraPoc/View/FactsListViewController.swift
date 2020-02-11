//
//  FactsListViewController.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 11/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import UIKit

class FactsListViewController: UITableViewController,NotificationProtocal {
    
    internal let refreshcontrol : UIRefreshControl = {
          let rc = UIRefreshControl()
          let title = NSLocalizedString(pullToRefresh, comment: pullToRefresh)
          rc.attributedTitle = NSAttributedString(string: title)
          rc.addTarget(self, action: #selector(refreshOptions(sender:)), for: UIControl.Event.valueChanged)
          return rc
      }()
      
      var factsviewmodel = FactsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Refresh Control to Table View
              if #available(iOS 10.0, *) {
                  tableView.refreshControl = refreshcontrol
              } else {
                  tableView.addSubview(refreshcontrol)
              }
              //Register pructCustom Cell on tableView
              tableView.register(FactsCustumCell.self, forCellReuseIdentifier: cellId)
              tableView.allowsSelection = false
              self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
              tableView.estimatedRowHeight = 100
              tableView.rowHeight = UITableView.automaticDimension

       
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
            factsviewmodel.delegate = self
            factsviewmodel.fetchData();
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

extension FactsListViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FactsCustumCell
        let currentLastItem = factsviewmodel.datalist[indexPath.row]
        cell.updateContentOnCell(fact: currentLastItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factsviewmodel.datalist.count
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
            self?.navigationItem.title = self?.factsviewmodel.headerTittle
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

