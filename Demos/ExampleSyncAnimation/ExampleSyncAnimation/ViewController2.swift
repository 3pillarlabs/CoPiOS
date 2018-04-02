//
//  ViewController2.swift
//  ExampleSyncAnimation
//
//  Created by David Livadaru on 17/08/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var verticalCenter: NSLayoutConstraint!

    weak var delegate: ActionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prevButtonDidTouchUpInside(_ sender: Any) {
        delegate?.didTapButton(viewController: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
