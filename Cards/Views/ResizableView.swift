/// Copyright (c) 2024 Kodeco
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct ResizableView: ViewModifier {
  
  @State private var transform = Transform()
  @State private var previousOffset: CGSize = .zero
  @State private var previousRotation: Angle = .zero
  @State private var scale: CGFloat = 1.0
  
  // Create a new Gesture property in ResizableView:
  var dragGesture: some Gesture {
    DragGesture()
    // The gesture updates transform’s offset property as the user drags the view.
    //onChanged(_:) has one parameter of type Value, which contains the gesture’s current touch location and the translation since the start of the touch.
      .onChanged { value in
        // In onChanged(_:), you update transform with the user’s drag translation amount and include any previous dragging.
        transform.offset = value.translation + previousOffset
      }
    // In onEnded(_:), you replace the old previousOffset with the new offset, ready for the next drag. You don’t need to use the value provided, so you use _ as the parameter for the action method.
      .onEnded { _ in
        previousOffset = transform.offset
      }
  }
  /// Swift Tip: rotationEffect(_:anchor:) by default rotates around the center of the view, but you can change that to another point in the view by changing anchor.
  var rotationGesture: some Gesture {
    RotationGesture()
    // onChanged(_:) provides the gesture’s angle of rotation as the parameter for the action you provide. You add the current rotation, less the previous rotation, to transform’s rotation.
      .onChanged { rotation in
        transform.rotation += rotation - previousRotation
        previousRotation = rotation
    // onEnded(_:) takes place after the user removes his fingers from the screen. Here, you set any previous rotation to zero.
      }.onEnded { _ in
        previousRotation = .zero
      }
  }
  
  var scaleGesture: some Gesture {
    MagnificationGesture()
    //onChanged(_:) takes the current gesture’s scale and stores it in the state property scale.
      .onChanged { scale in
        self.scale = scale
      }
    // When the user has finished the pinch and raises his fingers from the screen, onEnded(_:) takes the gesture’s scale and changes transform’s width and height. You then reset ResizableView.scale to 1.0 to be ready for the next scale.
      .onEnded { scale in
        transform.size.width *= scale
        transform.size.height *= scale
        self.scale = 1.0
      }
  }
  
  func body(content: Content) -> some View {
    // 1 - Use content as the required View in body and apply modifiers to it.
    content
      .frame(
        width: transform.size.width,
        height:  transform.size.height)
    // Order of modifiers is important — gesture(_:) needs to go after any positioning modifiers.
      .rotationEffect(transform.rotation)
      .scaleEffect(scale)
      .offset(transform.offset)
      .gesture(dragGesture)
      .gesture(
        SimultaneousGesture(rotationGesture, scaleGesture))
  }
}

#Preview {
  RoundedRectangle(cornerRadius: 30.0)
    .foregroundColor(Color.blue)
    .resizableView()
    //.modifier(ResizableView())
}

// “pass-through” method
extension View {
  // You extend the View protocol with a default method. resizableView() is now available on any object that conforms to View. The method simply returns your modifier, but it does make your code easier to read.
  public func resizableView() -> some View {
    modifier(ResizableView())
  }
}
