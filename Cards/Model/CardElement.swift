//
//  CardElement.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/6/24.
//

import SwiftUI

// ll of the property types in CardElement are existential types. That means they are types in their own right and not generic. However, you might have a requirement for id to be either a UUID or an Int or a String. In that case you can define CardElement with a generic type of ID:
protocol CardElement {
  var id: UUID { get }
  var transform: Transform { get set }
}

// Note: If later, you create another type of element such as ColorElement, to which you also want to be able to add clip frames, you could create a protocol Clippable, with frameIndex as a required property. Instead of testing to see if an element is an ImageElement, you can test to see whether the element is Clippable.
struct ImageElement: CardElement {
  let id = UUID()
  var transform = Transform()
  var frameIndex: Int?
  var uiImage: UIImage?
  var imageFilename: String?
  var image: Image {
    Image(
      uiImage: uiImage ??
        UIImage(named: "error-image") ??
        UIImage())
  }
}

// When adding a second initializer to the main definition of a structure, you lose the default initializer and have to recreate it yourself. However, adding initializers to extensions doesn’t have this effect
// When you conform ImageElement to Codable, you provide the decoding initializer init(from:). By adding the initializer to this extension, you keep both the default initializer and the new decoding one.
extension ImageElement: Codable {
  enum CodingKeys: CodingKey {
    case transform, imageFilename, frameIndex
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    //1 - Decode the transform and frame index. They are Codable, so they take care of themselves.
    transform = try container.decode(Transform.self, forKey: .transform)
    frameIndex = try container.decodeIfPresent(Int.self, forKey: .frameIndex)
    // 2 - When decoding optionals, such as frameIndex and imageFilename, if you decode something that doesn’t exist, the decoder will throw an error. Check whether the data exists using decodeIfPresent(_:forKey:).
    imageFilename = try container.decodeIfPresent(String.self, forKey: .imageFilename)
    // 3 - If the filename is present, load the image using the filename.
    if let imageFilename {
      uiImage = UIImage.load(uuidString: imageFilename)
    } else {
        // 4 - If there’s an error loading the image, use the error image in Assets.xcassets.
      uiImage = UIImage.errorImage
    }
  }
  
  func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(transform, forKey: .transform)
    try container.encode(frameIndex, forKey: .frameIndex)
    try container.encode(imageFilename, forKey: .imageFilename)
  }
}

struct TextElement: CardElement {
  let id = UUID()
  var transform = Transform()
  var text = ""
  var textColor = Color.black
  var textFont = "Gill Sans"
}

extension TextElement: Codable {
  enum CodingKeys: CodingKey {
    case transform, text, textColor, textFont
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    transform = try container.decode(Transform.self, forKey: .transform)
    text = try container.decode(String.self, forKey: .text)
    textFont = try container.decode(String.self, forKey: .textFont)
    
    let textColorComponents = try container.decode([CGFloat].self, forKey: .textColor)
    textColor = Color.color(components: textColorComponents)
  }
  
  func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(transform, forKey: .transform)
    try container.encode(text, forKey: .text)
    try container.encode(textFont, forKey: .textFont)
    let textColorComponents = textColor.colorComponents()
    try container.encode(textColorComponents, forKey: .textColor)
  }
}

extension CardElement {
  func index(in array: [CardElement]) -> Int? {
    array.firstIndex { $0.id == id }
  }
}
