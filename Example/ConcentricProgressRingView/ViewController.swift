//
//  ViewController.swift
//  ConcentricProgressRingView
//
//  Created by Dan Loewenherz on 06/30/2016.
//  Copyright (c) 2016 Dan Loewenherz. All rights reserved.
//

import UIKit
import ConcentricProgressRingView
import LionheartExtensions

class ViewController: UIViewController {
    var ring: ConcentricProgressRingView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let margin: CGFloat = 2
        let radius: CGFloat = 120

        let rings = [
            ProgressRing(color: UIColor(.RGB(160, 255, 0)), backgroundColor: UIColor(.RGB(44, 66, 4)), width: 40, progress: 0.2),
            ProgressRing(color: UIColor(.RGB(255, 211, 0)), backgroundColor: UIColor(.RGB(85, 78, 0)), width: 20, progress: 0.4),
            ProgressRing(color: UIColor(.RGB(255, 28, 93)), backgroundColor: UIColor(.RGB(52, 7, 18)), width: 30, progress: 0.6)
        ]
        ring = ConcentricProgressRingView(center: view.center, radius: radius, margin: margin, rings: rings)

        view.backgroundColor = UIColor.blackColor()
        view.addSubview(ring)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        for (i, _) in ring.arcs.enumerate() {
            NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(randomAnimation), userInfo: i, repeats: true)
        }
    }

    func randomAnimation(timer: NSTimer?) {
        guard let index = timer?.userInfo as? Int else {
            return
        }

        self.ring[index].setProgress(CGFloat(drand48()), duration: 2)
    }
}

