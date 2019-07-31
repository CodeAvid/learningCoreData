//
//  ViewController.swift
//  learningCoreData
//
//  Created by akhigbe benjamin on 31/07/2019.
//  Copyright © 2019 akhigbe benjamin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "But Orange", "Read your note"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //to retrieve the value that was saved in our userDefault method
        
        guard let items = defaults.array(forKey: "TodoListArray") as? [String] else {
            return
            
        }
        itemArray = items
       
    }
//MARK - TableView DataSource Methods
    
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        //set the cells in the tableView to have an accessoryType of checkMark
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
              tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
              tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New items 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        //UIAlertAction is used to create a button for the user to press
        let action = UIAlertAction(title: "Add item", style: .default) {
            (action) in
            guard let text = textField.text else {
                return
            }
            self.itemArray.append(text)
            
            // set in the userDefault method is used to store the value that you want to persist. 
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        //show your alert by using present
        present(alert, animated: true, completion: nil )
        
    }
    
}

