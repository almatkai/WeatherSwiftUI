//
//  MainView.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 28.03.2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @ObservedObject var googlePlaceManager: GooglePlaceManager
    
    @State var sidebarShow = false
    @State var citySearch = false
    
    let lon: Double
    let lat: Double

    var body: some View {
        VStack{
            if weatherViewModel.isDataFetched{
                GeometryReader { geometry in
                    ZStack {
                        ScrollView(showsIndicators: false){
                            Rectangle().frame(height: 50)
                                .foregroundColor(.clear)
                            HomeView()
                        }
                        VStack {
                            // MARK: - Nav Bar
                            VStack{
                                NavigationBar(sidebarShow: $sidebarShow, citySearch: $citySearch)
                                Rectangle().frame(width: geometry.size.width, height: 2)
                                    .offset(y: -8)
                                    .foregroundColor(Color("borderBlue"))
                            }
                            Spacer()
                                .edgesIgnoringSafeArea(.bottom)
                        }
                        .frame(maxHeight: .infinity)
                        
                        SideBarView(googlePlaceManager: googlePlaceManager,sidebarShow: $sidebarShow, citySearch: $citySearch, width: geometry.size.width * 0.8)
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
        .onAppear {
            weatherViewModel.getWeather(lon: lon, lat: lat)
        }
    }
}
