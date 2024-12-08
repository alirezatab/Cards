//
//  Card.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/6/24.
//

import SwiftUI

struct Card: Identifiable {
  let id = UUID()
  var backgroundColor: Color = .yellow
  var elements: [CardElement] = []
}
