//
//  ViewController.swift
//  SynchronizedAnimation
//
//  Created by David Livadaru on 03/08/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let gpuTimer = CADisplayLink(target: self, selector: #selector(gpuTimerTick))

        gpuTimer.add(to: .main, forMode: .commonModes)

//        let timer = Timer.scheduledTimer(timeInterval: 1.0 / 60.0, target: self, selector: #selector(gpuTimerTick), userInfo: nil, repeats: true)
//        timer.fire()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { 
            UIView.animate(withDuration: 3, animations: {
                self.label.alpha = 0
            }, completion: { _ in
                gpuTimer.invalidate()
//                timer.invalidate()
            })
        }
    }

    @objc func gpuTimerTick() {
        if let presentationLayer = label.layer.presentation() {
            let lineSpacing = 50 * (1 - presentationLayer.opacity)
            print(lineSpacing)
            var attributes: [NSAttributedStringKey : Any] = [:]
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = CGFloat(lineSpacing)
            attributes[.paragraphStyle] = paragraphStyle
            let attributedText = NSAttributedString(string: label.text!, attributes: attributes)
            label.attributedText = attributedText
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

