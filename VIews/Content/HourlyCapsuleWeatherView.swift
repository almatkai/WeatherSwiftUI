//
//  HourlyCapsuleWeatherView.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 31.03.2023.
//

import SwiftUI

struct HourlyCapsuleWeatherView: View {
    
    @EnvironmentObject var weatherVM: WeatherViewModel
    @State var hour = 0

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                Rectangle()
                    .foregroundColor(Color.clear)
                    .frame(width: 10, height: 150)
                if weatherVM.fact.count > 0 {
                    ForEach(hour..<hour + 10, id: \.self) { index in
                        let hourlyFact = weatherVM.fact[index]
                        ZStack{
                            Capsule()
                                .foregroundColor(Color("skyBlue"))
                                .frame(width: 80, height: 150)
                                .shadow(color: Color("shadow"), radius: 5, x: 5, y: -2)
                            VStack{
                                Text("\(extractTimeFromUnixTimestamp(unixTimestamp: hourlyFact.hour_ts ?? 0, timeZone: weatherVM.timeZone))")
                                    .foregroundColor(.white)
                                Image((hourlyFact.condition ?? ""))
                                    .imageModifier(height: 40)
                                if let temp = hourlyFact.temp {
                                    Text("\(temp)°")
                                        .foregroundColor(.white)
                                        .onChange(of: temp) { _ in
                                            hour = extractHour(from: weatherVM.currentWeather.now ?? 0, timeZone: weatherVM.timeZone) ?? 0
                                        }
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
                hour = extractHour(from: weatherVM.currentWeather.now ?? 0, timeZone: weatherVM.timeZone) ?? 0
            }
        }
        .frame(height: 170)
    }
}
