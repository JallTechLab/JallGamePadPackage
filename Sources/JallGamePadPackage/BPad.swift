//
//  BPada.swift
//  
//
//  Created by Joe Lee on 2020/08/26.
//

import SwiftUI

public struct BPadNotification {
  public static let BPadButtonStatusChanged: Notification.Name = Notification.Name("Notification.BPad.Button.Status.Changed")
}

public enum BPadButtonName {
  case x
  case b
  case y
  case a
}

public enum BPadButtonStatus {
  case pressed
  case released
}

public struct BPadButtonEvent {
  public var button: BPadButtonName
  public var state: BPadButtonStatus
}

public struct BPad: View {
  // For debug use
  public let printButtonEvent: Bool

  var buttonSize: CGSize
  var panelSize: CGSize
  var offset: CGFloat
  
  public init(printButtonEvent: Bool = false, buttonSize: CGSize = CGSize(width: 80, height: 80), panelSize: CGSize = CGSize(width: 200, height: 200), offset: CGFloat = 15) {
    // Debug
    self.printButtonEvent = printButtonEvent
    
    self.buttonSize = buttonSize
    self.panelSize = panelSize
    self.offset = offset
  }

  public var body: some View {
    ZStack {
      Text("X")
        .modifier(BPadButtonModifier(buttonSize: buttonSize, color: Color.blue, actionTouchDown: {
          if self.printButtonEvent {
            print("Action Touch Down: X")
          }
          NotificationCenter.default.post(name: BPadNotification.BPadButtonStatusChanged, object: BPadButtonEvent(button: .x, state: .pressed))
        }, actionTouchUp: {
          if self.printButtonEvent {
            print("Action Touch Up: X")
          }
          NotificationCenter.default.post(name: BPadNotification.BPadButtonStatusChanged, object: BPadButtonEvent(button: .x, state: .released))
        }))
        .offset(x: 0, y: -buttonSize.height + offset)
      
      Text("B")
        .modifier(BPadButtonModifier(buttonSize: buttonSize, color: Color.yellow, actionTouchDown: {
          if self.printButtonEvent {
          print("Action Touch Down: B")
          }
          NotificationCenter.default.post(name: BPadNotification.BPadButtonStatusChanged, object: BPadButtonEvent(button: .b, state: .pressed))
        }, actionTouchUp: {
          if self.printButtonEvent {
          print("Action Touch Up: B")
          }
          NotificationCenter.default.post(name: BPadNotification.BPadButtonStatusChanged, object: BPadButtonEvent(button: .b, state: .released))
        }))
        .offset(x: 0, y: buttonSize.height - offset)

      Text("Y")
        .modifier(BPadButtonModifier(buttonSize: buttonSize, color: Color.green, actionTouchDown: {
          if self.printButtonEvent {
          print("Action Touch Down: Y")
          }
          NotificationCenter.default.post(name: BPadNotification.BPadButtonStatusChanged, object: BPadButtonEvent(button: .y, state: .pressed))
        }, actionTouchUp: {
          if self.printButtonEvent {
          print("Action Touch Up: Y")
          }
          NotificationCenter.default.post(name: BPadNotification.BPadButtonStatusChanged, object: BPadButtonEvent(button: .y, state: .released))
        }))
        .offset(x: -buttonSize.width + offset, y: 0)
      
      Text("A")
        .modifier(BPadButtonModifier(buttonSize: buttonSize, color: Color.red, actionTouchDown: {
          if self.printButtonEvent {
          print("Action Touch Down: A")
          }
          NotificationCenter.default.post(name: BPadNotification.BPadButtonStatusChanged, object: BPadButtonEvent(button: .a, state: .pressed))
        }, actionTouchUp: {
          if self.printButtonEvent {
          print("Action Touch Up: A")
          }
          NotificationCenter.default.post(name: BPadNotification.BPadButtonStatusChanged, object: BPadButtonEvent(button: .a, state: .released))
        }))
        .offset(x: buttonSize.width - offset, y: 0)
    }.frame(width: panelSize.width, height: panelSize.height, alignment: Alignment.center)
  }
}

#if DEBUG
struct BPad_Previews: PreviewProvider {
  static var previews: some View {
    BPad()
  }
}
#endif
