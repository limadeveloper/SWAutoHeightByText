//
//  CustomLabel.swift
//  AutoHeightByText
//
//  Created by John Lima on 18/01/17.
//  Copyright © 2017 limadeveloper. All rights reserved.
//

import UIKit

@IBDesignable
class CustomLabel: UILabel {
    
    @IBInspectable var leftEdge: CGFloat = 0.0
    @IBInspectable var rightEdge: CGFloat = 0.0
    @IBInspectable var topEdge: CGFloat = 0.0
    @IBInspectable var bottomEdge: CGFloat = 0.0
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topEdge, left: leftEdge, bottom: bottomEdge, right: rightEdge)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
