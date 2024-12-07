//
//  Settings.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/6/24.
//

import SwiftUI

// Here you create default values for the final card size, the card thumbnail size, the card element size and for a border that you’ll use later.
// Notice that you created a structure. While this works, it could become problematic, because you could instantiate the structure and have copies of Settings throughout your app.
// let settings1 = Settings()
// let settings2 = Settings()
/*
 struct Settings {
 static let cardSize = CGSize(width: 1300, height:  2000)
 static let thumbnailSize = CGSize(width: 150, height: 250)
 static let defaultElementSize = CGSize(width: 250, height: 180)
 static let borderColor: Color = .blue
 static let borderWidth: CGFloat = 5
 }
 */

// However, if you use an enumeration, you can’t instantiate it, so it ensures that you will only ever have one copy of Settings.
enum Settings {
  static let cardSize = CGSize(width: 1300, height:  2000)
  static let thumbnailSize = CGSize(width: 150, height: 250)
  static let defaultElementSize = CGSize(width: 250, height: 180)
  static let borderColor: Color = .blue
  static let borderWidth: CGFloat = 5
}
