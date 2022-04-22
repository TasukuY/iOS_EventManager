//
//  CoreDataStack.swift
//  EventManager
//
//  Created by Tasuku Yamamoto on 4/22/22.
//

import Foundation
import CoreData

class CoreDataStack {
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EventManager")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error loading persistent stores \(error)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { container.viewContext }
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        }
    }
}//End of class
