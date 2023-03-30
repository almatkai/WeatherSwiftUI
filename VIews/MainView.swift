//
//  MainView.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 28.03.2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    @State var xOffSet: CGFloat = 0
    @State var yOffSet: CGFloat = 0
    
    @State var changeLang = false
    
    let lon: Double
    let lat: Double
    var body: some View {
        VStack{
            if weatherViewModel.isDataFetched{
                GeometryReader { geometry in
                    ZStack {
                        VStack {
                            // MARK: - Navigation Bar
                            HStack{
                                Button {
                                    withAnimation(.easeOut(duration: 0.6)) {
                                        xOffSet = 0
                                    }
                                } label: {
                                    Image("menu")
                                        .sidebarImageCustomModifiers(width: 30)
                                }
                                Spacer()
                                if let localityName = weatherViewModel.geoObject.locality?.name, let countryName = weatherViewModel.geoObject.country?.name {
                                    Text("\(localityName), \(countryName)")
                                } else {
                                    Text("Sorry, data is missing")
                                }
                                Spacer()
                                VStack{
                                    Text("\(weatherViewModel.lang.description)")
                                        .font(.system(size: 20))
                                        .onTapGesture {
                                            withAnimation{
                                                changeLang.toggle()
                                            }
                                        }
                                    if changeLang {
                                        if weatherViewModel.lang.description != "Eng" {
                                            Text(Lang.Eng.description)
                                                .onTapGesture {
                                                    weatherViewModel.lang = Lang.Eng
                                                }
                                        }
                                        if weatherViewModel.lang.description != "Rus" {
                                            Text(Lang.Rus.description)
                                                .onTapGesture {
                                                    weatherViewModel.lang = Lang.Rus
                                                }
                                        }
                                        if weatherViewModel.lang.description != "Kaz" {
                                            Text(Lang.Kaz.description)
                                                .onTapGesture {
                                                    weatherViewModel.lang = Lang.Kaz
                                                }
                                        }
                                    }
                                }
                                
                            }
                            .padding(.bottom, 8)
                            .padding(.horizontal)
                            .background(Color("skyBlue"))
                            //
                            // MARK: - ALL CONTENT
                            HomeView()
                            //
                            Spacer()
                        }.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        VStack {
                            HStack{
                                Spacer()
                                Button {
                                    withAnimation(.easeIn) {
                                        xOffSet -= geometry.size.width
                                    }
                                } label: {
                                    Image("close")
                                        .sidebarImageCustomModifiers(width: 30)
                                }
                            }.padding()
                            Spacer()
                            Image(systemName: "paperplane.fill")
                                .resizable ()
                                .aspectRatio(contentMode: .fit)
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            Spacer()
                        }
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: xOffSet)
                        // MARK: - Swipe to Close the Sidebar
                        .swipeToClose(xOffSet: $xOffSet){}
                        //
                    }
                    .onAppear {
                        xOffSet -= geometry.size.width
                    }
                }
            }else {
                GeometryReader{ proxy in
                    ProgressView()
                        .position(x: proxy.size.width / 2, y:  proxy.size.height / 2)
                }
            }
        }
//        .onAppear{
//            weatherViewModel.getWeather(lon: lon, lat: lat)
//        }
        .onReceive(weatherViewModel.$lang) { _ in
            weatherViewModel.isDataFetched = false
            changeLang = false
            weatherViewModel.getWeather(lon: lon, lat: lat)
        }
    }
}

