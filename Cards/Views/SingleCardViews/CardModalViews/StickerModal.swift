//
//  StickerModal.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/7/24.
//

import SwiftUI

struct StickerModal: View {
  @Environment(\.dismiss) var dismiss
  @State private var stickerNames: [String] = []
  @Binding var stickerImage: UIImage?
  let columns = [
    // Swift Tip: As well as adaptive, GridItem.size can be fixed with a fixed size, or flexible, which sizes to the available space.
    GridItem(.adaptive(minimum: 120), spacing: 10)
  ]
  
  var body: some View {

    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(stickerNames, id: \.self) { sticker in
          Image(uiImage: image(from: sticker))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onTapGesture {
              stickerImage = image(from: sticker)
              dismiss()
            }
        }
      }
    }
    .onAppear {
      stickerNames = Self.loadStickers()
    }

    
    /*
     Way 1 - simpler. worked after a while a headache
      // 1
      if let resourcePath = Bundle.main.resourcePath,
        // 2
        let image = UIImage(named: resourcePath +
          "/Stickers/Camping/fire.png") {
          Image(uiImage: image)
      } else {
        EmptyView()
      }
*/
    /*
     Way 2 - smore complex from chatGPT and it worked also
    // 1 - Get the full resource path of the app bundle.
    if let stickerPath = Bundle.main.path(forResource: "Stickers", ofType: nil),
       // 2 - Get the full resource path of the app bundle.
       let fireImagePath = URL(string: stickerPath)?.appendingPathComponent("Camping/fire.png"),
       let image = UIImage(contentsOfFile: fireImagePath.path) {
      Image(uiImage: image)
    } else {
      Text(Bundle.main.path(forResource: "Stickers", ofType: nil) ?? "")
    }
     */
  }

  
  static func loadStickers() -> [String] {
    var themes: [URL] = []
    var stickerNames: [String] = []
    
    // 1 - Load the default file manager and bundle resource path.
    let fileManager = FileManager.default
    if let resoursePath = Bundle.main.resourcePath,
       // 2 - Get a directory enumerator, if it exists, for the Stickers folder. For the options parameter, you skip subdirectory descendants and hidden files. Unless you skip the subdirectories, an enumerator will continue down the hierarchy. You currently just want to collect the top folder names as the themes.
       let enumerator = fileManager.enumerator(
        at: URL(
          fileURLWithPath: resoursePath + "/Stickers"),
        includingPropertiesForKeys: nil,
        options: [
          .skipsSubdirectoryDescendants,
          .skipsHiddenFiles
        ]) {
      // 3 - If the URL is a directory, add it to themes.
      for case let url as URL in enumerator where url.hasDirectoryPath {
        themes.append(url)
      }
    }
    
    // Next you’ll iterate through all the theme directories and retrieve the file names inside.
    for theme in themes {
      // For each theme folder, you retrieve all the files in the directory and append the full path to stickerNames. You then return this array from the method.
      if let files = try? fileManager.contentsOfDirectory(atPath: theme.path) {
        for file in files {
          stickerNames.append(theme.path + "/" + file)
        }
      }
    }
    
    return stickerNames
  }
  
  func image(from path: String) -> UIImage {
    // You temporarily print out the path name so that you can check whether you’re lazily loading the image.
    print("loading: ", path)
    return UIImage(named: path)
      ?? UIImage(named: "error-image")
      ?? UIImage()
  }
}

#Preview {
  StickerModal(stickerImage: .constant(UIImage()))
}
