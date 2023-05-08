//
//  Keys.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-05.
//

import Foundation

enum OpenWeatherAPI: String {
    case weather = "weather"
    case forecast = "forecast"
    case pollution = "air_pollution"
    case url3 = "https://api.openweathermap.org/data/3.0/onecall?appid=96bb0d7858ac9e8c966073d83a0c3b13&units=metric"
    
    var url2_5: String {
        return "https://api.openweathermap.org/data/2.5/\(self.rawValue)?appid=96bb0d7858ac9e8c966073d83a0c3b13&units=metric"
    }
}

enum StorageKeys {
    static let firstTimeOpen: String = "appstorage.key.first-time-open"
    static let city: String = "appstorage.key.city"
    static let lat: String = "appstorage.key.latitude"
    static let lon: String = "appstorage.key.longitude"
}

enum JSONFileNames {
    static let pollution: String = "london-data-pollution"
    static let forecast: String = "london-data-forecast"
}
