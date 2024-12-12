//
//  CardToolbar.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/6/24.
//

import SwiftUI

struct CardToolbar: ViewModifier {
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var store: CardStore
  @Binding var currentModal: ToolbarSelection?
  @Binding var card: Card
  @State private var stickerImage: UIImage?
  @State private var frameIndex: Int?
  @State private var textElement = TextElement()
  
  func body(content: Content) -> some View {
    content
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          menu
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Done") {
            dismiss()
          }
        }
        /*
        ToolbarItem(placement: .navigationBarLeading) {
          PasteButton(payloadType: customTransfer.self) { items in
            Task {
              card.addElement(from: items)
            }
          }
          .labelStyle(.iconOnly)
          .buttonBorderShape(.capsule)
        }
         */
        ToolbarItem(placement: .bottomBar) {
          BottomToolbar(
            modal: $currentModal,
            card: $card)
        }
      }
      .sheet(item: $currentModal) { item in
        switch item {
        case .frameModal:
          FrameModal(frameIndex: $frameIndex)
            .onDisappear {
              if let frameIndex {
                card.update(store.selectedElement, frameIndex: frameIndex)
              }
              frameIndex = nil
            }
        case .stickerModal:
          StickerModal(stickerImage: $stickerImage)
            .onDisappear {
              if let stickerImage = stickerImage {
                card.addElement(uiImage: stickerImage)
              }
              stickerImage = nil
            }
        case .textModal:
          TextModal(textElement: $textElement)
            .onDisappear {
              if !textElement.text.isEmpty {
                card.addElement(text: textElement)
              }
              textElement = TextElement()
            }
        default:
          Text(String(describing: item))
        }
      }
  }
  
  var menu: some View {
    // 1 - You add a Menu to the top toolbar just to the left of the Done button. A Menu is a list of buttons. For this app, you’ll only have one button, but you can very easily add more under the Paste button.
    Menu {
      Button {
        if UIPasteboard.general.hasImages {
          if let images = UIPasteboard.general.images {
            for image in images {
              card.addElement(uiImage: image)
            }
          }
        } else if UIPasteboard.general.hasStrings {
          if let strings = UIPasteboard.general.strings {
            for text in strings {
              card.addElement(text: TextElement(text: text))
            }
          }
        }
      } label: {
        Label("Paste", systemImage: "doc.on.clipboard")
      }
      // 2 - You only want the paste button to be enabled when there is something to paste, so you check hasImages and hasStrings. If both are false, you disable the button.
      .disabled(!UIPasteboard.general.hasImages && !UIPasteboard.general.hasStrings)
    } label: {
      Label("Add", systemImage: "ellipsis.circle")
    }
  }
}
