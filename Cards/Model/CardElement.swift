//
//  CardElement.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/6/24.
//

import SwiftUI

// ll of the property types in CardElement are existential types. That means they are types in their own right and not generic. However, you might have a requirement for id to be either a UUID or an Int or a String. In that case you can define CardElement with a generic type of ID:
protocol CardElement {
  var id: UUID { get }
  var transform: Transform { get set }
}

// Note: If later, you create another type of element such as ColorElement, to which you also want to be able to add clip frames, you could create a protocol Clippable, with frameIndex as a required property. Instead of testing to see if an element is an ImageElement, you can test to see whether the element is Clippable.
struct ImageElement: CardElement {
  let id = UUID()
  var transform = Transform()
  var frameIndex: Int?
  var uiImage: UIImage?
  var image: Image {
    Image(
      uiImage: uiImage ??
        UIImage(named: "error-image") ??
        UIImage())
  }
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
