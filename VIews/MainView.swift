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
    @State var xIcons: CGFloat = 0
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
                            // MARK: - Nav Bar
                            NavigationBar(xOffSet: $xOffSet, changeLang: $changeLang)
                            // MARK: - ALL CONTENT
                            ScrollView(showsIndicators: false){
                                Text("")
                                    .frame(height: 10)
                                HomeView()
                                    
                            }
                                .edgesIgnoringSafeArea(.bottom)
                            //
//                            Spacer()
                        }.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            .frame(maxHeight: .infinity)
                            
                            
                        // MARK: - SideBar
                        VStack {
                            HStack{
                                Spacer()
                                Button {
                                    withAnimation(.easeIn(duration: 0.4)) {
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
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: xOffSet)
                        .background(Color("white"))
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
        .background(Color(hex: "24202a"))
        .onReceive(weatherViewModel.$lang) { _ in
            weatherViewModel.isDataFetched = false
            changeLang = false
            weatherViewModel.getWeather(lon: lon, lat: lat)
        }
    }
}

