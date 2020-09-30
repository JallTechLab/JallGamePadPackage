//
//  DPadShape.swift
//  
//
//  Created by Joe Lee on 2020/08/26.
//

import SwiftUI

struct DPadShape: Shape {
  private var triangleHeight: CGFloat
  private var padding: CGFloat
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: rect.midX, y: rect.minY - triangleHeight + padding))
    path.addLine(to: CGPoint(x: rect.minX + padding, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.minX + padding, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX - padding, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX - padding, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.midX, y: rect.minY - triangleHeight + padding))
    
    return path
  }
  
  init(triangleHeight: CGFloat = 10, padding: CGFloat = 5) {
    self.triangleHeight = triangleHeight
    self.padding = padding
  }
}

#if DEBUG
struct DPadShape_Previews: PreviewProvider {
  static var previews: some View {
    Text("▲")
      .overlay(
        DPadShape(triangleHeight: 60 / 2)
          .stroke(lineWidth: 5)
          .foregroundColor(Color.gray)
          .frame(width: 60, height: 60)
          .rotationEffect(Angle(degrees: 180))
    )
  }
}
#endif
