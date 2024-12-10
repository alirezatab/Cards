//
//  CardDetailView.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/7/24.
//

import SwiftUI

struct CardDetailView: View {
  // 1 - Add a reference to the CardStore environment object and a Card binding.
  @EnvironmentObject var store: CardStore
  @Binding var card: Card
  
  var body: some View {
    // 2 - Use the card’s background color and put it inside a ZStack.
    ZStack {
      card.backgroundColor
        .onTapGesture {
          store.selectedElement = nil
        }
      // Always be aware of whether your data is mutable. Later, you’ll update the element’s Transform within this ForEach loop. Generally, when you iterate through an array in a loop, the individual item is immutable. However, this variant of ForEach allows binding syntax by adding the $ in front of the array and the individual item.
      ForEach($card.elements, id: \.id) { $element in
        CardElementView(element: element)
          .overlay(element: element, isSelected: isSelected(element))
          .elementContextMenu(card: $card, element: $element)
          .resizableView(transform: $element.transform)
          .frame(
            width: element.transform.size.width,
            height: element.transform.size.height)
          .onTapGesture {
            store.selectedElement = element
          }
      }
    }
    //  having two drop destination modifiers doesn’t work.
    /*
    .dropDestination(for: UIImage.self) { images, location in
      // Just as you did with your photos, you receive the dragged image or images as an array of data streams. You create a UIImage from the data and add the image to the card’s array of elements. You return whether the operation was successful.
      print(location)
      for image in images {
        card.addElement(uiImage: image)
      }
      return !images.isEmpty
    }
    */
    /*
    .dropDestination(for: String.self) { strings, _ in
      for text in strings {
        card.addElement(text: TextElement(text: text))
      }
      return !strings.isEmpty
    }
     */
    .dropDestination(for: customTransfer.self) { items, locations in
      print(locations)
      Task {
        card.addElement(from: items)
      }
      return !items.isEmpty
    }
    .onDisappear {
      store.selectedElement = nil
    }
  }
  
  func isSelected(_ element: CardElement) -> Bool {
    store.selectedElement?.id == element.id
  }
}

private extension View {
  
  @ViewBuilder
  func overlay(element: CardElement, isSelected: Bool) -> some View {
    if isSelected,
       let element = element as? ImageElement,
       let index = element.frameIndex {
      
      let shape = Shapes.shapes[index]
      self.overlay(
        shape
          .stroke(lineWidth: Settings.borderWidth)
          .foregroundStyle(Settings.borderColor))
    } else {
      self.border(
        Settings.borderColor,
        width: isSelected ? Settings.borderWidth : 0)
    }
  }
}

// 1 - The modifier is specific to this view, so you create it as a private extension. Creating the extension on ImageElementView means that clipping will only apply to this type. Clipping a text element makes little sense.
private extension ImageElementView {
  // 2 - he ViewBuilder attribute allows you to build up views and combine them into one. Check out Chapter 9, “Refining Your App” if you need a refresher on how this works.
  @ViewBuilder
  func clip() -> some View {
    // 3 - Use if-let to get the frameIndex.
    if let frameIndex = element.frameIndex {
      // 4 - If there’s a value in frameIndex, clip the view with the element’s frame shape. Otherwise, return the unmodified view.
      let shape = Shapes.shapes[frameIndex]
      self.clipShape(shape)
        .contentShape(shape)
    } else {
      self
    }
  }
}

struct CardDetailView_Previews: PreviewProvider {
  struct CardDetailPreview: View {
    @EnvironmentObject var store: CardStore

    var body: some View {
      CardDetailView(card: $store.cards[0])
    }
  }

  static var previews: some View {
    CardDetailPreview()
      .environmentObject(CardStore(defaultData: true))
  }
}
