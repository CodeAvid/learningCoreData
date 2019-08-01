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
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //to retrieve the value that was saved in our userDefault method
        
        let newItem1 = Item()
        newItem1.titles = "Find Mike"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.titles = "Buy Orange"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.titles = "Read Your note"
        itemArray.append(newItem3)
        
        
        
        guard let items = defaults.array(forKey: "TodoListArray") as? [Item] else {
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
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.titles
        
        
        //set the cells in the tableView to have an accessoryType of checkMark
        //tenary operator value = condition ? valueIFTrue : valueIffalse
        
//       cell.accessoryType = item.done ? .checkmark : .none
        

        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        //checking if the cell as been used before
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

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
            
            let newItem = Item()
            guard newItem.titles == textField.text else {
                return
            }
            self.itemArray.append(newItem)
            
            // set in the userDefault method is used to store th e value that you want to persist.
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

