//
//  ContentView.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-05.
//

import SwiftUI

struct NavbarView: View {
    var body: some View {
        TabView {
            CityTabView()
                .tabItem {
                    Label("City", systemImage: "magnifyingglass")
                }
            WeatherNowTabView()
                .tabItem {
                    Label("WeatherNow", systemImage: "sun.max.fill")
                }
            HourlySummaryTabView()
                .tabItem {
                    Label("Hourly Summary", systemImage: "clock.fill")
                }
            ForecastTabView()
                .tabItem {
                    Label("Forecast", systemImage: "calendar")
                }
            PollutionTabView()
                .tabItem {
                    Label("Pollution", systemImage: "aqi.high")
                }
        }
        .onAppear {
            UITabBar.appearance().isTranslucent = false
        }
    }
}

