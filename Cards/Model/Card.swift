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
}
