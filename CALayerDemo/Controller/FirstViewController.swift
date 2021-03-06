//
//  FirstViewController.swift
//  CALayerDemo
//
//  Created by Andrey Kovalenko on 18.02.2020.
//  Copyright © 2020 Andrey Kovalenko. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, CAAnimationDelegate {
    
    func loadLineConfig(layer: CAShapeLayer, strokeEnd: CGFloat, color: UIColor) {
        layer.lineWidth = 20
        layer.lineCap = .round
        layer.fillColor = nil
        layer.strokeEnd = strokeEnd
        let strokeColor = color.cgColor
        layer.strokeColor = strokeColor
    }
    
    var shapeLayer: CAShapeLayer! {
        didSet {
            loadLineConfig(layer: shapeLayer, strokeEnd: 1, color: #colorLiteral(red: 0.8078431373, green: 0.02745098039, blue: 0.3333333333, alpha: 1))
        }
    }
    
    var overShapeLayer: CAShapeLayer! {
        didSet {
            loadLineConfig(layer: overShapeLayer, strokeEnd: 0, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        }
    }
    
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            let startColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor
            gradientLayer.colors = [startColor, endColor]
        }
    }
    
    @IBOutlet weak var firstImageView: UIImageView! {
        didSet {
            firstImageView.layer.cornerRadius = firstImageView.frame.size.height/2
            firstImageView.layer.masksToBounds = true
            let borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            firstImageView.layer.borderColor = borderColor.cgColor
            firstImageView.layer.borderWidth = 5
        }
    }
    
    @IBOutlet weak var takeMeButton: UIButton! {
        didSet {
            takeMeButton.layer.shadowOffset = CGSize(width: 5, height: 5)
            takeMeButton.layer.shadowOpacity = 0.6
            takeMeButton.layer.shadowRadius = 6
        }
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        configShapeLayer(shapeLayer)
        configShapeLayer(overShapeLayer)
    }
    
    func configShapeLayer(_ shapeLayer: CAShapeLayer) {
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2 + 50))
        path.addLine(to: CGPoint(x: self.view.frame.width / 2 + 100, y: self.view.frame.height / 2 + 50))
        shapeLayer.path = path.cgPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        
        overShapeLayer = CAShapeLayer()
        view.layer.addSublayer(overShapeLayer)
        
    }
    
    
    
    @IBAction func tapMeAction(_ sender: UIButton) {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.fillMode = CAMediaTimingFillMode.both
        animation.isRemovedOnCompletion = true
        
        
        animation.delegate = self
        
        overShapeLayer.add(animation, forKey: nil)
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        performSegue(withIdentifier: "showSecondScreen", sender: self)
    }
    
    
}

