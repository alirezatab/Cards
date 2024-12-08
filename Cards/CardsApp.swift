//
//  CardsApp.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/3/24.
//

import SwiftUI

@main
struct CardsApp: App {
  
  @StateObject var store = CardStore(defaultData: true)
  
  var body: some Scene {
    WindowGroup {
      CardListView()
        .environmentObject(store)
    }
  }
}
