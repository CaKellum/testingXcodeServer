//
//  UIBorderedButton.swift
//  Speedometer
//
//  Created by Mark DiFranco on 4/4/17.
//  Copyright © 2017 Mark DiFranco. All rights reserved.
//

import UIKit

@IBDesignable
class UIBorderedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = titleLabel?.textColor.cgColor
    }

    override func prepareForInterfaceBuilder() {
        commonInit()
    }
}
