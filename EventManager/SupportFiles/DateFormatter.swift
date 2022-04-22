//
//  DateFormatter.swift
//  EventManager
//
//  Created by Tasuku Yamamoto on 4/22/22.
//

import Foundation

extension Date {
    
    //MARK: - Methods
    func toString() -> String {
        let formatDates = DateFormatter()
        let formatTimes = DateFormatter()
        formatDates.dateFormat = "MMM d"
        formatTimes.dateFormat = "h:mm a"
        let dateString = formatDates.string(from: self)
        let timeString = formatTimes.string(from: self)
        return "\(dateString) at \(timeString)"
    }
    
}//End of extension
