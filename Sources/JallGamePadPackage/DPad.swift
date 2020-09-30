//
//  DPad.swift
//  
//
//  Created by Joe on 2020/08/26.
//

import SwiftUI

public struct DPadNotification {
  public static let DPadButtonStatusChanged: Notification.Name = Notification.Name("Notification.DPad.Button.Status.Changed")
}

public enum DPadButtonName {
  case up
  case down
  case left
  case right
}

public enum DPadButtonStatus {
  case pressed
  case released
}

public struct DPadButtonEvent {
  public var button: DPadButtonName
  public var state: DPadButtonStatus
}

public struct DPad: View {
  // For debug use
  private let printButtonEvent: Bool
  
  var buttonSize: CGSize
  var panelSize: CGSize
  
  public init(printButtonEvent: Bool = false, buttonSize: CGSize = CGSize(width: 60, height: 60), panelSize: CGSize = CGSize(width: 180, height: 180)) {
    // Debug
    self.printButtonEvent = printButtonEvent
    
    self.buttonSize = buttonSize
    self.panelSize = panelSize
  }

  public var body: some View {
    ZStack {
      Text("▲")
        .modifier(DPadButtonModifier(buttonSize: buttonSize, direction: .up, actionTouchDown: {
          if self.printButtonEvent {
            print("Action Touch Down: ▲")
          }
          NotificationCenter.default.post(name: DPadNotification.DPadButtonStatusChanged, object: DPadButtonEvent(button: .up, state: .pressed))
        }, actionTouchUp: {
          if self.printButtonEvent {
            print("Action Touch Up: ▲")
          }
          NotificationCenter.default.post(name: DPadNotification.DPadButtonStatusChanged, object: DPadButtonEvent(button: .up, state: .released))
        }))
      
      Text("▼")
        .modifier(DPadButtonModifier(buttonSize: buttonSize, direction: .down, actionTouchDown: {
          if self.printButtonEvent {
            print("Action Touch Down: ▼")
          }
          NotificationCenter.default.post(name: DPadNotification.DPadButtonStatusChanged, object: DPadButtonEvent(button: .down, state: .pressed))
        }, actionTouchUp: {
          if self.printButtonEvent {
            print("Action Touch Up: ▼")
          }
          NotificationCenter.default.post(name: DPadNotification.DPadButtonStatusChanged, object: DPadButtonEvent(button: .down, state: .released))
        }))
      
      Text("◀︎")
        .modifier(DPadButtonModifier(buttonSize: buttonSize, direction: .left, actionTouchDown: {
          if self.printButtonEvent {
            print("Action Touch Down: ◀︎")
          }
          NotificationCenter.default.post(name: DPadNotification.DPadButtonStatusChanged, object: DPadButtonEvent(button: .left, state: .pressed))
        }, actionTouchUp: {
          if self.printButtonEvent {
            print("Action Touch Up: ◀︎")
          }
          NotificationCenter.default.post(name: DPadNotification.DPadButtonStatusChanged, object: DPadButtonEvent(button: .left, state: .released))
        }))
      
      Text("▶︎")
        .modifier(DPadButtonModifier(buttonSize: buttonSize, direction: .right, actionTouchDown: {
          if self.printButtonEvent {
            print("Action Touch Down: ▶︎")
          }
          NotificationCenter.default.post(name: DPadNotification.DPadButtonStatusChanged, object: DPadButtonEvent(button: .right, state: .pressed))
        }, actionTouchUp: {
          if self.printButtonEvent {
            print("Action Touch Up: ▶︎")
          }
          NotificationCenter.default.post(name: DPadNotification.DPadButtonStatusChanged, object: DPadButtonEvent(button: .right, state: .released))
        }))
    }.frame(width: panelSize.width, height: panelSize.height, alignment: Alignment.center)
  }
}

#if DEBUG
struct DPad_Previews: PreviewProvider {
  static var previews: some View {
    DPad()
  }
}
#endif
