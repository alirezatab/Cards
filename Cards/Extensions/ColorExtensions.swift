//
//  ColorExtensions.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/6/24.
//

import SwiftUI

extension Color {
  static let colors: [Color] = [
    .green, .red, .blue, .gray, .yellow, .pink, .orange, .purple
  ]
  
  /*
   Swift Tip: Astute readers will notice that this method could just as easily have been a static var computed property. However, conventionally, if you’re returning a value that may change often, or there is complex code, use a method.
   
   */
  static func random() -> Color {
    colors.randomElement() ?? .black
  }
}
