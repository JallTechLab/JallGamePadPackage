//
//  DPadButtonModifier.swift
//  
//
//  Created by Joe Lee on 2020/08/26.
//

import SwiftUI

enum DPadDirection {
  case up
  case down
  case left
  case right
}

struct DPadButtonModifier: ViewModifier {
  var buttonSize: CGSize
  var direction: DPadDirection
  var actionTouchDown: () -> Void
  var actionTouchUp: () -> Void
  
  @State private var buttonPressed: Bool = false
  
  init(buttonSize: CGSize, direction: DPadDirection, actionTouchDown: @escaping () -> Void, actionTouchUp: @escaping () -> Void) {
    self.buttonSize = buttonSize
    self.direction = direction
    self.actionTouchDown = actionTouchDown
    self.actionTouchUp = actionTouchUp
  }
  
  var rotation: Double {
    switch direction {
    case .up:
      return 180
    case .down:
      return 0
    case .left:
      return 90
    case .right:
      return 270
    }
  }
  
  var offset: CGPoint {
    switch direction {
    case .up:
      return CGPoint(x: 0, y: -buttonSize.height)
    case .down:
      return CGPoint(x: 0, y: buttonSize.height)
    case .left:
      return CGPoint(x: -buttonSize.width, y: 0)
    case .right:
      return CGPoint(x: buttonSize.width, y: 0)
    }
  }
  
  func body(content: Content) -> some View {
    content
      .frame(width: buttonSize.width, height: buttonSize.height, alignment: .center)
      .overlay(
        DPadShape(triangleHeight: buttonSize.height / 2)
          .stroke(lineWidth: 5)
          .foregroundColor(Color.gray)
          .frame(width: buttonSize.width, height: buttonSize.height)
          .rotationEffect(Angle(degrees: rotation))
    )
      .offset(x: offset.x, y: offset.y)
      .modifier(TouchDownUpEventModifier(changeState: { (buttonState) in
        if buttonState == .pressed {
          self.buttonPressed = true
          let impactMed = UIImpactFeedbackGenerator(style: .medium)
          impactMed.impactOccurred()
          self.actionTouchDown()
        } else {
          self.buttonPressed = false
          let impactMed = UIImpactFeedbackGenerator(style: .medium)
          impactMed.impactOccurred()
          self.actionTouchUp()
        }
      }))
      .scaleEffect(self.buttonPressed ? 0.9 : 1.0).animation(.easeOut(duration: 0.2))
  }
}

#if DEBUG
struct DPadButtonModifier_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }
  
  struct PreviewWrapper: View {
    let buttonSize: CGSize = CGSize(width: 90, height: 90)
    
    var body: some View {
      Text("▲")
        .modifier(DPadButtonModifier(buttonSize: buttonSize, direction: .up, actionTouchDown: {
          print("Touch down")
        }, actionTouchUp: {
          print("Touch up")
        }))
    }
  }
}
#endif
