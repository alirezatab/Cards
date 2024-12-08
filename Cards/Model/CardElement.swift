//
//  CardElement.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/6/24.
//

import SwiftUI

protocol CardElement {
  var id: UUID { get }
  var transform: Transform { get set }
}

struct ImageElement: CardElement {
  let id = UUID()
  var transform = Transform()
  var image: Image
}

struct TextElement: CardElement {
  let id = UUID()
  var transform = Transform()
  var text = " "
  var textColor = Color.black
  var textFont = "Gill Sans"
}

extension CardElement {
  func index(in array: [CardElement]) -> Int? {
    array.firstIndex { $0.id == id }
  }
}
