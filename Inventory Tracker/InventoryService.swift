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

class InventoryService {
    let base = "http://67.207.78.14/";
    
    func getInventoryItems(callback: @escaping ([InventoryItem]) -> Void) {
        print("getting from \(base)")
        Alamofire.request(base).responseArray { (response: DataResponse<[InventoryItem]>) in
            
            if let inventoryItems = response.result.value {
                print(inventoryItems)
                callback(inventoryItems)
            } else {
                print("There was no object")
            }
        }
    }
}
