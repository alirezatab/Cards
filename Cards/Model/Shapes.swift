//
//  Shapes.swift
//  Cards
//
//  Created by ALIREZA TABRIZI on 12/9/24.
//

import SwiftUI



enum Shapes {
  static let shapes: [AnyShape] = [
    AnyShape(Circle()),
    AnyShape(Rectangle()),
    AnyShape(RoundedRectangle(cornerRadius: 25.0)),
    AnyShape(Heart()),
    AnyShape(Lens()),
    AnyShape(Chevron()),
    AnyShape(cone()),
    AnyShape(Cloud()),
    AnyShape(Dimond()),
    AnyShape(Polygon(sides: 6)),
    AnyShape(Polygon(sides: 8))
    
  ]
}

struct Triangle: Shape {
  // If you want the triangle to retain its shape, but size itself to fill the available size, you must use relative coordinates
  /*
  func path(in rect: CGRect) -> Path {
    var path = Path()
    // 1 - You create a new subpath by moving to a point. Paths can contain multiple subpaths.
    path.move(to: CGPoint(x: 20, y: 30))
    // 2 - Add straight lines from the previous point. You can alternatively put the two points in an array and use addLines(_:).
    path.addLine(to: CGPoint(x: 130, y: 70))
    path.addLine(to: CGPoint(x: 60, y: 140))
    // 3 - Close the subpath when you’ve finished to create the polygon.
    path.closeSubpath()
    
    return path
  }
  */
  
  // this is relative Coordinates
  func path(in rect: CGRect) -> Path {
    let width = rect.width
    let height = rect.height
    var path = Path()
    path.addLines([
      CGPoint(x: width * 0.13, y: height * 0.2),
      CGPoint(x: width * 0.87, y: height * 0.47),
      CGPoint(x: width * 0.4, y: height * 0.93),
    ])
    path.closeSubpath()
    return path
  }
}

struct cone: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let radius = min(rect.midX, rect.midY)
    path.addArc(
      center: CGPoint(x: rect.midX, y: rect.midY),
      radius: radius,
      startAngle: Angle(degrees: 0),
      endAngle: Angle(degrees: 180),
      clockwise: true)
    path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
    path.addLine(to: CGPoint(x: rect.midX + radius, y: rect.midY))
    path.closeSubpath()
    return path
  }
}

struct Lens: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: 0, y: rect.midY))
    path.addQuadCurve(
      to: CGPoint(x: rect.width, y: rect.midY),
      control: CGPoint(x: rect.midX, y: 0))
    path.addQuadCurve(
      to: CGPoint(x: 0, y: rect.midY),
      control: CGPoint(x: rect.midX, y: rect.height))
    path.closeSubpath()
    return path
  }
}

struct Dimond: Shape {
  func path(in rect: CGRect) -> Path {
    // 2 different way of doing it
    var path = Path()
    /*
    path.move(to: CGPoint(x: 0, y: rect.midY))
    path.addLine(to: CGPoint(x: rect.midX, y: 0))
    path.addLine(to: CGPoint(x: rect.width, y: rect.midY))
    path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
     */
    let width = rect.width
    let height = rect.height
    path.addLines([
      CGPoint(x: 0, y: height * 0.5),
      CGPoint(x: width * 0.5, y: 0),
      CGPoint(x: width, y: height * 0.5),
      CGPoint(x: width * 0.5, y: height),
    ])
    
    path.closeSubpath()
    return path
  }
}

