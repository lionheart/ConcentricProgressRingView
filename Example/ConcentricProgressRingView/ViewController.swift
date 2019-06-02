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
    var progressRingView: ConcentricProgressRingView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let margin: CGFloat = 1
        let radius: CGFloat = 80

        let rings = [
            ProgressRing(color: UIColor(.RGB(232, 11, 45)), backgroundColor: UIColor(.RGB(34, 3, 11))),
            ProgressRing(color: UIColor(.RGB(137, 242, 0)), backgroundColor: UIColor(.RGB(22, 33, 0))),
            ProgressRing(color: UIColor(.RGB(0, 200, 222)), backgroundColor: UIColor(.RGB(0, 30, 28)))
        ]
        progressRingView = try! ConcentricProgressRingView(center: view.center, radius: radius, margin: margin, rings: rings, defaultColor: UIColor.clear, defaultWidth: 18)

        for ring in progressRingView {
            ring.progress = 0.5
        }

        view.backgroundColor = UIColor.black
        view.addSubview(progressRingView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        for (i, _) in progressRingView.enumerated() {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(randomAnimation(_:)), userInfo: i, repeats: true)
        }
    }

    @objc func randomAnimation(_ timer: Timer?) {
        guard let index = timer?.userInfo as? Int else {
            return
        }

        let f = Int64(0.2 * Double(index) * Double(NSEC_PER_SEC))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(f) / Double(NSEC_PER_SEC), execute: {
            self.progressRingView[index].setProgress(CGFloat(drand48()), duration: max(0.4, CGFloat(drand48()))){print("completion")}
        })
    }
}

