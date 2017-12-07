//
//  CoreDataManager.swift
//  iHungry
//
//  Created by Michael Douglas on 19/01/17.
//  Copyright © 2017 Michael Douglas. All rights reserved.
//

import Foundation
import CoreData

//**************************************************************************************************
//
// MARK: - Constants -
//
//**************************************************************************************************

//**************************************************************************************************
//
// MARK: - Definitions -
//
//**************************************************************************************************

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************

class CoreDataManager {
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    
    static var context: NSManagedObjectContext {
        get{
            return CoreDataManager.persistentContainer.viewContext
        }
    }
    
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "iHungry")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //*************************************************
    // MARK: - Class Methods
    //*************************************************
    
    // MARK: - Core Data Saving support
    
    class func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
