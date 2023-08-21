//
//  ImageModifier.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 21.08.2023.
//

import SwiftUI

struct ImageModifiers: ViewModifier {
    let width: CGFloat
    let height: CGFloat
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
            .foregroundColor(Color("black"))
    }
}

extension Image {
    @ViewBuilder
    func imageModifier(width: CGFloat = 0, height: CGFloat = 0) -> some View {
        switch (width, height) {
        case (let x, 0):
            self.resizable().modifier(ImageModifiers(width: width, height: width))
        case (0, let x):
            self.resizable().modifier(ImageModifiers(width: height, height: height))
        case (let x, let y):
            self.resizable().modifier(ImageModifiers(width: width, height: height))
        }
    }
}
