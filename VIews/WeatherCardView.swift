//
//  WeatherCardView.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 30.03.2023.
//

import SwiftUI

struct WeatherCardView: View {
    
    @Environment(\.screenWidth) var screenWidth
    @EnvironmentObject var weatherViewModels: WeatherViewModel
    
    var body: some View {
        ZStack {
            VStack{
                VStack{}
                    .frame(width: screenWidth! * 0.73, height: 0.3333 * screenWidth!)
                    .background(HalfCircleShape().stroke(Color(hex: "fea301"), lineWidth: 3))
                    .offset(y: -screenWidth! * 0.045)
            }.frame(width: screenWidth! * 0.91, height: 0.56 * screenWidth!)
                .background{
                    Color("skyBlue")
                }
                .cornerRadius(20)
                .shadow(color: Color("shadow"), radius: 5)
            VStack {
                HStack{
                    Image("sunrise")
                        .sidebarImageCustomModifiers(width: 30)
                        .foregroundColor(.white)
                    Spacer()
                    Image("sunset")
                        .sidebarImageCustomModifiers(width: 30)
                        .foregroundColor(.white)
                }.frame(width: screenWidth! > 800 ? screenWidth! * 0.765 : screenWidth! * 0.805)
                HStack{
                    Text("\(weatherViewModels.forecasts[0].sunrise ?? "Data missing")")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(weatherViewModels.forecasts[0].sunset ?? "Data missing")")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }.frame(width: screenWidth! > 800 ? screenWidth! * 0.765 : screenWidth! * 0.81)
            }.offset(y: screenWidth! * 0.2)
            VStack{
                HStack{
                    if let temperature = weatherViewModels.fact.temp
                    {
                        Text("\(temperature)°")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                    } else {
                        Text("Data is missing")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                    }
                    Image(weatherViewModels.fact.condition ?? "")
                        .sidebarImageCustomModifiers(width: 80)
                }
                
                if let condition = Condition.fromString(weatherViewModels.fact.condition ?? "") {
                    Text(condition.rawValue)
                        .foregroundColor(.white)
                        
                } else {
                    Text("Unknown weather condition")
                        .foregroundColor(.white)
                }
                HStack {
                    Spacer()
                    Spacer()
                    Image("wind")
                        .sidebarImageCustomModifiers(width: 14)
                    if let windSpeed = weatherViewModels.fact.wind_speed {
                        Text("\(removeTrailingZero(temp: windSpeed))м/с")
                            .font(.system(size: 14))
                            .padding(.trailing, 4)
                            .foregroundColor(.white)
                    } else {
                        Text("No info. about wind speed")
                            .padding(.trailing, 4)
                            .foregroundColor(.white)
                    }
                    
                    Image("humidity")
                        .sidebarImageCustomModifiers(width: 14)
                    if let humidity = weatherViewModels.fact.humidity {
                        Text("\(humidity)%")
                            .font(.system(size: 14))
                            .padding(.leading, 4)
                            .foregroundColor(.white)
                    } else {
                        Text("No info. about humidity")
                            .padding(.leading, 4)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Spacer()
                }
            }.frame(width: screenWidth! * 0.91)
                .padding(.top, screenWidth! * 0.13)
        }
    }
}

