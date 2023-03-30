//
//  SwipeLeftToCLose.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 30.03.2023.
//

import SwiftUI

// MARK: - Here xOffSet -> have to be xOffSet -= geometry.size.width (the center of the screen)
// USAGE: .swipeToClose(xOffSet: $xOffSet){} like this
extension View {
    func swipeToClose(xOffSet: Binding<CGFloat>, perform action: @escaping () -> Void) -> some View {
        self.modifier(SwipeToCloseModifier(xOffSet: xOffSet, action: action))
    }
}

struct SwipeToCloseModifier: ViewModifier {
    @Binding var xOffSet: CGFloat
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .offset(x: xOffSet)
            .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
                .onChanged { gesture in
                    if gesture.translation.width < 0 { // check if swiping from left to right
                        withAnimation {
                            xOffSet = gesture.translation.width
                        }
                    }
                    else { // swiping from right to left, disable movement
                        withAnimation {
                            xOffSet = 0
                        }
                    }
                }
                .onEnded { gesture in
                    if -gesture.predictedEndTranslation.width > 90 {
                        withAnimation(.easeInOut(duration: 1)) {
                            xOffSet -= UIScreen.main.bounds.width
                        }
                        action()
                    }
                    else {
                        withAnimation {
                            xOffSet = 0
                        }
                    }
                })
    }
}
