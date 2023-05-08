//
//  Pollution.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-05.
//

import Foundation

struct Pollution: Codable {
    let list: [PollutionList]
}

struct PollutionList: Codable {
    let components: PollutionComponents
}

struct PollutionComponents: Codable {
    let so2: Double
    let co: Double
    let no: Double
    let pm10: Double
}
