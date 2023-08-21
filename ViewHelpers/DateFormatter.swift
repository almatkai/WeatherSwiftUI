//
//  DateFormatter.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 21.08.2023.
//

import Foundation
import CoreLocation

public func extractHour(from unixTimestamp: Int, timeZone: String = TimeZone.current.identifier) -> Int? {
    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(identifier: timeZone) ?? TimeZone.current
    
    let hour = calendar.component(.hour, from: date)
    return hour
}

public func extractHourFromUnixTimestamp(unixTimestamp: Int) -> Int? {
    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    return hour
}

func extractTimeFromUnixTimestamp(unixTimestamp: Int, timeZone: String = TimeZone.current.identifier) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    dateFormatter.timeZone = TimeZone(identifier: timeZone)
    let hourMinute = dateFormatter.string(from: date)
    return hourMinute
}

