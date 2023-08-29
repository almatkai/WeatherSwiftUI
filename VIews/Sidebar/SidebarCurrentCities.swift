//
//  SidebarCurrentCities.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 22.08.2023.
//

import SwiftUI

struct SidebarCurrentCities: View {
    
    var width: CGFloat
    @Environment(\.screenHeight) var height
    @EnvironmentObject var weatherVM: WeatherViewModel
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var places: FetchedResults<Place>
    @Binding var sidebarShow: Bool
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Text("Your cities")
                    .font(.system(size: 20))
                    .fontWeight(.light)
                Spacer()
            }
            .padding(.bottom, 4)
            Divider()
            ScrollView {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 10)
                VStack {
                    HStack {
                        Text(weatherVM.weathers[0].geo_object?.locality?.name ?? "Error Appeared")
                            .foregroundColor(.white)
                        Spacer()
                        if let condition = weatherVM.weathers[0].fact?.condition {
                            Image(condition)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                        }
                        if let temp = weatherVM.weathers[0].fact?.temp {
                            Text("\(temp)°" )
                                .foregroundColor(.white)
                        } else {
                            Text("Error Appeared")
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                }
                .frame(width: width * 0.9, height: (height ?? 10) * 0.08)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("skyBlue"))
                }
                .overlay {
                    VStack {
                        HStack {
                            Text("Current Location")
                                .font(.system(size: 10))
                                .padding(.leading, 4)
                                .padding(.top, 4)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .onTapGesture {
                    withAnimation{
                        weatherVM.changeCurrentWeather(index: 0)
                        sidebarShow = false
                    }
                }
                ForEach(Array(places.enumerated()), id: \.element) { index, place in
                    ShortWeatherView(sidebarShow: $sidebarShow, width: width, place: place, index: index)
                }
            }
            
        }
        .padding()
        .frame(width: width)
    }
}

struct ShortWeatherView: View {
    
    @Binding var sidebarShow: Bool
    var width: CGFloat
    @Environment(\.screenHeight) var height
    @EnvironmentObject var weatherVM: WeatherViewModel
    var place: FetchedResults<Place>.Element
    var index: Int
    @State var rotate = 0.0
    
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        VStack {
            HStack {
                Text(place.cityFulltext ?? "Error Appeared")
                    .foregroundColor(.white)
                Spacer()
                
                if let indexOfWeather = weatherVM.weatherAndPlaceDict[index] {
                    if let condition = weatherVM.weathers[indexOfWeather].fact?.condition {
                        Image(condition)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                    if let temp = weatherVM.weathers[indexOfWeather].fact?.temp {
                        Text("\(temp)°" )
                            .foregroundColor(.white)
                    } else {
                        Text("Error Appeared")
                            .foregroundColor(.white)
                    }
                }
                else {
                    RefreshImage(place: place, rotate: $rotate)
                }

                Text(place.city ?? "Error Appeared")
            }
            .padding()
        }
        .frame(width: width * 0.9, height: (height ?? 10) * 0.08)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("skyBlue"))
        }
        .onTapGesture {
            if let indexOfWeather = weatherVM.weatherAndPlaceDict[index] {
                withAnimation{
                    weatherVM.changeCurrentWeather(index: indexOfWeather)
                }
            }
            else {
                weatherVM
                    .getWeather(
                        lon: place.lon,
                        lat: place.lat,
                        index: index,
                        changeLoco: true
                    )
            }
            withAnimation{
                sidebarShow = false
            }
        }
        
        .onLongPressGesture {
            moc.delete(place)
        }
    }
    
    @ViewBuilder
    private func RefreshImage(place: FetchedResults<Place>.Element, rotate: Binding<Double>) -> some View {
        Image("refresh")
            .resizable()
            .scaledToFit()
            .frame(width: 30)
            .rotationEffect(Angle(degrees: rotate.wrappedValue))
            .onTapGesture {
                withAnimation(Animation.easeInOut(duration: 1)){
                    rotate.wrappedValue += 1080
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.83) {
                    weatherVM
                        .getWeather(
                            lon: place.lon,
                            lat: place.lat,
                            index: index)
                }
            }
    }
    
}
