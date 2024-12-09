//
//  PhotosModal.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/8/24.
//

import SwiftUI
import PhotosUI

struct PhotosModal: View {
  // 1 - Create an array to hold the selected images. The type PhotosPickerItem doesn’t contain the actual image data. Instead, it contains only an identifier and the type of content, such as jpeg, that the item supports.
  @State private var selectedItems: [PhotosPickerItem] = []
  @Binding var card: Card
  
  var body: some View {
    // 2 - Display the photos picker view.
    PhotosPicker(
      // 3 - As the user taps and selects media assets, the photos picker adds them to selectedItems.
      selection: $selectedItems,
      // 4 - You can filter the photo library in various ways, such as screenshots or videos. For Cards, you filter images. You can see the other available filters here.
      matching: .images) {
        // 5 - PhotosPicker requires a label to start it, so you include the image and text you already set up in ToolbarButton.
        ToolbarButton(modal: .photoModal)
      }
      .onChange(of: selectedItems) { _, newValue in
        // You load the item as a Data type. result is of type Result<Success, Failure>. Success contains the image data, and Failure contains a failure value.
        // For each item, you load the image on a background thread using Task {}.
        for item in newValue {
          item.loadTransferable(type: Data.self) { result in
            Task {
              switch result {
              case .success(let data):
                if let data,
                   let uiImage = UIImage(data: data) {
                  // The error arises because you are trying to mutate an @Binding property (card) inside an asynchronous context (Task {}), and Swift 6 enforces stricter actor isolation rules. Since @Binding properties are not guaranteed to be MainActor-isolated, you must explicitly ensure the mutation occurs within the main actor.
                  await MainActor.run {
                    card.addElement(uiImage: uiImage)
                  }
                }
              case .failure(let failure):
                fatalError("Image transfer failed: \(failure)")
              }
              
            }
          }
        }
        selectedItems = []
      }
  }
}

#Preview {
  PhotosModal(card: .constant(Card()))
}
