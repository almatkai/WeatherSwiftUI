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
                Text("or")
                HStack(alignment: .center) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.leading, 6)
                    Text("Choose on Map")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .padding(.trailing, 6)
                }
                .padding(9)
                .background {
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundColor(.blue)
                }
            }
            Spacer()
        } .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
