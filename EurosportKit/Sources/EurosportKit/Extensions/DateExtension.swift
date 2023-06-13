//
//  DateExtension.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import Foundation

public extension Date {

    var formattedDateComparedToNow: String {

        let calendar = Calendar.current

        // In the last 60 seconds -> A l'instant
        if -timeIntervalSinceNow < 60 {
            return String(format: "Now")
        }

        // In the last hour (60 * 60 seconds) -> Il y a xmin
        if -timeIntervalSinceNow < 60 * 60 {
            return String(format: "%.0f min ago", -timeIntervalSinceNow / 60)
        }

        // Today -> xx:xx
        if calendar.isDateInToday(self) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateStyle = .none
            timeFormatter.timeStyle = .short
            
            return timeFormatter.string(from: self)
        }

        // Yesterday
        if calendar.isDateInYesterday(self) {
            return "Yesterday"
        }

        // Otherwise -> jj/mm/aaaa
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: self)
    }
}
