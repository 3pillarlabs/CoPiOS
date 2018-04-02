//
//  TextField.swift
//  AutolayLayoutExample
//
//  Created by Dorel Macra on 13/07/2017.
//  Copyright © 2017 3Pillar Global. All rights reserved.
//

import UIKit

@IBDesignable
class TextField: UITextField {

    override var intrinsicContentSize: CGSize {
//        return CGSize(width: UIViewNoIntrinsicMetric, height: font?.lineHeight ?? 0 + 10)
        return CGSize(width: 200, height: font?.lineHeight ?? 0 + 10)

    }

}
