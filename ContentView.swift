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
    @StateObject var locationManager = LocationManager ()
    
    @State var xOffSet: CGFloat = 0
    @State var yOffSet: CGFloat = 0
    
    @State var changeLang = false
    
    @State var locationShare = false
    
    var body: some View {
        
        if let location = locationManager.location {
            MainView(lon: location.longitude, lat: location.latitude)
        } else {
            if locationManager.isLoading{
                ProgressView()
            } else {
                WelcomeView()
                    .environmentObject(locationManager)
            }
        }
    }
}

struct ImageModifiers: ViewModifier {
    let width: CGFloat
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(width: width)
            .foregroundColor(Color("black"))
    }
}

extension Image {
    func sidebarImageCustomModifiers(width: CGFloat) -> some View {
        self.resizable().modifier(ImageModifiers(width: width))
    }
}

