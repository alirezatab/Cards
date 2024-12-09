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
    .textModal: ("Text", "textFormat"),
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
  
  @Binding var modal: ToolbarSelection?
  
  var body: some View {
    HStack {
      ForEach(ToolbarSelection.allCases) { selection in
        Button {
          modal = selection
        } label: {
          ToolbarButton(modal: selection)
        }
      }
    }
  }
}

#Preview {
  BottomToolbar(modal: .constant(.stickerModal))
    .padding()
}
