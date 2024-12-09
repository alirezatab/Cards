//
//  ToolbarSelection.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/3/24.
//

import Foundation

enum ToolbarSelection: CaseIterable, Identifiable {
  // “Enums must not contain stored properties”. so you cant use
  // var id = UUID()
  // Instead of a stored property, this var is a computed property. 
  var id: Int { hashValue }
  case photoModal, frameModal, stickerModal, textModal
}
