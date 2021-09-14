//
//  PublicationDate.swift
//  BookCase
//
//  Created by Mohamed Zakaria on 5/9/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import Foundation

struct PublicationDate: CustomStringConvertible {
    
    // MARK: - Properties
    var date: Date
    var dateType: DateType
    
    // Return a custom description for the different date types
    var description: String {
        let dateFormatter = DateFormatter()
        switch dateType {
        case .Year:
            dateFormatter.dateFormat = "yyyy"
        case .YearMonth:
            dateFormatter.dateFormat = "MMMM yyyy"
        case .YearMonthDay:
            dateFormatter.dateStyle = DateFormatter.Style.long
        }
        return dateFormatter.string(from: date)
    }
    
    enum DateType: String {
        case Year = "yyyy"
        case YearMonth = "yyyy-MM"
        case YearMonthDay = "yyyy-MM-dd"
        static let allValues = [Year, YearMonth, YearMonthDay]
    }
    
    // MARK: - Convert isoDateString to Date
    static func from(isoDate: String?) -> PublicationDate?{
        guard let isoDate = isoDate else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        
        // Iterate over the different DateTypes and format
        // a Date from String with the proper date format
        for dateType in DateType.allValues {
            dateFormatter.dateFormat = dateType.rawValue
            if let date = dateFormatter.date(from: isoDate) {
                // If a format matched, store values and return
                return PublicationDate(date: date, dateType: dateType)
            }
        }
        // No valid date present
        return nil
    }
    
}
