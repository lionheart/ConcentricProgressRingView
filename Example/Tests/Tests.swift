// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import ConcentricProgressRingView

class ConcentricProgressRingSpec: XCTestCase {
    let arcBars: [(UIColor, UIColor, CGFloat)] = [
        (UIColor(red:0.626,  green:1,  blue:0.003, alpha:1), UIColor(red:0.174,  green:0.259,  blue:0.016, alpha:1), 0.2),
        (UIColor(red:1,  green:0.828,  blue:0.012, alpha:1), UIColor(red:0.334,  green:0.306,  blue:0.002, alpha:1), 0.4),
        (UIColor(red:1,  green:0.11,  blue:0.366, alpha:1), UIColor(red:0.205,  green:0.035,  blue:0.073, alpha:1), 0.6)
    ]

    let width: CGFloat = 18
    let margin: CGFloat = 2
    let maxRadius: CGFloat = 80

    func testConcentricProgressRingViewArcs() {
        let view = ConcentricProgressRingView(arcWidth: width, margin: margin, maxRadius: maxRadius, bars: arcBars)

        expect(view.arcs.count) == 3
        expect(view.circles.count) == 3
        expect(view[0]) == view.arcs.first
        expect(view[2]) == view.arcs.last
    }

    func testConcentricProgressRingViewCircles() {
        let view = ConcentricProgressRingView(arcWidth: width, margin: margin, maxRadius: maxRadius, bars: arcBars)

        expect(view.arcs.count) == 3
        expect(view.circles.count) == 3
        expect(view[0]) == view.arcs.first
        expect(view[2]) == view.arcs.last
    }
}
