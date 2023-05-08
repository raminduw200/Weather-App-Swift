//
//  PollutionTabView.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-05.
//

import SwiftUI

struct PollutionTabView: View {
    @AppStorage(StorageKeys.firstTimeOpen) private var keyFirstTimeOpen: Bool = true

    @EnvironmentObject private var weatherModel: WeatherModel
    
    @State var isAlert: Bool = false
    @State var errorMsg: String = ""

    var body: some View {
        let currentWeather = weatherModel.forecast?.current
        let dailyWeather = weatherModel.forecast?.daily
        let pollutionWeather = weatherModel.pollution?.list.first?.components
        let imageSize = 60.0
        
        ZStack {
            Image("background")
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
                    Text("Air Quality Data:")
                        .shadow(radius: 2)
                        .font(.title)
                    
                    HStack {
                        Spacer()
                        VStack{
                            Image("so2")
                                .resizable()
                                .frame(width: imageSize, height: imageSize)
                            Text("\((pollutionWeather?.so2 ?? 0).twoDecimal())")
                        }
                        Spacer()
                        VStack{
                            Image("no")
                                .resizable()
                                .frame(width: imageSize, height: imageSize)
                            Text("\((pollutionWeather?.no ?? 0).twoDecimal())")
                        }
                        Spacer()
                        VStack{
                            Image("voc")
                                .resizable()
                                .frame(width: imageSize, height: imageSize)
                            Text("\((pollutionWeather?.co ?? 0).twoDecimal())")
                        }
                        Spacer()
                        VStack{
                            Image("pm")
                                .resizable()
                                .frame(width: imageSize, height: imageSize)
                            Text("\((pollutionWeather?.pm10 ?? 0).twoDecimal())")
                        }
                        Spacer()
                    }
                }
                .font(.title3)
                
                Spacer()
            }
            .fontWeight(.medium)
        }
        .onAppear {
            Task {
                if !keyFirstTimeOpen {
                    do {
                        try await weatherModel.getPollutionWeather()
                    } catch {
                        errorMsg = error.localizedDescription
                        isAlert.toggle()
                    }
                }
            }
        }
        .alert(errorMsg, isPresented: $isAlert) {
            Button("OK") {}
        }
    }
}

struct PollutionTabView_Previews: PreviewProvider {
    static var previews: some View {
        PollutionTabView()
            .environmentObject(WeatherModel())
    }
}
