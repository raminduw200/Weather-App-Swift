//
//  CityTabView.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-05.
//

import SwiftUI
import CoreLocation

struct CityTabView: View {
    
    @AppStorage(StorageKeys.lat) private var keyLat: Double = 0
    @AppStorage(StorageKeys.lon) private var keyLon: Double = 0
    @AppStorage(StorageKeys.firstTimeOpen) private var keyFirstTimeOpen: Bool = true
    
    @EnvironmentObject private var weatherModel: WeatherModel
    
    @State private var isCityChange: Bool = false
    @State var errorMsg: String = ""
    @State var isAlert: Bool = false
    
    var body: some View {
        let currentWeather = weatherModel.forecast?.current
        
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.65)
            
            VStack {
                Group { /// btn and city
                    Spacer()
                    Button("Change Location") {
                        isCityChange.toggle()
                    }
                    .bold()
                    
                    Spacer()
                    Spacer()
                    
                    Text("\(weatherModel.city)")
                        .shadow(radius: 2)
                        .multilineTextAlignment(.center)
                } /// btn and city
                .font(.title)
                .fontWeight(.medium)
                
                Spacer()
                
                /// Date-Time
                Text("\((currentWeather?.dt ?? 0).getUTCDate().formatted(.dateTime.year().hour().month().day()))")
                .font(.largeTitle)
                .fontWeight(.medium)
                .shadow(radius: 2)
                
                Spacer()
                Spacer()
                
                Group { /// weather info
                    Text("Temp: \(Int(currentWeather?.temp ?? 0))°C")
                    Spacer()
                    Text("Humidity: \(Int(currentWeather?.humidity ?? 0))%")
                    Spacer()
                    Text("Pressure: \(Int(currentWeather?.pressure ?? 0))hPa")
                    Spacer()
                } /// weather info
                .font(.title3)
                .bold()
                
                HStack { /// labeled - icon
                    AsyncImage(url: currentWeather?.weather.first?.iconURL) { image in
                        image
                            .resizable()
                            .frame(width: 70, height: 70)
                            .shadow(radius: 10)
                    } placeholder: {
                        ProgressView()
                    }

                    Text("\((currentWeather?.weather[0].weatherDescription.rawValue ?? "").capitalized)")
                } /// labeled - icon
                .bold()
            }
        }
        .onAppear {
            Task {
                if !keyFirstTimeOpen {
                    do {
                        try await weatherModel.getForecast(lat: keyLat, lon: keyLon)
                    } catch {
                        errorMsg = error.localizedDescription
                        isAlert.toggle()
                    }
                }
            }
        }
        .sheet(isPresented: $isCityChange) {
            SheetView(errorMsg: $errorMsg, isAlert: $isAlert)
        }
        .alert(errorMsg, isPresented: $isAlert) {
            Button("OK") {}
        }
    }
}

struct CityTabView_Previews: PreviewProvider {
    static var previews: some View {
        CityTabView()
            .environmentObject(WeatherModel())
    }
}
