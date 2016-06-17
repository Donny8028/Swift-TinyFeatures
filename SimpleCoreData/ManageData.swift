//
//  ManageData.swift
//  SimpleCoreData
//
//  Created by 賢瑭 何 on 2016/5/28.
//  Copyright © 2016年 Donny. All rights reserved.
//

import UIKit
import CoreData

class ManageData {
    
    static let sharedManagedData = ManageData()
    
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func addData(name: String) -> String? {
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Entity", inManagedObjectContext: moc) as? Entity
        entity?.name = name
        
        do {
            try moc.save()
        }catch{
            fatalError("Save Problem")
        }
        
        return name
    }
    
    func showData(entityName entity: String) {
        let request = NSFetchRequest(entityName: entity)
        
        do {
            let results = try moc.executeFetchRequest(request) as! [Entity]
            
            for result in results {
                print("Entity name: \(result)")
            }
        }catch{
            fatalError("Can not show the result of the request")
        }
    }
    
    func deleteData(entityName entity: String, attributeName attribute: String, completion:(Bool) -> Void) {
        let request = NSFetchRequest(entityName: entity)
        var valid = false
        do {
            let results = try moc.executeFetchRequest(request) as! [Entity]
            let deleteAttribute = results.filter{ $0.name == attribute }
            if !deleteAttribute.isEmpty  {
                for entity in deleteAttribute{
                    moc.deleteObject(entity)
                }
                do {
                    try moc.save()
                    valid = true
                }catch {
                    fatalError("Save failure")
                }
            }else{
                print("There's no such attribute name")
            }
        }catch {
            fatalError("Can not find the entity")
        }
        completion(valid)
    }
    
    
    func updateDate(entityName entity:String, targetAttributeName oldAttribute: String, updateAttributeName newAttribute: String) -> Bool{
        let request = NSFetchRequest(entityName: entity)
        request.predicate = NSPredicate(format: "name == %@",oldAttribute)
        var targetObject: NSManagedObject?
        do {
            let results = try moc.executeFetchRequest(request)
            if !results.isEmpty {
                targetObject = results[0] as? NSManagedObject
            }else{
                print("Can not find the attribute name")
                return false
            }
            
        }catch {
            fatalError("Can not implement the request with the entity name")
        }
        if let entity = targetObject as? Entity{
            entity.name = newAttribute
            do {
                try moc.save()
            }catch {
                fatalError("Update failure")
            }
            return true
        }else{
            return false
        }
    }
}