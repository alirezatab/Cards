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

extension Color {
  // colorComponents() separates a Color into red, green, blue and alpha components. These are returned in an array of four CGFloats. CGFloat conforms to Codable, so you’ll be able to store the color.
  func colorComponents() -> [CGFloat] {
    let uiColor = UIColor(self)
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0

    uiColor.getRed(
      &red,
      green: &green,
      blue: &blue,
      alpha: &alpha)
    return [red, green, blue, alpha]
  }

  // color(components:) is a static method which initializes a Color from four CGFloats. This is commonly called a factory method, as you’re creating a new instance.
  static func color(components color: [CGFloat]) -> Color {
    let uiColor = UIColor(
      red: color[0],
      green: color[1],
      blue: color[2],
      alpha: color[3])
    return Color(uiColor)
  }
}
