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
      // Always be aware of whether your data is mutable. Later, you’ll update the element’s Transform within this ForEach loop. Generally, when you iterate through an array in a loop, the individual item is immutable. However, this variant of ForEach allows binding syntax by adding the $ in front of the array and the individual item.
      ForEach($card.elements, id: \.id) { $element in
        CardElementView(element: element)
          .elementContextMenu(card: $card, element: $element)
          .resizableView(transform: $element.transform)
          .frame(
            width: element.transform.size.width,
            height: element.transform.size.height)
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
