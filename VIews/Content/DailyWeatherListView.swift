//
//  DailyWeatherListView.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 14.08.2023.
//

import SwiftUI

struct DailyWeatherListView: View {

    @EnvironmentObject var weatherVM: WeatherViewModel

    var body: some View {
        if let forecasts = weatherVM.currentWeather.forecasts {
            ForEach(forecasts){ forecast in
                HStack{
                    VStack{
                        Text(formatDate(_: forecast.date))
                            .foregroundColor(Color("black"))
                    }
                    Spacer()

                    Image(forecast.parts?.day?.condition ?? "")
                        .imageModifier(width: 42)
                        .padding(.trailing)
                    VStack{
                        Text("Max")
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
                        Text("Min")
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
        }
    }

    private func getMinValue(parts: Parts) -> Int {
        let minArray = [parts.night?.temp_min, parts.day?.temp_min, parts.day_short?.temp_min, parts.evening?.temp_min, parts.night_short?.temp_min]
        var min = 999
        for value in minArray {
            if let val = value {
                min = min > val ? val : min
            }
        }
        return min
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
