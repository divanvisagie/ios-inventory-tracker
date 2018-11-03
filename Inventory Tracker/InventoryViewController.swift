//
//  ViewController.swift
//  Inventory Tracker
//
//  Created by Divan Visagie on 2018/10/28.
//  Copyright © 2018 Divan Visagie. All rights reserved.
//

import UIKit

class InventoryViewController: UITableViewController {
    
    var inventory = Inventory()
    
    override lazy var refreshControl: UIRefreshControl? = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(InventoryViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = navigationController?.navigationBar.barTintColor
        
        return refreshControl
    }()
    
    @objc func handleModelUpdate(notification: NSNotification) {
        tableView.reloadData()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refresh()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    

    
    func refresh() {
        inventory.getInventoryItems ()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("view did load")
        if let rc = self.refreshControl {
            self.tableView.addSubview(rc)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleModelUpdate(notification:)), name: .listUpdated, object: nil)
        
        refresh()
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        print("undwind called")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let navigationViewController = segue.destination as? UINavigationController {
            
            if let addItemViewController = navigationViewController.viewControllers.first as? AddItemViewController {
            
                    addItemViewController.inventory = inventory
            }
            
        } else {
            print("There is no destination navigation controller")
        }
        print("prepare for the segue")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventory.inventoryItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryItemCell")
        
        let inventoryItem = inventory.inventoryItems[indexPath.row]
        
    
        cell?.textLabel?.text = inventoryItem.name
        cell?.detailTextLabel?.text  = inventoryItem.description
        
        
        return cell!
    }
}

