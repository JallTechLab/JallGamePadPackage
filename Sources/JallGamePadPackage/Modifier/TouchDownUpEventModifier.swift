//
//  TouchDownUpEventModifier.swift
//  
//
//  Created by Joe Lee on 2020/08/26.
//

import SwiftUI

enum ButtonState {
  case released
  case pressed
}

struct TouchDownUpEventModifier: ViewModifier {
  // Limit the control event to be sent once only
  @State private var pressed = false
  
  // State change event
  let changeState: (ButtonState) -> Void
  
  // Body
  func body(content: Content) -> some View {
    content.simultaneousGesture(
      DragGesture(minimumDistance: 0)
        .onChanged { _ in
          if !self.pressed {
            self.pressed = true
            self.changeState(ButtonState.pressed)
          }
        }
        .onEnded { _ in
          self.pressed = false
          self.changeState(ButtonState.released)
        }
    )
  }
  
  // Init
  init(changeState: @escaping (ButtonState) -> Void) {
    self.changeState = changeState
  }
}
