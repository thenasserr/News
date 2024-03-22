//
//  String+Ext.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import UIKit

extension String {
    func convertDateStringToDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MMM dd, yyyy"
            dateFormatter.timeZone = TimeZone.current
            
            return dateFormatter.string(from: date)
        } else {
            print("Invalid date format")
            return nil
        }
    }
    
    func formatDate() -> String? {
        let isoDateFormatter = ISO8601DateFormatter()
        
        if let date = isoDateFormatter.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = "HH:mm"
            let formattedDate = dateFormatter.string(from: date)
            
            return formattedDate
            
        }
        return nil
    }
}
