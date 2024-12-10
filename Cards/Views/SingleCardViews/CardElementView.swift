//
//  CardElementView.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/7/24.
//

import SwiftUI

struct CardElementView: View {
  let element: CardElement
  
  var body: some View {
    if let element = element as? ImageElement {
      ImageElementView(element: element)
        .clip()
    }
    if let element = element as? TextElement {
      TextElementView(element: element)
    }
  }
}

struct TextElementView: View {
  let element: TextElement
  
  var body: some View {
    if !element.text.isEmpty {
      Text(element.text)
        .font(.custom(element.textFont, size: 200))
        .foregroundStyle(element.textColor)
        .scalableText()
    }
  }
}

struct ImageElementView: View {
  let element: ImageElement
  
  var body: some View {
    element.image
      .resizable()
      .aspectRatio(contentMode: .fit)
    
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

#Preview {
  CardElementView(element: initialElements[3])
}
