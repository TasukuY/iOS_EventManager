//
//  NotificationScheduler.swift
//  EventManager
//
//  Created by Tasuku Yamamoto on 4/22/22.
//

import Foundation
import UserNotifications

protocol NotificatinoScheduler {
    func scheduleUserNotifications(for event: Event)
    func cancelUserNotifications(for event: Event)
}

extension NotificatinoScheduler {
    
    func scheduleUserNotifications(for event: Event){
        //create the content
        let content = UNMutableNotificationContent()
        content.title = "Reminder for the Event"
        content.body = "Time for \(event.title ?? "the Event")"
        content.sound = UNNotificationSound.defaultRingtone
        
        //create the trigger
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: event.date ?? Date())
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //create the request
        guard let eventID = event.uuID,
              !eventID.isEmpty
        else { return }
        
        let request = UNNotificationRequest(identifier: eventID, content: content, trigger: trigger)
        
        //add the request to the notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Unable to add notification request: \(error)")
            }
        }
    }
    
    func cancelUserNotifications(for event: Event){
        guard let eventID = event.uuID,
              !eventID.isEmpty
        else { return }
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [eventID])
    }
    
}//End of extension

