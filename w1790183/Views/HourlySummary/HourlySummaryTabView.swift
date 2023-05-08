//
//  HourlySummaryTabView.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-05.
//

import SwiftUI

struct HourlySummaryTabView: View {
    
    @EnvironmentObject private var weatherModel: WeatherModel
    
    var body: some View {
        let hourlyForecast = weatherModel.forecast?.hourly ?? []
        
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("\(weatherModel.city)")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding()
                    .multilineTextAlignment(.center)
                
                List (hourlyForecast) { listItem in
                    HourlySummaryRecord(record: listItem)
                        .frame(height: 100)
                }
                .opacity(0.86)
            }
        }
    }
}

struct HourlySummaryTabView_Previews: PreviewProvider {
    static var previews: some View {
        HourlySummaryTabView()
            .environmentObject(WeatherModel())
    }
}
