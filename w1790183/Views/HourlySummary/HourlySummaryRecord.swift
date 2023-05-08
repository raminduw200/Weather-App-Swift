//
//  HourlySummaryRecord.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-07.
//

import SwiftUI

struct HourlySummaryRecord: View {
    var record: Current
    var body: some View {
        HStack {
            VStack {
                Text("\(record.dt.getUTCDate().formatted(.dateTime.hour()))")
                Text("\(record.dt.getUTCDate().formatted(.dateTime.weekday()))")
            }
            
            Spacer()
            
            AsyncImage(url: record.weather.first?.iconURL) { image in
                image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .shadow(radius: 2)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100)
            
            Spacer()
            
            Text("\(Int(record.temp))°C")
            Text("\((record.weather.first?.weatherDescription.rawValue)?.capitalized ?? "")")
        }
    }
}

struct HourlySummaryRecord_Previews: PreviewProvider {
    static var previews: some View {
        HourlySummaryRecord(record: (WeatherModel().forecast?.hourly.first)!)
    }
}
