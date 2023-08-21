//
//  HourlyCapsuleWeatherView.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 31.03.2023.
//

import SwiftUI

struct HourlyCapsuleWeatherView: View {
    
    @EnvironmentObject var weatherViewModels: WeatherViewModel
    @State var hour = 0
    @State var fact = [Fact]()
    
    @State var timeZone: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                Rectangle()
                    .foregroundColor(Color.clear)
                    .frame(width: 10, height: 150)
                if fact.count > 0 {
                    ForEach(hour..<hour + 25, id: \.self) { index in
                        let hourlyFact = fact[index]
                        let time = extractTimeFromUnixTimestamp(unixTimestamp: hourlyFact.hour_ts ?? 0, timeZone: timeZone)
                        ZStack{
                            Capsule()
                                .foregroundColor(Color("skyBlue"))
                                .frame(width: 80, height: 150)
                                .shadow(color: Color("shadow"), radius: 5, x: 5, y: -2)
                            VStack{
                                Text("\(time)")
                                    .foregroundColor(.white)
                                Image((hourlyFact.condition ?? ""))
                                    .imageModifier(height: 40)
                                if let temp = hourlyFact.temp {
                                    Text("\(temp)°")
                                        .foregroundColor(.white)
                                }
                                else {
                                    Text("?")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                
                hour = extractHour(from: weatherViewModels.weather.now ?? 0, timeZone: timeZone) ?? 0
                
                print(hour)
                
                if let forecast = weatherViewModels.weather.forecasts?[0]{
                    if let hours = forecast.hours {
                        fact += hours
                    }
                    if let forecast = weatherViewModels.weather.forecasts?[1]{
                        if let hours = forecast.hours {
                            fact += hours
                        }
                    }
                }
            }
        }
        .frame(height: 170)
    }
}
