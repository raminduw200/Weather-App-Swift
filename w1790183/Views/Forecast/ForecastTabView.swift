//
//  ForecastTabView.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-05.
//

import SwiftUI

struct ForecastTabView: View {
    
    @EnvironmentObject private var weatherModel: WeatherModel
    
    var body: some View {
        let dailyForecast = weatherModel.forecast?.daily ?? []
        
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("\(weatherModel.city)")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding()
                    .multilineTextAlignment(.center)
                
                List (dailyForecast) { listItem in
                    DailyForecastRecord(record: listItem)
                        .frame(height: 100)
                }
                .opacity(0.86)
            }
        }
    }
}

struct ForecastTabView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastTabView()
            .environmentObject(WeatherModel())
    }
}
