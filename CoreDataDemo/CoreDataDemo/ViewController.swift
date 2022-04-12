//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Sajjad Malik on 12.04.22.
//

import UIKit

class ViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    var models = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        getAllItems()
        title = "To Do List Core Data"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New", message: "Enter new Item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "submit", style: .default, handler: { _ in
            guard let feild = alert.textFields?.first, let text = feild.text, !text.isEmpty else {
                return
            }
            self.createItem(name: text)
        }))
        present(alert, animated: true)
    }
    func getAllItems() {
        do {
            models = try context.fetch(ToDoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            
        }
        
        
    }
    
    func createItem(name: String) {
        let newItem = ToDoListItem(context: context)
        newItem.name = "dsad"
        newItem.createdAt = Date()
        
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
    
    func deleteItem(item: ToDoListItem) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func updateItem(item: ToDoListItem, newName: String) {
        item.name = newName
        do {
            try context.save()
        } catch {
            
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    
    
    
    
}
