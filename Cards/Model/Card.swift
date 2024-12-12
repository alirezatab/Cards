//
//  Card.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/6/24.
//

import SwiftUI

struct Card: Identifiable {
  var id = UUID()
  var backgroundColor: Color = .yellow
  var elements: [CardElement] = []
  
  mutating func addElement(uiImage: UIImage) {
    // 1 - You now save the UIImage to a file using the code provided in UIImageExtensions.swift. uiImage.save() saves the PNG data to disk and returns a UUID string as the filename. Before saving, save() resizes large images, as you don’t need to store the full resolution for the card.
    let imageFileName = uiImage.save()
    // 2 - You create the new element with the string filename and the original uiImage.
    let element = ImageElement(
      uiImage: uiImage,
      imageFilename: imageFileName)
    elements.append(element)
    save()
  }
  
  mutating func addElement(text: TextElement) {
    elements.append(text)
  }
  
  mutating func addElement(from transfer: [customTransfer]) {
    for element in transfer {
      if let text = element.text {
        addElement(text: TextElement(text: text))
      } else if let image = element.image {
        addElement(uiImage: image)
      }
    }
  }
  
  mutating func remove(_ element: CardElement) {
    if let element = element as? ImageElement {
      UIImage.remove(name: element.imageFilename)
    }
    // Here you retrieve the index of the card element. You then remove the element from the array using the index.
    if let index = element.index(in: elements) {
      elements.remove(at: index)
    }
    save()
  }
  
  // Note: If later, you create another type of element such as ColorElement, to which you also want to be able to add clip frames, you could create a protocol Clippable, with frameIndex as a required property. Instead of testing to see if an element is an ImageElement, you can test to see whether the element is Clippable.
  mutating func update(_ element: CardElement?, frameIndex: Int) {
    if let element = element as? ImageElement,
        let index = element.index(in: elements) {
      var newElement = element
      newElement.frameIndex = frameIndex
      elements[index] = newElement
    }
  }
  
  func save() {
    do {
      // 1 - Set up the JSON encoder.
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      // 2 - Set up a Data property. This is a buffer that will hold any kind of byte data and is what you will write to disk. Fill the data buffer with the encoded Card.
      let data = try encoder.encode(self)
      // 3 - The filename will be the card id plus a .rwcard extension.
      let filename = "\(id).rwcard"
      let url = URL.documentsDirectory.appendingPathComponent(filename)
      // 4 - Write the data to the file.
      try data.write(to: url)
    } catch {
      print(error.localizedDescription)
    }
  }
}

extension Card: Codable {
  enum CodingKeys: CodingKey {
    case id, backgroundColor, imageElements, textElements
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    // 1 - Decode the saved id string and restore id from the UUID string.
    let id = try container.decode(String.self, forKey: .id)
    self.id = UUID(uuidString: id) ?? UUID()
    // 2 - Load the array of image elements. You use the += operator to add to any elements that may already be there, just in case you load the text elements first. You’ll load the text elements in the challenge at the end of the chapter.
    elements += try container.decode([ImageElement].self, forKey: .imageElements)
  
    // Challenge 2 - load the text elements
    elements += try container.decode([TextElement].self, forKey: .textElements)
    
    // Challenge 1 - load the background color
    let components = try container.decode([CGFloat].self, forKey: .backgroundColor)
    backgroundColor = Color.color(components: components)
  }
  
  //Here you encode the id as a UUID string. You also extract all the image elements from elements using compactMap(_:)
  func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id.uuidString, forKey: .id)
    // compactMap(_:) returns an array with all the non-nil elements that match the closure. $0 represents each element.
    let imageElements: [ImageElement] = elements.compactMap { $0 as? ImageElement }
    try container.encode(imageElements, forKey: .imageElements)
    
    // Challenge 1 - load the background color
    let components = backgroundColor.colorComponents()
    try container.encode(components, forKey: .backgroundColor)
    
    // Challenge 2 - save the text elements
    let textElements: [TextElement] = elements.compactMap { $0 as? TextElement }
    try container.encode(textElements, forKey: .textElements)
  }
}
