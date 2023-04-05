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
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                if let len = weatherViewModels.forecasts[0].hours?.count {
                    Text("")
                        .frame(width: 10, height: 150)
                    ForEach(hour..<len) { index in
                        let hourlyFact = weatherViewModels.forecasts[0].hours?[index]
                        ZStack{
                            Capsule()
                                .foregroundColor(Color("skyBlue"))
                                .frame(width: 80, height: 150)
                                .shadow(color: Color("shadow"), radius: 5)
                            VStack{
                                Text("\(index):00")
                                Image((hourlyFact?.condition ?? ""))
                                    .sidebarImageCustomModifiers(width: 30)
                                if let temp = hourlyFact?.temp {
                                    Text("\(temp)°")
                                }
                                else { Text("?")}
                            }
                        }
                    }
                }
            }
        }
        .frame(height: 170)
    }
}
