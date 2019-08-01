//
//  ViewController.swift
//  learningCoreData
//
//  Created by akhigbe benjamin on 31/07/2019.
//  Copyright © 2019 akhigbe benjamin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
   
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //to retrieve the value that was saved in our userDefault method
        
        
        loadItems()
        
        }
//MARK - TableView DataSource Methods
    
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.titles
        
        
        //set the cells in the tableView to have an accessoryType of checkMark
        //tenary operator value = condition ? valueIFTrue : valueIffalse
        
     cell.accessoryType = item.done ? .checkmark : .none
        

        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        //checking if the cell as been used before
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        self.saveItem()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New items 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        //UIAlertAction is used to create a button for the user to press
        let action = UIAlertAction(title: "Add item", style: .default) {
            (action) in
            
            let newItem = Item()
            guard newItem.titles == textField.text else {
                return
            }
            self.itemArray.append(newItem)
            
            self.saveItem()
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        //show your alert by using present
        present(alert, animated: true, completion: nil )
        
    }
    
    //MARK - Model Manipulation Method (a save Data method)
    
    func saveItem() {
        
        //create an instance encoder of a propertyPlist encoder
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode( itemArray)
            try data.write(to: dataFilePath!)
        }
        catch {
            
            print("Error in encoding arrays \(error)")
            
        }
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
       
        guard let data = try?  Data(contentsOf: dataFilePath!) else {
            return
        }
        let decoder = PropertyListDecoder()
        do {
       itemArray = try  decoder.decode([Item].self, from: data)
            
        }catch {
             print("Error in decoding array Item \(error)")
        }
        
    }
    
}

