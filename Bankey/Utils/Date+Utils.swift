//
//  Date+Utils.swift
//  Bankey
//
//  Created by Abdallah Mahameed on 15/09/2022.
//

import Foundation

extension Date {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.autoupdatingCurrent
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
