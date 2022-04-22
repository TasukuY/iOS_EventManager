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
    var sections: [[Event]] { [attendingEvents, notAttendingEvents] }
    var attendingEvents: [Event] = []
    var notAttendingEvents: [Event] = []
    
    private lazy var fatchRequest: NSFetchRequest<Event> = {
        let request  = NSFetchRequest<Event>(entityName: "Event")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    //MARK: - CRUD funcs
    func createNewEvent(with title: String, and date: Date){
        let newEvent = Event(title: title, date: date)
        attendingEvents.append(newEvent)
        CoreDataStack.saveContext()
        scheduleUserNotifications(for: newEvent)
    }
    
    func update(_ event: Event, with newTitle: String, and newDate: Date){
        event.title = newTitle
        event.date = newDate
        CoreDataStack.saveContext()
        cancelUserNotifications(for: event)
        if event.attending {
            scheduleUserNotifications(for: event)
        }else {
            cancelUserNotifications(for: event)
        }
    }
    
    func toggleAttendanceState(of event: Event){
        event.attending = !event.attending
        CoreDataStack.saveContext()
        if event.attending{
            if let index = notAttendingEvents.firstIndex(of: event){
                notAttendingEvents.remove(at: index)
                attendingEvents.append(event)
            }
            scheduleUserNotifications(for: event)
        }else {
            if let index = attendingEvents.firstIndex(of: event){
                attendingEvents.remove(at: index)
                notAttendingEvents.append(event)
            }
            cancelUserNotifications(for: event)
        }
    }
    
    func delete(_ event: Event){
        if let index = attendingEvents.firstIndex(of: event){
            attendingEvents.remove(at: index)
        }else if let index = notAttendingEvents.firstIndex(of: event) {
            notAttendingEvents.remove(at: index)
        }
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
        cancelUserNotifications(for: event)
    }
    
    //MARK: - Methods
    func fetchEvents(){
        let fetchedEvents = (try? CoreDataStack.context.fetch(self.fatchRequest)) ?? []
        self.attendingEvents = fetchedEvents.filter{ $0.attending }
        self.notAttendingEvents = fetchedEvents.filter{ !$0.attending }
    }
    
}//End of class

extension EventController: NotificatinoScheduler {}
