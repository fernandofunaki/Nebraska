//
//  ViewController.swift
//  nebraska_app
//
//  Created by fernando-mbp on 16/04/18.
//  Copyright © 2018 Fernando Funaki. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var todoListArray = ["Comrar Leite", "Comprar Café", "Comprar Pão"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            todoListArray = items
        }
        
        tableView.separatorStyle = .none
       
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
//        tableView.addGestureRecognizer(tapGesture)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK - Tableview Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = todoListArray[indexPath.row]
        return cell
    }
    
    //MARK - Delegate Methods
    /*Accessory: Check mark*/
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todoListArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //Button Events
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            if textField.text != "" {
                self.todoListArray.append(textField.text!)
                print(textField.text!)
                self.defaults.set(self.todoListArray, forKey: "TodoListArray")
                self.tableView.reloadData()
            }
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter a new item"
            textField = alertTextField
            
            print(alertTextField.text)
        }
   
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
}

