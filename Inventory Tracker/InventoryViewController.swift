//
//  ViewController.swift
//  Inventory Tracker
//
//  Created by Divan Visagie on 2018/10/28.
//  Copyright © 2018 Divan Visagie. All rights reserved.
//

import UIKit

class InventoryViewController: UITableViewController {
    
    var inventoryItems: [InventoryItem] = []
    var inventoryService = InventoryService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("view did load")
        inventoryService.getInventoryItems { items in
            self.inventoryItems = items
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryItemCell")
        
        let inventoryItem = inventoryItems[indexPath.row]
        
    
        cell?.textLabel?.text = inventoryItem.name
        cell?.detailTextLabel?.text  = inventoryItem.description
        
        
        return cell!
    }
}

