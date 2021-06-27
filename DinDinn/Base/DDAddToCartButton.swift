//
//  DDAddToCartButton.swift
//  DinDinn
//
//  Created by SanjayPathak on 25/06/21.
//

import UIKit

class DDAddToCartButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .systemGreen : .black
        }
    }
}
