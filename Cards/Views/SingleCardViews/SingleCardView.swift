//
//  SingleCardView.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/3/24.
//

import SwiftUI

struct SingleCardView: View {
  @State private var currentModal: ToolbarSelection?
  @Binding var card: Card
  
  var body: some View {
    NavigationStack {
      CardDetailView(card: $card)
        .modifier(CardToolbar(
          currentModal: $currentModal,
          card: $card))
    }
  }
}

struct SingleCardView_Previews: PreviewProvider {
  struct SingleCardPreview: View {
    @EnvironmentObject var store: CardStore
    
    var body: some View {
      SingleCardView(card: $store.cards[0])
    }
  }
  
  static var previews: some View {
    SingleCardPreview()
      .environmentObject(CardStore(defaultData: true))
  }
}
