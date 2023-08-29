//
//  ContentView.swift
//  Weather2
//
//  Created by Almat Kairatov on 27.03.2023.
//

import SwiftUI
import CoreLocationUI

struct ContentView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @StateObject var googlePlaceManager = GooglePlaceManager()
    @StateObject var locationManager = LocationManager ()
    
    var body: some View {
        
        VStack {
            if locationManager.authorizationStatus == .authorizedWhenInUse {
                MainView(googlePlaceManager: googlePlaceManager, lon: locationManager.locationManager.location?.coordinate.longitude ?? 0, lat: locationManager.locationManager.location?.coordinate.latitude ?? 0)
            } else {
                WelcomeView(googlePlaceManager: googlePlaceManager)
                    .environmentObject(locationManager)
            }
        }
    }
}

