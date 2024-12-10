//
//  BottomToolbar.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/3/24.
//

import SwiftUI

struct ToolbarButton: View {
  
  let modal: ToolbarSelection
  private let modalButton: [
    ToolbarSelection: (text: String, imageName: String)
  ] = [
    .photoModal: ("photos", "photo"),
    .frameModal: ("Frames", "square.on.circle"),
    .stickerModal: ("Stickers", "heart.circle"),
    .textModal: ("Text", "textformat")
  ]
  
  var body: some View {
    if let text = modalButton[modal]?.text,
        let imageName = modalButton[modal]?.imageName {
      VStack {
        Image(systemName: imageName)
          .font(.largeTitle)
        Text(text)
      }
      .padding(.top)
    }
  }
}

struct BottomToolbar: View {
  
  @EnvironmentObject var store: CardStore
  @Binding var modal: ToolbarSelection?
  @Binding var card: Card
  
  var body: some View {
    HStack {
      ForEach(ToolbarSelection.allCases) { selection in
        switch selection {
        case .frameModal:
          defaultButton(selection)
            .disabled(
              store.selectedElement == nil || !(store.selectedElement is ImageElement)
            )
        case .photoModal:
          Button {
            
          } label: {
            PhotosModal(card: $card)
          }
        default:
          defaultButton(selection)
        }
      }
    }
  }
  
  func defaultButton(_ selection: ToolbarSelection) -> some View {
    Button {
      modal = selection
    } label: {
      ToolbarButton(modal: selection)
    }
  }
}

#Preview {
  BottomToolbar(
    modal: .constant(.stickerModal),
    card: .constant(Card()))
  .padding()
  .environmentObject(CardStore())
}
