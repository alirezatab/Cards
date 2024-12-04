//
//  CardThumbnail.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/3/24.
//

import SwiftUI

struct CardThumbnail: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 15)
      .foregroundStyle(.gray)
      .frame(width: 150, height: 250)
  }
}


#Preview {
  CardThumbnail()
}
