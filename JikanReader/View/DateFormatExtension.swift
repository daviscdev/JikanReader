//
//  DateFormatExtension.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/9.
//

import Foundation

extension DateFormatter {
    static let inputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxx"
        return formatter
    }()
    
    static let outputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
}

extension String {
    func dateFormated() -> String {
        guard let date = DateFormatter.inputDateFormatter.date(from: self) else { return self }
        DateFormatter.outputDateFormatter.dateFormat = "yyyy/MM/dd"
        return DateFormatter.outputDateFormatter.string(from: date)
    }
}
