//
//  Event+Convenience.swift
//  EventManager
//
//  Created by Tasuku Yamamoto on 4/22/22.
//

import Foundation
import CoreData

extension Event {
    @discardableResult convenience init(title: String, date: Date ,context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.title = title
        self.date = date
        self.attending = true
        self.uuID = UUID().uuidString
    }
}//End of extension
