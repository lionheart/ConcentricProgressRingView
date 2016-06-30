//
//  ConcentricProgressRing.swift
//
//  Created by Daniel Loewenherz on 6/30/16.
//  Copyright © 2016 Lionheart Software, LLC. All rights reserved.
//

import UIKit

public class ProgressRingLayer: CAShapeLayer {
    public var percent: CGFloat? {
        didSet {
            guard let percent = percent else {
                return
            }

            set(percent, duration: 0)
        }
    }

    public init(arcCenter: CGPoint, radius: CGFloat, percent: CGFloat, lineWidth theLineWidth: CGFloat, color: UIColor) {
        super.init()

        let bezier = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(M_PI * 2 - M_PI_2), clockwise: true)
        path = bezier.CGPath
        fillColor = UIColor.clearColor().CGColor
        strokeColor = color.CGColor
        lineWidth = theLineWidth
        lineCap = kCALineCapRound
        strokeStart = 0
        strokeEnd = percent
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(layer: AnyObject) {
        super.init(layer: layer)
    }

    public func set(percent: CGFloat, duration: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = strokeEnd
        animation.toValue = percent
        animation.duration = CFTimeInterval(duration)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        strokeEnd = percent
        addAnimation(animation, forKey: "strokeEnd")
    }
}

public final class CircleLayer: ProgressRingLayer {
    init(center: CGPoint, radius: CGFloat, lineWidth: CGFloat, color: UIColor) {
        super.init(arcCenter: center, radius: radius, percent: 1, lineWidth: lineWidth, color: color)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public final class ConcentricProgressRingView: UIView {
    public var arcs: [ProgressRingLayer] = []
    var circles: [CircleLayer] = []

    public init(arcWidth: CGFloat, margin: CGFloat, maxRadius: CGFloat, bars: [(UIColor, UIColor, CGFloat)]) {
        let frame = CGRectMake(0, 0, maxRadius * 2, maxRadius * 2)
        super.init(frame: frame)

        for (i, (color, background, percent)) in bars.enumerate() {
            let radius = maxRadius - (arcWidth / 2) - CGFloat(i) * (margin + arcWidth)
            let circle = CircleLayer(center: center, radius: radius, lineWidth: arcWidth, color: background)
            let arc = ProgressRingLayer(arcCenter: center, radius: radius, percent: percent, lineWidth: arcWidth, color: color)

            circles.append(circle)
            arcs.append(arc)

            layer.addSublayer(circle)
            layer.addSublayer(arc)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public subscript(index: Int) -> ProgressRingLayer {
        return arcs[index]
    }
}
