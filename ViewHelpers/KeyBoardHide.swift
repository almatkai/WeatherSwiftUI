//
//  KeyBoardHide.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 13.08.2023.
//

import Foundation
import UIKit

func keyBoardHide() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
