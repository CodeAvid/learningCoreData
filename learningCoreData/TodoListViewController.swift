//
//  ViewController.swift
//  learningCoreData
//
//  Created by akhigbe benjamin on 31/07/2019.
//  Copyright © 2019 akhigbe benjamin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Find Mike", "But Orange", "Read your note"]

    override func viewDidLoad() {
        super.viewDidLoad()
       
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

}

