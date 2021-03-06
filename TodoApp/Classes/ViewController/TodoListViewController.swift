//
//  ViewController.swift
//  TodoApp
//
//  Created by masumi on 2016/05/12.
//  Copyright © 2016年 nendworks. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    var todoEntities: [Todo]!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        todoEntities = Todo.MR_findAll() as? [Todo]
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoEntities = Todo.MR_findAll() as? [Todo]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoEntities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodoListItem")
        cell!.textLabel!.text = todoEntities[indexPath.row].item
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            todoEntities.removeAtIndex(indexPath.row).MR_deleteEntity()
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
            tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "edit" {
            let todoController = segue.destinationViewController as! TodoItemViewController
            let task = todoEntities[tableView.indexPathForSelectedRow!.row]
            todoController.task = task
        }
    }

}