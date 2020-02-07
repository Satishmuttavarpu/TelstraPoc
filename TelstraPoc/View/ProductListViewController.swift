//
//  ProductListViewController.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import UIKit

class ProductListViewController: UITableViewController {

    internal let refreshcontrol : UIRefreshControl = {
        let rc = UIRefreshControl()
        let title = NSLocalizedString(pullToRefresh, comment: pullToRefresh)
        rc.attributedTitle = NSAttributedString(string: title)
        rc.addTarget(self, action: #selector(refreshOptions(sender:)), for: UIControl.Event.valueChanged)
        return rc
    }()
    
    var productviewmodel = ProductListViewModel()
    let cellId = "cellId"
    
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
            //productviewmodel.delegate = self
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

