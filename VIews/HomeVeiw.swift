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
            
            ForEach(weatherViewModels.forecasts.indices){ index in
                let forecast = weatherViewModels.forecasts[index]
                HStack{
                    VStack{
                        Text(formatDate(_: forecast.date))
                            .onAppear{
                                let date = Date()
                                print("\(date)")
                            }
                    }
                    Spacer()
                    
                    Image(forecast.parts?.day?.condition ?? "")
                        .sidebarImageCustomModifiers(width: 30)
                        .padding(.trailing)

                    VStack{
                        Text("Max")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                        if let tempMax = forecast.parts?.day?.temp_max {
                            Text(tempMax > 0 ? "+\(tempMax)" : "\(tempMax)")
                                .font(.system(size: 20))
                        } else {
                            Text("N/A")
                                .font(.system(size: 20))
                        }
                    }
                    VStack{
                        Text("Min")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                        if let tempMin = forecast.parts?.night?.temp_max {
                            Text(tempMin > 0 ? "+\(tempMin)" : "\(tempMin)")
                                .font(.system(size: 20))
                        } else {
                            Text("N/A")
                                .font(.system(size: 20))
                        }
                    }
                }
                .padding()
                .background(Color(hex: "0a0b0c"))
                .cornerRadius(15)
                .padding(.horizontal)
            }
        }
        .onAppear{
            hour += 1
            dateFormatter.dateFormat = "yyyy-MM-dd"
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

func formatDate(_ dateString: String?) -> String {
    let dateFormatter = DateFormatter()
    guard let date = dateFormatter.date(from: dateString ?? "") else {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString ?? "") else {
            return "Invalid date"
        }
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: date)
    }
    return dateFormatter.string(from: date)
}
