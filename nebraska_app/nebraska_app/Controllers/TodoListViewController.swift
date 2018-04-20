//
//  ViewController.swift
//  nebraska_app
//
//  Created by fernando-mbp on 16/04/18.
//  Copyright © 2018 Fernando Funaki. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var todoListArray = [Item]()
    
    //creates a plist file to store data
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //Local storage
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()

        tableView.separatorStyle = .none
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
        
        let item = todoListArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - Delegate Methods - When selecting an item
    /*Accessory: Check mark*/
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todoListArray[indexPath.row].title)
        
        //set flag done
        todoListArray[indexPath.row].done = !todoListArray[indexPath.row].done
        
        self.saveItems()
        
        //update tableView
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Add new item button pressed
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            if textField.text != "" {
                let item = Item()
                item.title = textField.text!
                self.todoListArray.append(item)
                self.saveItems()
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter a new item"
            textField = alertTextField
        }
   
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.todoListArray)
            try data.write(to: self.dataFilePath!)
        }
        catch{
            print("Error encoding item array!")
        }
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder =  PropertyListDecoder()
            do {
                todoListArray = try decoder.decode([Item].self, from: data)
            }
            catch{
                print("Error decoding Items")
            }
        }
        
    }
}

