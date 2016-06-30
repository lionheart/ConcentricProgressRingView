//
//  ViewController.swift
//  ConcentricProgressRingView
//
//  Created by Dan Loewenherz on 06/30/2016.
//  Copyright (c) 2016 Dan Loewenherz. All rights reserved.
//

import UIKit
import ConcentricProgressRingView

class ViewController: UIViewController {
    var ring: ConcentricProgressRingView!

    override func viewDidLoad() {
        super.viewDidLoad()


        let arcBars: [(UIColor, UIColor, CGFloat)] = [
            (UIColor(red:0.626,  green:1,  blue:0.003, alpha:1), UIColor(red:0.174,  green:0.259,  blue:0.016, alpha:1), 0.2),
            (UIColor(red:1,  green:0.828,  blue:0.012, alpha:1), UIColor(red:0.334,  green:0.306,  blue:0.002, alpha:1), 0.4),
            (UIColor(red:1,  green:0.11,  blue:0.366, alpha:1), UIColor(red:0.205,  green:0.035,  blue:0.073, alpha:1), 0.6)
        ]

        let width: CGFloat = 18
        let margin: CGFloat = 2
        let maxRadius: CGFloat = 80
        ring = ConcentricProgressRingView(frame: view.frame, arcWidth: width, margin: margin, maxRadius: maxRadius, bars: arcBars)

        view.backgroundColor = UIColor.blackColor()
        view.addSubview(ring)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        for (i, _) in ring.arcs.enumerate() {
//            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(randomAnimation), userInfo: i, repeats: true)
        }
    }

    func randomAnimation(timer: NSTimer?) {
        guard let index = timer?.userInfo as? Int else {
            return
        }

        let f = Int64(0.2 * Double(index)) * Int64(NSEC_PER_SEC)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, f), dispatch_get_main_queue(), {
            self.ring[index].set(CGFloat(drand48()), duration: max(0.4, CGFloat(0.5)))
        })
    }
}

