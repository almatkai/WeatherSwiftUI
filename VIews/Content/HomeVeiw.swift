//
//  HomeView.swift
//  Weather2
//
//  Created by Almat Kairatov on 27.03.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var weatherVM: WeatherViewModel
    @Environment(\.screenWidth) var screenWidth
    
    @State var hour = Calendar.current.component(.hour, from: Date())
    
    @State var monthDay = ""
    
    var body: some View {
        VStack{
            WeatherCardView()
            if weatherVM.timeZone != "" {
                HourlyCapsuleWeatherView()
            }
            DailyWeatherListView()
            Text("")
                .frame(height: 40)
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
