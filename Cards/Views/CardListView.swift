//
//  CardListView.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/3/24.
//

import SwiftUI

struct CardListView: View {
  
  @State private var isPresented = false
  
  var body: some View {
    list
      .fullScreenCover(isPresented: $isPresented) {
        SingleCardView()
      }
  }
  
  var list: some View {
    ScrollView(showsIndicators: false) {
      VStack {
        ForEach(0..<10) { _ in
          CardThumbnail()
            .onTapGesture {
              isPresented = true
            }
        }
      }
    }
  }
}

#Preview {
  CardListView()
}
