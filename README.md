# ConcentricProgressRingView

[![CI Status](http://img.shields.io/travis/Dan Loewenherz/ConcentricProgressRingView.svg?style=flat)](https://travis-ci.org/Dan Loewenherz/ConcentricProgressRingView)
[![Version](https://img.shields.io/cocoapods/v/ConcentricProgressRingView.svg?style=flat)](http://cocoapods.org/pods/ConcentricProgressRingView)
[![License](https://img.shields.io/cocoapods/l/ConcentricProgressRingView.svg?style=flat)](http://cocoapods.org/pods/ConcentricProgressRingView)
[![Platform](https://img.shields.io/cocoapods/p/ConcentricProgressRingView.svg?style=flat)](http://cocoapods.org/pods/ConcentricProgressRingView)

![](animation.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Usage

At the top of your file, make sure to import "ConcentricProgressRingView"

```swift
import ConcentricProgressRingView
```

Then, instantiate ConcentricProgressRingView in your view controller like so:

```swift
let foregroundColor1 = UIColor.yellowColor()
let backgroundColor1 = UIColor.darkGrayColor()
let foregroundColor2 = UIColor.greenColor()
let backgroundColor2 = UIColor.darkGrayColor()
let initialProgress: CGFloat = 0.2

let bars: [(UIColor, UIColor, CGFloat)] = [
  (foregroundColor1, backgroundColor1, initialProgress),
  (foregroundColor2, backgroundColor2, initialProgress),
]

let width: CGFloat = 18
let barMargin: CGFloat = 2
let maxRadius: CGFloat = 80
ring = ConcentricProgressRingView(frame: view.frame, arcWidth: width, margin: barMargin, maxRadius: maxRadius, bars: bars)

view.backgroundColor = UIColor.blackColor()
view.addSubview(ring)
```

![](example1.png)

You can customize the width, margin, and maxRadius parameters to customize everything to your liking. You can add as many bars as you want. Here's another example with 6 progress bars, with a smaller width, larger marging, and larger max radius:

```swift
let bars: [(UIColor, UIColor, CGFloat)] = [
    (foregroundColor1, backgroundColor1, initialProgress),
    (foregroundColor2, backgroundColor2, initialProgress),
    (foregroundColor1, backgroundColor2, initialProgress),
    (foregroundColor2, backgroundColor2, initialProgress),
    (foregroundColor1, backgroundColor2, initialProgress),
    (foregroundColor2, backgroundColor2, initialProgress),
]

let width: CGFloat = 8
let barMargin: CGFloat = 10
let maxRadius: CGFloat = 120
ring = ConcentricProgressRingView(frame: view.frame, arcWidth: width, margin: barMargin, maxRadius: maxRadius, bars: bars)
```

![](example2.png)

## Requirements

## Installation

ConcentricProgressRingView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ConcentricProgressRingView"
```

## Author

Dan Loewenherz, dan@lionheartsw.com

## License

ConcentricProgressRingView is available under the Apache 2.0 license. See the LICENSE file for more info.
