//
//  String+Extensions.swift
//  Amiibo
//
//  Created by Rodrigo Valladares on 11/6/23.
//

import Foundation

extension String {
    var dateFormat: String {
        let currentDateFormat = DateFormatter()
        currentDateFormat.timeZone = .current
        currentDateFormat.dateFormat = "yyyy-MM-dd"
        guard let date = currentDateFormat.date(from: self) else {
            return "--"
        }
        currentDateFormat.dateFormat = "MMM d, yyyy"
        let newDate = currentDateFormat.string(from: date)
        return newDate
    }
}
