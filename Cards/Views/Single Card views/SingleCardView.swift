//
//  SingleCardView.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/3/24.
//

import SwiftUI

struct SingleCardView: View {
  
  @Environment(\.dismiss) var dismiss
  @State private var currentModal: ToolbarSelection?
  
  var body: some View {
    NavigationStack {
      Color.yellow
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
              dismiss()
            }
          }
        }
        .toolbar {
          ToolbarItem(placement: .bottomBar) {
            BottomToolbar(modal: $currentModal)
          }
        }
        .sheet(item: $currentModal) { item in
          switch item {
          default:
            Text(String(describing: item))
          }
        }
    }
  }
}

#Preview {
  SingleCardView()
}
