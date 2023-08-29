//
//  WelcomeView.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 28.03.2023.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    @ObservedObject var googlePlaceManager: GooglePlaceManager
    
    @State var searchShow = false
    
    var body: some View {
        VStack{
            Spacer()
            Spacer()
            Text("Welcome!")
                .font(.largeTitle)
            Spacer()
            VStack {
                LocationButton(){
                    locationManager.requestLocation()
                }.cornerRadius(30)
                    .symbolVariant(.fill)
                    .foregroundColor(.white)
                .padding(.bottom, 4)
                
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
    }
}
