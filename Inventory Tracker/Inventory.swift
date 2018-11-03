//
//  InventoryService.swift
//  Inventory Tracker
//
//  Created by Divan Visagie on 2018/10/29.
//  Copyright © 2018 Divan Visagie. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

extension Notification.Name {
    static let listUpdated = Notification.Name("listUpdated")
}

class InventoryItem: Mappable {
    var id: Int?
    var name: String?
    var description: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
    }

}

class Inventory {
    let base = "http://67.207.78.14";
    
    var inventoryItems =  [InventoryItem]()
    
    func getInventoryItems() {
        print("getting from \(base)")
        Alamofire.request(base).responseArray { (response: DataResponse<[InventoryItem]>) in
            
            if let inventoryItems = response.result.value {
                print(inventoryItems)
                self.inventoryItems = inventoryItems
                NotificationCenter.default.post(name: .listUpdated, object: nil)
            } else {
                print("There was no object")
            }
        }
    }
    
    func addItem(withName name: String, andDescription description: String = "") {
        let parameters = [
            "name": name,
            "description": description,
            "count": 1
            ] as [String : Any]
        
        
        Alamofire.request(base, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            
            if let error = response.error {
                print("Broke with error \(error)")
            } else {
               //we need to get an updated version of the list
                self.getInventoryItems()
            }
        }
    }
    
    func removeItem(withIndex index: Int) {
        let item = self.inventoryItems[index]
        inventoryItems.remove(at: index)
        self.removeItem(item: item)
    }
    
    private func removeItem(item: InventoryItem) {
       
        if let id = item.id {
            Alamofire.request("\(base)/\(id)", method: .delete).response { response in
                
                if let error = response.error {
                    print("Broke with error \(error)")
                } else {
                    //we need to get an updated version of the list
                    self.getInventoryItems()
                }
            }
        } else {
            print("Can't delete on server because item has no id")
        }
        
    }
}
