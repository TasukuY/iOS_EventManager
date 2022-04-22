//
//  EventController.swift
//  EventManager
//
//  Created by Tasuku Yamamoto on 4/22/22.
//

import Foundation
import CoreData

class EventController{
    //MARK: - Properties
    static let shared = EventController()
    var events: [Event] = []
    
    private lazy var fatchRequest: NSFetchRequest<Event> = {
        let request  = NSFetchRequest<Event>(entityName: "Event")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    //MARK: - CRUD funcs
    func createNewEvent(with title: String, and date: Date){
        let newEvent = Event(title: title, date: date)
        events.append(newEvent)
        CoreDataStack.saveContext()
    }
    
    func update(_ event: Event, with newTitle: String, and newDate: Date){
        event.title = newTitle
        event.date = newDate
        CoreDataStack.saveContext()
    }
    
    func toggleAttendanceState(of event: Event){
        event.attending = !event.attending
        CoreDataStack.saveContext()
    }
    
    func delete(_ event: Event){
        guard let index = events.firstIndex(of: event) else { return }
        events.remove(at: index)
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
    }
    
    //MARK: - Methods
    func fetchEvents(){
        let fetchedEvents = (try? CoreDataStack.context.fetch(self.fatchRequest)) ?? []
        self.events = fetchedEvents
    }
    
}//End of class
