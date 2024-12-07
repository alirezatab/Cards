//
//  SingleCardView.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/3/24.
//

import SwiftUI

struct SingleCardView: View {
  @State private var currentModal: ToolbarSelection?
  
  var body: some View {
    NavigationStack {
      content
        .modifier(CardToolbar(currentModal: $currentModal))
    }
  }
  
  var content: some View {
    ZStack {
      Group {
        Capsule()
          .foregroundStyle(.yellow)
        Text("Resize Me!")
          .fontWeight(.bold)
        // There is a trick to scaling text on demand. Give the font a huge size, say 500. Then apply a minimum scale factor to it, to reduce it in size.
          .font(.system(size: 500))
          .minimumScaleFactor(0.01)
        // .lineLimit(1) ensures the text stays on one line and doesn’t wrap around.
          .lineLimit(1)
      }
      .resizableView()
      
      Circle()
        .resizableView()
        .offset(CGSize(width: 50, height: 200))
    }
  }
}

#Preview {
  SingleCardView()
}
