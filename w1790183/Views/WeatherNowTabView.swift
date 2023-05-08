//
//  WeatherNowTabView.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-05.
//

import SwiftUI

struct WeatherNowTabView: View {
    @EnvironmentObject private var weatherModel: WeatherModel

    var body: some View {
        let currentWeather = weatherModel.forecast?.current
        let dailyWeather = weatherModel.forecast?.daily
        
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.65)
            
            VStack {
                Group {
                    Spacer()
                    Text("\(weatherModel.city)")
                        .font(.title)
                    Spacer()
                    Text("\(Int(currentWeather?.temp ?? 0))°C")
                        .font(.largeTitle)
                    Spacer()
                    
                }
                .shadow(radius: 2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                
                
                HStack {
                    AsyncImage(url: currentWeather?.weather.first?.iconURL) { image in
                        image
                            .resizable()
                            .frame(width: 80, height: 80)
                            .shadow(radius: 10)
                    } placeholder: {
                        ProgressView()
                    }

                    Text("\((currentWeather?.weather[0].weatherDescription.rawValue ?? "").capitalized)")
                }
                .bold()
                
                Spacer()
                
                Group {
                    HStack {
                        Spacer()
                        Text("H: \(Int(dailyWeather?.first?.temp.max ?? 0))°C")
                        Spacer()
                        Text("Low: \(Int(dailyWeather?.first?.temp.min ?? 0))°C")
                        Spacer()
                    }
                    Text("Feels Like: \(Int(currentWeather?.feelsLike ?? 0))°C")
                        .padding(.top)
                }
                
                Spacer()
                
                Group {
                    HStack {
                        Spacer()
                        Text("Wind Speed: \(Int(currentWeather?.windSpeed ?? 0))m/s")
                        Spacer()
                        Text("Direction: \(currentWeather?.windDir ?? "")")
                        Spacer()
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Humidity: \(currentWeather?.humidity ?? 0)%")
                            .padding()
                        Text("Presure: \(currentWeather?.pressure ?? 0) hPg")
                            .padding()
                    }
                    HStack {
                        Label {
                            Text("\((currentWeather?.sunset ?? 0).getUTCDate().formatted(.dateTime.hour().minute()))")
                        } icon: {
                            Image(systemName: "sunset.fill")
                                .foregroundColor(.yellow)
                                .shadow(radius: 2)
                        }
                        Label {
                            Text("\((currentWeather?.sunrise ?? 0).getUTCDate().formatted(.dateTime.hour().minute()))")
                        } icon: {
                            Image(systemName: "sunrise.fill")
                                .foregroundColor(.yellow)
                                .shadow(radius: 2)
                        }
                    }
                    .padding(.top)
                    
                    Spacer()
                    Spacer()
                }
                .font(.title3)
            }
            .fontWeight(.medium)
        }
    }
}

struct WeatherNowTabView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherNowTabView()
            .environmentObject(WeatherModel())
    }
}
