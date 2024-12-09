//
//  ElementContextMenu.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/9/24.
//

import SwiftUI

struct ElementContextMenu: ViewModifier {
  
  @Binding var card: Card
  @Binding var element: CardElement
  
  func body(content: Content) -> some View {
    content
    // You activate the context menu with a long press
      .contextMenu {
        Button {
          if let element = element as? TextElement {
            UIPasteboard.general.string = element.text
          } else if let element = element as? ImageElement,
                    let image = element.uiImage {
            UIPasteboard.general.image = image
          }
        } label: {
          Label("Copy", systemImage: "doc.on.doc")
        }
        
        // Your delete button should be highlighted as dangerous, and that’s what the destructive role does for you. The menu item will be in red.
        Button(role: .destructive) {
          card.remove(element)
        } label: {
          Label("Delete", systemImage: "trash")
        }
      }
  }
}

extension View {
  func elementContextMenu(
    card: Binding<Card>,
    element: Binding<CardElement>
  ) -> some View {
    modifier(ElementContextMenu(
      card: card,
      element: element))
  }
}
