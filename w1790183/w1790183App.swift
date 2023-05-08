//
//  w1790183App.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-05.
//

import SwiftUI

@main
struct w1790183App: App {
    
    @StateObject private var weatherModel = WeatherModel()
    
    var body: some Scene {
        WindowGroup {
            NavbarView()
                .environmentObject(weatherModel)
        }
    }
}
