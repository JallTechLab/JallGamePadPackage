# JallGamePad

## The story

In occasion we try to develop on Unity and needed a controller to control the game on iPad via BLE. So we decided to make a virtual controller on iOS, which simplify our testing process, on both controlling the character, and for debugging the bluetooth connection.

## Supported version

The package is written in SwiftUI.
It supports iOS 13.0+.
(not tested) It should also supports MacOS 10.15+.

## What is provided in this package

A simple DPad (direction) and BPad (A,B,X,Y).

## How to use

### Example on showing the UI (SwiftUI)

```swift
import JallGamePad

struct ContentView: View {
  var body: some View {
    HStack {
      DPad()
      Spacer()
      BPad()
    }
  }
}

```

### Example listing to button event

```swift
import JallGamePad

struct ContentView: View {
  let dPadButtonNotification = NotificationCenter.default.publisher(for: DPadNotification.DPadButtonStatusChanged)
    .makeConnectable()
    .autoconnect()
  let bPadButtonNotification = NotificationCenter.default.publisher(for: BPadNotification.BPadButtonStatusChanged)
    .makeConnectable()
    .autoconnect()

  var body: some View {
    HStack {
      DPad()
        .onReceive(dPadButtonNotification) { (output) in
            guard let dPadButtonEvent = output.object as? DPadButtonEvent else { return }

            if dPadButtonEvent.state == .pressed {
              switch dPadButtonEvent.button {
              case .up:
                print("Up button pressed down")
              case .down:
                print("Down button pressed down")
              case .left:
                print("Left button pressed down")
              case .right:
                print("Right button pressed down")
              }
            }
        }
      Spacer()
      BPad().onReceive(bPadButtonNotification) { (output) in
            guard let bPadButtonEvent = output.object as? BPadButtonEvent else { return }

            if bPadButtonEvent.state == .pressed {
              switch bPadButtonEvent.button {
              case .x:
                print("X button pressed down")
              case .b:
                print("B button pressed down")
              case .y:
                print("Y button pressed down")
              case .a:
                print("A button pressed down")
              }
            }
        }
    }
  }
}

```

### Button events

There are 2 button events (`.pressed` & `.released`).
Check `state` of `BPadButtonEvent` to identify the current button state.

### Adjusting the UI

**_To be honest I didn't make a lot of customizations for the framework as it is for personal use only_**

For `DPad` & `BPad`, you may modify the `buttonSize: CGSize` & `panelSize: CGSize` when init. Additionally, for `BPad`, you may also adjust the button `offset: CGFloat` from center.

```swift

DPad(buttonSize: CGSize(width: 60, height: 60), panelSize: CGSize(width: 180, height: 180))
BPad(buttonSize: CGSize(width: 80, height: 80), panelSize: CGSize(width: 180, height: 180), offset: 15)

```

### Debuggin the button event

Both `DPad` & `Bpad` has the `printButtonEvent: Bool` property, set it to true to print the debug message when button event changed.

```swift

DPad(printButtonEvent: true)

// Example message printing in console:
// Action Touch Down: ▲
// Action Touch Up: ▲

```
