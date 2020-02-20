//
//  GradientView.swift
//  CALayerDemo
//
//  Created by Andrey Kovalenko on 20.02.2020.
//  Copyright © 2020 Andrey Kovalenko. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    private var size = CGSize()
    @IBInspectable var cornerRadiiSize: CGFloat = 0 {
        didSet {
            size = CGSize(width: cornerRadiiSize, height: cornerRadiiSize)
        }
    }
    
    func gradientLayer() {
            let gradientLayer = CAGradientLayer()
            self.layer.insertSublayer(gradientLayer, at: 0)
            
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.colors = [UIColor.blue.cgColor,
                                    UIColor.red.cgColor]
            gradientLayer.frame = CGRect(x: 0, y: 0,
                                         width: self.bounds.size.width,
                                         height: self.bounds.size.height)
        }
    
    func shapeLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds,
                                       byRoundingCorners: [.topLeft, .bottomRight],
                                       cornerRadii: size).cgPath
        layer.mask = shapeLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer()
        shapeLayer()
    }
    
    override func prepareForInterfaceBuilder() {
        setNeedsLayout()
    }
}
