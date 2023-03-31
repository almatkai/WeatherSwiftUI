//
//  YandexWeatherApp.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 28.03.2023.
//

import SwiftUI

@main
struct YandexWeatherApp: App {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(WeatherViewModel())
                .environment(\.screenWidth, screenWidth)
                .environment(\.screenHeight, screenHeight)
        }
    }
}

struct ScreenWidthKey: EnvironmentKey {
    static let defaultValue: CGFloat? = nil
}
struct ScreenHeightKey: EnvironmentKey {
    static let defaultValue: CGFloat? = nil
}
extension EnvironmentValues {
    var screenWidth: CGFloat? {
        get { self[ScreenWidthKey.self] }
        set { self[ScreenWidthKey.self] = newValue }
    }
    var screenHeight: CGFloat? {
        get { self[ScreenHeightKey.self] }
        set {  self[ScreenHeightKey.self] = newValue }
    }
}
