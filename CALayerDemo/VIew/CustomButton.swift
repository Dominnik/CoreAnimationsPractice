//
//  CustomButton.swift
//  CALayerDemo
//
//  Created by Andrey Kovalenko on 20.02.2020.
//  Copyright © 2020 Andrey Kovalenko. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    var cornerRadii = CGSize()
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
        }
    }
    
    @IBInspectable var color: UIColor = .systemGreen
    
    var path: UIBezierPath?

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        path = UIBezierPath(roundedRect: self.bounds,
                            byRoundingCorners: [.topLeft], cornerRadii: cornerRadii)
        color.setFill()
        path?.fill()
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let path = path {
            return path.contains(point)
        }
        return false
    }
}
