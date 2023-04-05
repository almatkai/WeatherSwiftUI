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
                            .foregroundColor(Color("black"))
                            .onAppear{
                                let date = Date()
                                print("\(date)")
                            }
                    }
                    Spacer()
                    
                    Image(forecast.parts?.day?.condition ?? "")
                        .sidebarImageCustomModifiers(width: 42)
                        .padding(.trailing)

                    VStack{
                        Text("Maкс")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                        if let tempMax = forecast.parts?.day?.temp_max {
                            Text(tempMax > 0 ? "+\(tempMax)" : "\(tempMax)")
                                .font(.system(size: 20))
                                .foregroundColor(Color("black"))
                        } else {
                            Text("N/A")
                                .font(.system(size: 20))
                                .foregroundColor(Color("black"))
                        }
                    }
                    VStack{
                        Text("Мин")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                        if let parts = forecast.parts {
                            if getMinValue(parts: parts) == 999 {
                                Text("N/A")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("black"))
                            }else {
                                Text("\(getMinValue(parts: parts))")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("black"))
                            }
                        } else { Text("N/A")
                                .font(.system(size: 20))
                                .foregroundColor(Color("black")) }
                    }
                }
                .padding()
                .background(Color("cardBackGround"))
                .cornerRadius(15)
                .padding(.horizontal)
            }
            
            Text("")
                .frame(height: 40)
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

func getMinValue(parts: Parts) -> Int {
    let minArray = [parts.night?.temp_min, parts.day?.temp_min, parts.day_short?.temp_min, parts.evening?.temp_min, parts.night_short?.temp_min]
    var min = 999
    for value in minArray {
        if let val = value {
            min = min > val ? val : min
        }
    }
    return min
}
