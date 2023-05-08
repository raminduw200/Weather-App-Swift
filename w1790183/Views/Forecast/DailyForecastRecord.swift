//
//  DailyForecastRecord.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-07.
//

import SwiftUI

struct DailyForecastRecord: View {
    var record: Daily
    var body: some View {
        
        HStack {
            AsyncImage(url: record.weather.first?.iconURL) { image in
                image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .shadow(radius: 2)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100)
            
            VStack {
                Text("\((record.weather[0].weatherDescription.rawValue).capitalized)")
                Text("\(record.dt.getUTCDate().formatted(.dateTime.weekday(.wide).day()))")
            }
            
            Spacer()
            
            Text("\(Int(record.temp.max))°C / \(Int(record.temp.min))°C")
        }
    }
}

struct DailyForecastRecord_Previews: PreviewProvider {
    static var previews: some View {
        DailyForecastRecord(record: (WeatherModel().forecast?.daily.first)!)
    }
}
