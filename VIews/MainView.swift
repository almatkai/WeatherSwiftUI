//
//  MainView.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 28.03.2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @State var sidebarShow = false
    let lon: Double
    let lat: Double

    var body: some View {
        VStack{
            if weatherViewModel.isDataFetched{
                GeometryReader { geometry in
                    ZStack {
                        ScrollView(showsIndicators: false){
                            Rectangle().frame(height: 40)
                                .foregroundColor(.clear)
                            HomeView()
                        }
                        VStack {
                            // MARK: - Nav Bar
                            VStack{
                                NavigationBar(sidebarShow: $sidebarShow)
                                Rectangle().frame(width: geometry.size.width, height: 2)
                                    .offset(y: -8)
                                    .foregroundColor(Color("borderBlue"))
                            }
                            Spacer()
                                .edgesIgnoringSafeArea(.bottom)
                        }
                        .frame(maxHeight: .infinity)
                        
                        SideBarView(sidebarShow: $sidebarShow, width: geometry.size.width * 0.8)
                            .offset(x: sidebarShow ? 0 : -geometry.size.width)
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }else {
                GeometryReader{ proxy in
                    ProgressView()
                        .position(x: proxy.size.width / 2, y:  proxy.size.height / 2)
                }
            }
        }
        .background(Color("background"))
        .onReceive(weatherViewModel.$lang) { _ in
            weatherViewModel.isDataFetched = false
            weatherViewModel.getWeather(lon: lon, lat: lat)
        }
    }
}

