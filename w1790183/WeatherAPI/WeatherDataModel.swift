//
//  WeatherDataModel.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-05.
//

import SwiftUI

class WeatherModel: ObservableObject {
    @Published var forecast: Forecast?
    @Published var pollution: Pollution?
    @Published var city = ""
    
    @AppStorage(StorageKeys.city) private var keyCity: String = "London"
    @AppStorage(StorageKeys.lat) private var keyLat: Double = 0
    @AppStorage(StorageKeys.lon) private var keyLon: Double = 0
    
    init() {
        self.city = keyCity
        (self.forecast, self.pollution) = getWeatherJson()
    }
    
    /// - Description: Load data from a sample json file(saved API call)
    /// - Parameters:
    ///    - type: Type of the object that need ot be docaded from the response
    ///    - filename : Name of the json file
    /// - Returns: Decoded data from the given type
    func loadJson<T: Decodable>(_ type: T.Type, _ filename: String) -> T {
        let data: Data
        
        guard let jsonFile = Bundle.main.url(forResource: filename, withExtension: "json")
        else{
            fatalError("Coudn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: jsonFile)
        } catch {
            print("[WeatherModel][loadJson] Data Read ERROR")
            fatalError("Coudn't load \(filename) form main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            let forecast = try decoder.decode(type, from: data)
            return forecast
        } catch {
            print("[WeatherModel][loadJson] JSONDecoder ERROR")
            fatalError("Couldn't parse \(filename) as \(type):\n\(error)")
        }
    }
    
    /// - Description: Load data from API request
    /// - Parameters:
    ///    - type: Type of the object that need ot be docaded from the response
    ///    - url  : API get URL
    /// - Returns: Decoded data from the given type
    private func request<T: Decodable>(_ type: T.Type, for url: String) async throws -> T {
        print(url)
        guard let url = URL(string: url) else {
            throw fatalError("Invalid URL. Please check if the URL is correct")
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url) /// ignore the URLResponse - Assign to none (_)
            let weather = try JSONDecoder().decode(type, from: data)
            return weather
        } catch {
            print("[WeatherModel][request] ")
            throw error
        }
    }
}

// MARK: JSON methods
extension WeatherModel {
    /// - Description: Get locally saved data from the json file
    /// - Returns: (Forecast, Pollution)
    func getWeatherJson() -> (Forecast, Pollution) {
        let forecastJson = loadJson(Forecast.self, JSONFileNames.forecast)
        let pollutionJson = loadJson(Pollution.self, JSONFileNames.pollution)
        (keyLat, keyLon) = (forecastJson.lat, forecastJson.lon)
        return (forecastJson, pollutionJson)
    }
}

// MARK: API methods
extension WeatherModel {
    /// - Description: Get Forecast data for a given location using longitude and latitude from an API call.
    /// - Parameters:
    ///    - lat: Latitude of the location
    ///    - lon: Longitude fo the location
    func getForecast(lat: Double, lon: Double) async throws {
        let url3_0 = "\(OpenWeatherAPI.url3.rawValue)&lat=\(lat)&lon=\(lon)"
        do {
            let foracastModel = try await request(Forecast.self, for: url3_0)
            
            DispatchQueue.main.async {
                self.forecast = foracastModel
            }
        } catch {
            print("[WeatherModel][getForecast] ")
            throw error
        }
    }
    
    /// - Description: Get Pollution data from an API call. Note that this should be called after the getForecast() method since latitude and longitude fetch from it.
    func getPollutionWeather() async throws {
        guard let lat = forecast?.lat, let lon = forecast?.lon else {
            fatalError("[getPollutionWeather]: Latitude and Longitude cound't load first from the forecast data.")
        }
        let url2_5 = "\(OpenWeatherAPI.pollution.url2_5)&lat=\(lat)&lon=\(lon)"
        do {
            let pollutionModel = try await request(Pollution.self, for: url2_5)
            DispatchQueue.main.async {
                self.pollution = pollutionModel
            }
        } catch {
            print("[WeatherModel][getPollutionWeather] ")
            throw error
        }
    }
}



