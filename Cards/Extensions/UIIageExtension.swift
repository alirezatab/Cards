//
//  UIIageExtension.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/8/24.
//

import SwiftUI
///If you want to transfer a custom object that conforms to Codable, instead of DataRepresentation, you can use CodableRepresentation in the same way.

// 1 - Add a new extension to UIImage to conform to Transferable.
extension UIImage: Transferable {
  // 2 - transferRepresentation is a required property. TransferRepresentation describes how to transfer an item. You can describe how to import and export the item.
  public static var transferRepresentation: some TransferRepresentation {
    // 3 - When the imported UTType is an image, you’ll import the image as data and construct a UIImage from that data. DataRepresentation expects the return type to be the same type as Self, in this case, a UIImage.
    DataRepresentation(importedContentType: .image) { image in
      // 4 - reate the UIImage. If the operation fails, create an error image using the image in the asset catalog.
      UIImage(data: image) ?? errorImage
    }
  }
  
  public static var errorImage: UIImage {
    UIImage(named: "error-image") ?? UIImage()
  }
}
