//
//  Util.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-07.
//

import Foundation
import Network

extension Int {
    /// - Description: Get given integer time to UTC format.
    /// - Returns: Date()
    func getUTCDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

extension Double {
    /// - Description: Convert a given double to a two decimal places
    /// - Returns: String
    func twoDecimal() -> String {
        return String(format: "%.2f", self)
    }
}
