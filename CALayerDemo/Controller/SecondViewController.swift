//
//  SecondViewController.swift
//  CALayerDemo
//
//  Created by Andrey Kovalenko on 18.02.2020.
//  Copyright © 2020 Andrey Kovalenko. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, CAAnimationDelegate {

    var roundShapeLayer: CAShapeLayer! {
        didSet {
            roundShapeLayer.lineWidth = 10
            roundShapeLayer.lineCap = .round
            roundShapeLayer.fillColor = nil
            roundShapeLayer.strokeEnd = 1
            let strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
            roundShapeLayer.strokeColor = strokeColor
        }
    }
    
    var overRoundShapeLayer: CAShapeLayer! {
        didSet {
            overRoundShapeLayer.lineWidth = 10
            overRoundShapeLayer.lineCap = .round
            overRoundShapeLayer.fillColor = nil
            overRoundShapeLayer.strokeEnd = 1
            let strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            overRoundShapeLayer.strokeColor = strokeColor
        }
    }
    
    @IBOutlet weak var secondImageView: UIImageView! {
        didSet {
            secondImageView.layer.cornerRadius = secondImageView.frame.size.height/2
            secondImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var goBackButton: UIButton! {
        didSet {
            goBackButton.layer.shadowOffset = CGSize(width: 5, height: 5)
            goBackButton.layer.shadowOpacity = 0.6
            goBackButton.layer.shadowRadius = 6
            goBackButton.layer.shadowColor = UIColor.darkGray.cgColor
        }
    }
    
    func configShapeLayer(_ shapeLayer: CAShapeLayer) {
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 + 85),
                    radius: 100,
                    startAngle: 0.0,
                    endAngle: 0.001,
                    clockwise: false)
        shapeLayer.path = path.cgPath
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        configShapeLayer(roundShapeLayer)
        configShapeLayer(overRoundShapeLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundShapeLayer = CAShapeLayer()
        view.layer.addSublayer(roundShapeLayer)
        
        overRoundShapeLayer = CAShapeLayer()
        view.layer.addSublayer(overRoundShapeLayer)
    }

    @IBAction func goBackAction(_ sender: UIButton) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = -0.001
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.fillMode = CAMediaTimingFillMode.both
        animation.isRemovedOnCompletion = false
        
        animation.delegate = self
        
        overRoundShapeLayer.add(animation, forKey: nil)
        
        delay(2) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
