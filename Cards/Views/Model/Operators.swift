//
//  Operators.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/6/24.
//

import SwiftUI

// To add translation to offset, you must add width to width and, at the same time, add height to height. To do this, you’ll redefine + with a new method.
func + (left: CGSize, right: CGSize) -> CGSize {
  CGSize(
    width: left.width + right.width,
    height: left.height + right.height)
}
