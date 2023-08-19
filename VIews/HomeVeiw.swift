//
//  HomeView.swift
//  Weather2
//
//  Created by Almat Kairatov on 27.03.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var weatherViewModels: WeatherViewModel
    @Environment(\.screenWidth) var screenWidth
    
    @State var hour = Calendar.current.component(.hour, from: Date())

    let dateFormatter = DateFormatter()
    
    @State var monthDay = ""
    
    var body: some View {
        VStack{
            WeatherCardView()
            HourlyCapsuleWeatherView()
            DailyWeatherListView()
            Text("")
                .frame(height: 40)
        }
        .onAppear{
            hour += 1
            dateFormatter.dateFormat = "yyyy-MM-dd"
            print("DEBUG FORECAST COUNT: \(weatherViewModels.forecasts.count)")
            print("DEBUG DAY 15 august: \(weatherViewModels.forecasts[1].date)")
            print("DEBUG DAY 15 august: \(weatherViewModels.forecasts[1])")
        }
    }
}

struct HalfCircleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height)
        path.addArc(center: center,
            radius: rect.width / 2,
            startAngle: .degrees(180),
            endAngle: .degrees(0),
            clockwise: false)
        return path
    }
}
