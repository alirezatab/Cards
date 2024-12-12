//
//  CardListView.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/3/24.
//

import SwiftUI

struct CardListView: View {
  // scenePhase enumerations are, active, inactive, background
  @Environment(\.scenePhase) private var scenePhase
  @EnvironmentObject var store: CardStore
  @State private var selectedCard: Card?
  
  var body: some View {
    VStack {
      list
        .fullScreenCover(item: $selectedCard) { card in
          if let index = store.index(for: card) {
            SingleCardView(card: $store.cards[index])
              .onChange(of: scenePhase) { newScenePhase in
                if newScenePhase == .inactive {
                  store.cards[index].save()
                }
              }
          } else {
            fatalError("Unable to locate selected card")
          }
        }
        .onAppear {
          print(URL.documentsDirectory)
        }
      
      // When you tap the Add button, you call your new addCard() method in store. This adds a new Card to the store’s cards array and saves the card file to disk.
      // By changing selectedCard, you trigger fullScreenCover(item:), which displays the new card.
      Button("Add") {
        selectedCard = store.addCard()
      }
    }
  }
  
  var list: some View {
    ScrollView(showsIndicators: false) {
      VStack {
        ForEach(store.cards) { card in
          CardThumbnail(card: card)
            .contextMenu {
              Button(role: .destructive) {
                store.remove(card)
              } label: {
                Label("Delete", systemImage: "trash")
              }
            }
            .onTapGesture {
              selectedCard = card
            }
        }
      }
    }
  }
}

#Preview {
  CardListView()
    .environmentObject(CardStore(defaultData: true))
}
