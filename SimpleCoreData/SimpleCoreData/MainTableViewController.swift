//
//  MainTableViewController.swift
//  SimpleCoreData
//
//  Created by 賢瑭 何 on 2016/5/28.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private let dataManager = ManageData.sharedManagedData
    
    var entities = [Entity]()
    
    var fetchController: NSFetchedResultsController?

    @IBAction func addData(sender: AnyObject) {
        let vc = UIAlertController(title: "Add Name", message: "Type the name", preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let add = UIAlertAction(title: "Add", style: .Default) { _ in
            if let textfield = vc.textFields?.first {
                if textfield.text?.characters.count > 0 {
                    self.dataManager.addData(textfield.text!)
                }
            }
        }
        vc.addTextFieldWithConfigurationHandler { textfield in
            textfield.placeholder = "Please enter your name"
            
        }
        vc.addAction(cancel)
        vc.addAction(add)
        presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSFetchRequest(entityName: "Entity")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataManager.moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchController?.delegate = self
        do {
            try fetchController?.performFetch()
            
        }catch{
            fatalError("Can't fetch the request")
        }
        if fetchController?.fetchedObjects is [Entity] {
            entities = fetchController?.fetchedObjects as! [Entity]
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "MainCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = entities[indexPath.row].name
        return cell
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    // change the source data
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        default:
            break
        }
        // update entities with new source data
        entities = controller.fetchedObjects as! [Entity]
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let name = entities[indexPath.row].name
            if let attributeName = name {
                dataManager.deleteData(entityName: "Entity", attributeName: attributeName, completion: { complete in
                    if complete {
                        //self.entities.removeAtIndex(indexPath.row)
                        
                        // entities are simultaneously when you just delete the source data, the
                        // resultControllerDelegate will be notified and reload the data you specify in the
                        // delegate methods.
                    }
                })
            }
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            // This will conflict when you already explicit it in delegate methods.
        } else  {
            return
        }
    }
}
