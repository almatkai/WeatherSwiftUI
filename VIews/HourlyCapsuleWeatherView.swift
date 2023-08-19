//
//  HourlyCapsuleWeatherView.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 31.03.2023.
//

import SwiftUI

struct HourlyCapsuleWeatherView: View {
    
    @EnvironmentObject var weatherViewModels: WeatherViewModel
    @State var hour = Calendar.current.component(.hour, from: Date())
    
    @State var fact = [Fact]()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                Rectangle()
                    .foregroundColor(Color.clear)
                    .frame(width: 10, height: 150)
                if fact.count > 0 {
                    ForEach(hour..<hour + 25, id: \.self) { index in
                        let hourlyFact = fact[index]
                        ZStack{
                            Capsule()
                                .foregroundColor(Color("skyBlue"))
                                .frame(width: 80, height: 150)
                                .shadow(color: Color("shadow"), radius: 5)
                            VStack{
                                Text("\(hourlyFact.hour ?? ""):00")
                                    .foregroundColor(.white)
                                Image((hourlyFact.condition ?? ""))
                                    .sidebarImageCustomModifiers(width: 30)
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
                if let hours = weatherViewModels.forecasts[0].hours {
                    fact += hours
                }
                if let hours = weatherViewModels.forecasts[1].hours {
                    fact += hours
                }
                print("DEBUG COUNT: \(fact.count)")
            }
        }
        .frame(height: 170)
    }
}
