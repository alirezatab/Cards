//
//  Card.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/6/24.
//

import SwiftUI

struct Card: Identifiable {
  let id = UUID()
  var backgroundColor: Color = .yellow
  var elements: [CardElement] = []
  
  mutating func addElement(uiImage: UIImage) {
    let element = ImageElement(uiImage: uiImage)
    elements.append(element)
  }
  
  mutating func addElement(text: TextElement) {
    elements.append(text)
  }
  
  mutating func addElement(from transfer: [customTransfer]) {
    for element in transfer {
      if let text = element.text {
        addElement(text: TextElement(text: text))
      } else if let image = element.image {
        addElement(uiImage: image)
      }
    }
  }
  
  mutating func remove(_ element: CardElement) {
    // Here you retrieve the index of the card element. You then remove the element from the array using the index.
    if let index = element.index(in: elements) {
      elements.remove(at: index)
    }
  }
  
  // Note: If later, you create another type of element such as ColorElement, to which you also want to be able to add clip frames, you could create a protocol Clippable, with frameIndex as a required property. Instead of testing to see if an element is an ImageElement, you can test to see whether the element is Clippable.
  mutating func update(_ element: CardElement?, frameIndex: Int) {
    if let element = element as? ImageElement,
        let index = element.index(in: elements) {
      var newElement = element
      newElement.frameIndex = frameIndex
      elements[index] = newElement
    }
  }
}
