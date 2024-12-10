//
//  FrameModal.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/10/24.
//

import SwiftUI

struct FrameModal: View {
  @Environment(\.dismiss) var dismiss
  
  // 1 - Pass in an integer that will hold the index of the selected shape in the Shapes array.
  @Binding var frameIndex: Int?
  private let colums = [
    GridItem(.adaptive(minimum: 120), spacing: 10)
  ]
  private let style = StrokeStyle(lineWidth: 5, lineJoin: .round)
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: colums) {
        // 2 - Iterate through the array of shapes by index.
        ForEach(0..<Shapes.shapes.count, id: \.self) { index in
          Shapes.shapes[index]
          // 3 - Outline the shape with the primary color.
            .stroke(Color.primary, style: style)
            // 4 - Fill the shape so that you have a touch area. If you don’t fill the shape, the tap will only work on the stroke.
            .background(Shapes.shapes[index].fill(Color.secondary))
            .frame(width: 100, height: 120)
            .padding()
            // 5 - When the user taps the shape, update frameIndex and dismiss the modal.
            .onTapGesture {
              frameIndex = index
              dismiss()
            }
        }
      }
    }
    .padding(5)
  }
}

#Preview {
  FrameModal(frameIndex: .constant(nil))
}
