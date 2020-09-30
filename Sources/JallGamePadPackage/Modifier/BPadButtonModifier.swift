//
//  BPadButtonModifier.swift
//  
//
//  Created by Joe Lee on 2020/08/26.
//

import SwiftUI

struct BPadButtonModifier: ViewModifier {
  // State
  @State var buttonSize: CGSize
  @State var color: Color = Color.gray
  @State var actionTouchDown: () -> Void  // Button touch down event
  @State var actionTouchUp: () -> Void    // Button touch up event
  @State private var buttonPressed: Bool = false // Button is pressed
  
  var shortSide: CGFloat {
    return min(buttonSize.width, buttonSize.height)
  }
  
  func body(content: Content) -> some View {
    content
      .frame(width: buttonSize.width, height: buttonSize.height, alignment: .center)
      .overlay(
        RoundedRectangle(cornerRadius: shortSide)
          .stroke(lineWidth: 5)
          .foregroundColor(color)
    )
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
struct BPadButtonModifier_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }
  
  struct PreviewWrapper: View {
    let buttonSize: CGSize = CGSize(width: 90, height: 90)
    
    var body: some View {
      Text("A")
        .modifier(BPadButtonModifier(buttonSize: buttonSize, color: Color.red, actionTouchDown: {
          print("Touch down")
        }, actionTouchUp: {
          print("Touch up")
        }))
    }
  }
}
#endif
