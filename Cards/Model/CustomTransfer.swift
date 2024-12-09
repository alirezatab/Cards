//
//  CustomTransfer.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/8/24.
//

import SwiftUI

struct customTransfer: Transferable {
  var image: UIImage?
  var text: String?
  
  // CustomTransfer contains two properties, one for text and one for image. The transfer representation takes into account the image type and the text type and fills in the relevant property. For images, the data representation is the same as you did for UIImage, and for text, you create a String from the data. UTF8 is the most common Unicode encoding system.
  public static var transferRepresentation: some TransferRepresentation {
    DataRepresentation(importedContentType: .image) { data in
      let image = UIImage(data: data) ?? UIImage(named: "error-image")
      return customTransfer(image: image)
    }
    DataRepresentation(importedContentType: .text) { data in
      let text = String(decoding: data, as: UTF8.self)
      return customTransfer(text: text)
    }
  }
}
