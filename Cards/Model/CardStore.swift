//
//  CardStore.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/7/24.
//

import SwiftUI

class CardStore: ObservableObject {
  @Published var cards: [Card] = []
  @Published var selectedElement: CardElement?
  
  init(defaultData: Bool = false) {
    cards = defaultData ? initialCards : load()
  }
  
  func index(for card: Card) -> Int? {
    cards.firstIndex { $0.id == card.id }
  }
  
  func remove(_ card: Card) {
    if let index = index(for: card) {
      cards.remove(at: index)
    }
  }
  
  func addCard() -> Card {
    let card = Card(backgroundColor: Color.random())
    cards.append(card)
    card.save()
    return card
  }
}

extension CardStore {
  // 1 - You’ll return an array of Cards from load(). These will be all the cards in the Documents folder.
  func load() -> [Card] {
    var cards: [Card] = []
    // 2 - Set up the path for the Documents folder and enumerate all the files and folders inside this folder.
    let path = URL.documentsDirectory.path
    guard
      let enumerator = FileManager.default.enumerator(atPath: path),
      let files = enumerator.allObjects as? [String]
    else { return cards }
    // 3 - Filter the files so that you only hold files with the .rwcard extension. These are the Card files.
    let cardFiles = files.filter { $0.contains(".rwcard") }
    for cardFile in cardFiles {
      do {
        // 4 - Read each file into a Data variable.
        let path = path + "/" + cardFile
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        // 5 - Decode each Card from the Data variable. You’ve done all the hard work of making all the properties used by Card and its subtypes Codable, so you can then simply add the decoded Card to the array you’re building.
        let decoder = JSONDecoder()
        let card = try decoder.decode(Card.self, from: data)
        cards.append(card)
      } catch {
        print("Error: ", error.localizedDescription)
      }
    }
    return cards
  }
}
