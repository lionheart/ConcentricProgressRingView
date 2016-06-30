// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import ConcentricProgressRingView

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        let foregroundColor1 = UIColor.yellowColor()
        let backgroundColor1 = UIColor.darkGrayColor()
        let foregroundColor2 = UIColor.greenColor()
        let backgroundColor2 = UIColor.darkGrayColor()
        let initialProgress: CGFloat = 0.2

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

        let view = ConcentricProgressRingView(arcWidth: width, margin: barMargin, maxRadius: maxRadius, bars: bars)

        expect(view.arcs.count) == 6
        expect(view[0]) == view.arcs.first
    }
}
