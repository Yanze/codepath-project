//
//  TextFieldLeftPadding.swift
//  TipCalculator
//
//  Created by yanze on 3/3/17.
//  Copyright © 2017 yanzeliu. All rights reserved.
//

import UIKit

class TextFieldRightPadding: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width - 20, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width - 20, height: bounds.height)
    }
}
