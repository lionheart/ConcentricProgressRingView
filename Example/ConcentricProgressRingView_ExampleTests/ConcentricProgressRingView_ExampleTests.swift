//
//  ConcentricProgressRingView_ExampleTests.swift
//  ConcentricProgressRingView_ExampleTests
//
//  Created by Daniel Loewenherz on 11/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

// https://github.com/Quick/Quick

import Quick
import Nimble
import LionheartExtensions
@testable import ConcentricProgressRingView

class ConcentricProgressRingSpec: XCTestCase {
    static let width: CGFloat = 18
    static let margin: CGFloat = 2
    static let radius: CGFloat = 80

    static let bars: [ProgressRing] = [
        ProgressRing(color: UIColor(.RGB(160, 255, 0)), backgroundColor: UIColor(.RGB(44, 66, 4)), width: width),
        ProgressRing(color: UIColor(.RGB(255, 211, 0)), backgroundColor: UIColor(.RGB(85, 78, 0)), width: width),
        ProgressRing(color: UIColor(.RGB(255, 28, 93)), backgroundColor: UIColor(.RGB(52, 0, 19)), width: width),
        ]

    func testConcentricProgressRingViewArcs() {
        let view = ConcentricProgressRingView(center: CGPoint.zero, radius: ConcentricProgressRingSpec.radius, margin: ConcentricProgressRingSpec.margin, rings: ConcentricProgressRingSpec.bars)

        expect(view.arcs.count) == 3
        expect(view.circles.count) == 3
        expect(view[0]) == view.arcs.first
        expect(view[2]) == view.arcs.last
    }

    func testConcentricProgressRingViewCircles() {
        let view = ConcentricProgressRingView(center: CGPoint.zero, radius: ConcentricProgressRingSpec.radius, margin: ConcentricProgressRingSpec.margin, rings: ConcentricProgressRingSpec.bars)

        expect(view.arcs.count) == 3
        expect(view.circles.count) == 3
        expect(view[0]) == view.arcs.first
        expect(view[2]) == view.arcs.last
    }
}

