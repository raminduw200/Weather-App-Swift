//
//  SheetView.swift
//  w1790183
//
//  Created by Ramindu Walgama on 2023-05-05.
//

import SwiftUI
import CoreLocation
import Network

struct SheetView: View {
    @AppStorage(StorageKeys.lat) private var keyLat: Double = 0
    @AppStorage(StorageKeys.lon) private var keyLon: Double = 0
    @AppStorage(StorageKeys.city) private var keyCity: String = ""
    @AppStorage(StorageKeys.firstTimeOpen) private var keyFirstTimeOpen: Bool = true

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var weatherModel: WeatherModel
    
    @State var cityInput: String = ""
    @State var isInternetConnected = true
    
    @Binding var errorMsg: String
    @Binding var isAlert: Bool
    
    var body: some View {
        ZStack {
            Color.teal
                .ignoresSafeArea()
            TextField("Enter the location", text: $cityInput, onCommit: {
                
                CLGeocoder().geocodeAddressString(cityInput) { coords, e in
                    if let lat = coords?.first?.location?.coordinate.latitude,
                       let lon = coords?.first?.location?.coordinate.longitude {
                        Task {
                            do {
                                try await weatherModel.getForecast(lat: lat, lon: lon)
                                (keyFirstTimeOpen, keyLat, keyLon, keyCity) = (false, lat, lon, cityInput)
                                weatherModel.city = cityInput
                            } catch {
                                errorMsg = error.localizedDescription
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isAlert.toggle()
                                }
                            }
                        }
                    } else {
                        errorMsg = "Unknown location"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isAlert.toggle()
                        }
                    }
                    dismiss()
                }
            })
            .textFieldStyle(.roundedBorder)
            .padding()
            .shadow(color: .blue, radius: 8)
            .frame(width: 250)
            .font(.title2)
        }
        .onAppear {
            let monitor = NWPathMonitor()
            let queue = DispatchQueue(label: "InternetConnectionMonitor")
            monitor.start(queue: queue)
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    self.isInternetConnected = true
                } else {
                    self.isInternetConnected = false
                }
            }
        }
        .alert("Please check your internet connection and try again.",
               isPresented: .constant(!isInternetConnected)) {
            Button("OK") {}
        }
    }
}

