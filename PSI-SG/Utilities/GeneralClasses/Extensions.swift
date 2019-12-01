//
//  Extensions.swift
//  PSI-SG
//
//  Created by Praful Mahajan on 30/11/19.
//  Copyright © 2019 prafulmahajan. All rights reserved.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

extension Double {
    //**************************************************
    // MARK: - Methods
    //**************************************************
    func toString()->String{
        return String(format: "%.2f", self)
    }
}

extension Date {
    func toShowDateWithTime()-> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "hh:mm a 'on' MMM dd, yyyy"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        let dateString = formatter.string(from: self)
        return dateString   // "4:44 PM on June 23, 2016\n"
    }
}

extension String {
    func toDateFromGmtString() -> Date? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.init(identifier: "en-US")
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0 * 3600)
        return dateFormatter.date(from: self)
    }
}
