//
//  AddItemViewController.swift
//  Inventory Tracker
//
//  Created by Divan Visagie on 2018/10/29.
//  Copyright © 2018 Divan Visagie. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addPressed(_ sender: Any) {
        
        let description = descriptionTextField.text ?? ""
    
        if let name = nameTextField.text {
            inventoryService.addItem(withName: name, andDescription: description)
        } else {
            print("We need a name to continue")
        }
        dismiss(animated: true, completion: nil)
    }
    
    var inventoryService = InventoryService()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