struct Heart: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
    path.addCurve(
      to: CGPoint(x: rect.minX, y: rect.maxY * 0.25),
      //to: CGPoint(x: rect.minX, y: rect.height * 0.25),
      control1: CGPoint(x: rect.midX * 0.7, y: rect.maxY * 0.9),
      control2: CGPoint(x: rect.minX, y: rect.midY))
    path.addArc(
      center: CGPoint(x: rect.width * 0.25, y: rect.height * 0.25),
      radius: rect.width * 0.25,
      startAngle: Angle(radians: .pi),
      endAngle: Angle(degrees: 0),
      clockwise: false)
    path.addArc(
      center: CGPoint(x: rect.width * 0.75, y: rect.height * 0.25),
      radius: rect.width * 0.25,
      startAngle: Angle(radians: .pi),
      endAngle: Angle(degrees: 0),
      clockwise: false)
    path.addCurve(
      to: CGPoint(x: rect.midX, y: rect.maxY),
      //to: CGPoint(x: rect.midX, y: rect.height),
      control1: CGPoint(x: rect.width, y: rect.midY),
      control2: CGPoint(x: rect.midX * 1.3, y: rect.height * 0.9))
    path.closeSubpath()
    return path
  }
}

struct Chevron: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let width = rect.width
    let height = rect.height
    path.addLines([
      CGPoint(x: 0, y: 0),
      CGPoint(x: width * 0.75, y: 0),
      CGPoint(x: width, y: height * 0.5),
      CGPoint(x: width * 0.75, y: height),
      CGPoint(x: 0, y: height),
      CGPoint(x: width * 0.25, y: height * 0.5)
    ])
    
    
    path.closeSubpath()
    return path
  }
}

struct Cloud: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    let width = rect.width
    let height = rect.height
    path.move(to: CGPoint(x: width * 0.2, y: height * 0.2))
    path.addQuadCurve(
      to: CGPoint(x: width * 0.6, y: height * 0.1 ),
      control: CGPoint(x: width * 0.32, y: height * -0.12))
    path.addQuadCurve(
      to: CGPoint(x: width * 0.85, y: height * 0.2 ),
      control: CGPoint(x: width * 0.8, y: height * 0.05))
    path.addQuadCurve(
      to: CGPoint(x: width * 0.9, y: height * 0.6 ),
      control: CGPoint(x: width * 1.1, y: height * 0.35))
    path.addQuadCurve(
      to: CGPoint(x: width * 0.65, y: height * 0.9 ),
      control: CGPoint(x: width * 1, y: height * 0.95))
    path.addQuadCurve(
      to: CGPoint(x: width * 0.15, y: height * 0.7 ),
      control: CGPoint(x: width * 0.2, y: height * 1.1))
    path.addQuadCurve(
      to: CGPoint(x: width * 0.2, y: height * 0.2 ),
      control: CGPoint(x: width * -0.15, y: height * 0.45))
    
    path.closeSubpath()
    return path
  }
}

struct Polygon: Shape {
  let sides: Int
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    let radius = min(rect.midX, rect.midY)
    let angle = CGFloat.pi * 2 / CGFloat(sides)
    let points: [CGPoint] = (0..<sides).map { index in
      let currentAngel = angle * CGFloat(index)
      let pointX = radius * cos(currentAngel) + radius
      let pointY = radius * sin(currentAngel) + radius
      return CGPoint(x: pointX, y: pointY)
    }
    path.move(to: points[0])
    for i in 1..<points.count {
      path.addLine(to: points[i])
    }
    
    path.closeSubpath()
    return path
  }
}


#Preview {
  VStack {
    Rectangle()
    RoundedRectangle(cornerRadius: 25.0)
    Circle()
    Capsule()
    Ellipse()
  }.padding()
}

struct Shapes_Previews: PreviewProvider {
  static let currentShape = Polygon(sides: 6)

  // With a stroke style, you can define what the outline looks like — whether it is dashed, how the dash is formed and how the line ends look.
  // To form a dash, you create an array which defines the number of horizontal points of the filled section followed by the number of horizontal points of the empty section.
  static var previews: some View {
    currentShape
      .stroke(Color.primary, style: StrokeStyle(lineWidth: 10, lineJoin: .round))
      .padding()
      .aspectRatio(1, contentMode: .fit)
      .background(Color.yellow)
      .previewLayout(.sizeThatFits)
  }
}

