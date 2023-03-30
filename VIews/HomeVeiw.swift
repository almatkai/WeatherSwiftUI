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
    
    let hour = Calendar.current.component(.hour, from: Date())

    var body: some View {
        ScrollView{
            ZStack{
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
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.9), radius: 5)
                VStack {
                    HStack{
                        Image("sunrise")
                            .sidebarImageCustomModifiers(width: 30)
                        Spacer()
                        Image("sunset")
                            .sidebarImageCustomModifiers(width: 30)
                    }.frame(width: screenWidth! > 800 ? screenWidth! * 0.765 : screenWidth! * 0.805)
                    HStack{
                        Text("\(weatherViewModels.forecasts[0].sunrise ?? "Data missing")")
                            .font(.system(size: 12))
                        Spacer()
                        Text("\(weatherViewModels.forecasts[0].sunset ?? "Data missing")")
                            .font(.system(size: 12))
                    }.frame(width: screenWidth! > 800 ? screenWidth! * 0.765 : screenWidth! * 0.81)
                }.offset(y: screenWidth! * 0.2)
                VStack{
                    HStack{
                        if let temperature = weatherViewModels.fact.temp
                        {
                            Text("\(temperature)°")
                                .font(.system(size: 60))
                        } else {
                            Text("Data is missing")
                                .font(.system(size: 60))
                        }
                        Image(weatherViewModels.fact.condition ?? "")
                            .sidebarImageCustomModifiers(width: 60)
                    }
                    
                    if let condition = Condition.fromString(weatherViewModels.fact.condition ?? "") {
                        Text(condition.rawValue)
                    } else {
                        Text("Unknown weather condition")
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
                        } else {
                            Text("No info. about wind speed")
                                .padding(.trailing, 4)
                        }
                        
                        Image("humidity")
                            .sidebarImageCustomModifiers(width: 14)
                        if let humidity = weatherViewModels.fact.humidity {
                            Text("\(humidity)%")
                                .font(.system(size: 14))
                                .padding(.leading, 4)
                        } else {
                            Text("No info. about humidity")
                                .padding(.leading, 4)
                        }
                        Spacer()
                        Spacer()
                    }
                }.frame(width: screenWidth! * 0.91)
                    .padding(.top, screenWidth! * 0.13)
            }
            Text("Hello")
                .frame(width: 500)
                .background(Color.red)
            Text("Hello")
            Text("Hello")
            Text("Hello")
            
        }
            .onAppear{
                print("DEBUG: \(hour)")
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



//VStack{
//    GeometryReader{ geometry in
//        VStack{
//            ZStack{
//                VStack{
//
//                }.frame(width: geometry.size.width * 0.80, height: geometry.size.height * 0.16)
//                .background(HalfCircleShape().stroke(Color(hex: "fea301"), lineWidth: 3))
////                        .padding(.bottom, 20)
////                        .padding(.top, geometry.size.height * 0.02)
//                VStack{
//                    Text("\(weatherViewModels.fact.feels_like)")
//                    Text("\(weatherViewModels.info.tzinfo.name)")
//                    Text("\(weatherViewModels.info.zoom)")
//                    Text("\(weatherViewModels.fact.condition)")
//                    HStack{
//                        VStack{
//                            HStack{
//                                Image("sunrise")
//                                    .sidebarImageCustomModifiers(width: 34)
//                                Spacer()
//                                Image("sunset")
//                                    .sidebarImageCustomModifiers(width: 34)
//                            }
//                            HStack{
//                                Text("\(weatherViewModels.forecasts[0].sunrise)")
//                                Spacer()
//                                Text("\(weatherViewModels.forecasts[0].sunset)")
//                            }
//                        }
//                    }.padding(.horizontal, 20)
//                        .padding(.top, geometry.size.height > 600 ? 90 : 50)
//                }
//            }
//        }.frame(width: geometry.size.width, height: geometry.size.height > 600 ? 250 : 250)
//            .background(Color(hex: "124bcf"))
//            .padding(.top,geometry.size.height > 600 ? 0 : 10)
//    }.background(Color.brown)
//}
