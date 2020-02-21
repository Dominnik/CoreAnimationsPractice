//
//  SecondViewController.swift
//  CALayerDemo
//
//  Created by Andrey Kovalenko on 18.02.2020.
//  Copyright © 2020 Andrey Kovalenko. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, CAAnimationDelegate {
    
//    private var replicatorLayer: CAReplicatorLayer!
//    private var sourceLayer: CALayer!

    func roundLoadLineConfig(shapeLayer: CAShapeLayer, color: UIColor) {
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = nil
        shapeLayer.strokeEnd = 1
        let strokeColor = color.cgColor
        shapeLayer.strokeColor = strokeColor
    }
    
    var roundShapeLayer: CAShapeLayer! {
        didSet {
            roundLoadLineConfig(shapeLayer: roundShapeLayer, color: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        }
    }
    
    var overRoundShapeLayer: CAShapeLayer! {
        didSet {
            roundLoadLineConfig(shapeLayer: overRoundShapeLayer, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        }
    }
    @IBOutlet weak var indicatorView: UIView!
    
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
        path.addArc(withCenter: CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 - 145),
                    radius: 110,
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
   /*
    override func viewWillLayoutSubviews() {
        replicatorLayer.frame = self.view.bounds
        replicatorLayer.position = self.view.center
        
        sourceLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 40)
        sourceLayer.backgroundColor = UIColor.white.cgColor
        sourceLayer.position = self.view.center
        sourceLayer.anchorPoint = CGPoint(x: 0, y: 5)
    }
    
    func startAnimation(delay: TimeInterval, replicates: Int) {
        
        replicatorLayer.instanceCount = replicates
        let angle = CGFloat(2.0 * CGFloat.pi) / CGFloat(replicates)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        
        replicatorLayer.instanceDelay = delay
        
        sourceLayer.opacity = 0
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = Double(replicates) * delay
        opacityAnimation.repeatCount = Float.infinity
        
        sourceLayer.add(opacityAnimation, forKey: nil)
    }
    */
    override func viewDidLayoutSubviews() {
        
        configShapeLayer(roundShapeLayer)
        configShapeLayer(overRoundShapeLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        replicatorLayer = CAReplicatorLayer()
        sourceLayer = CALayer()
        
        self.view.layer.addSublayer(replicatorLayer)
        replicatorLayer.addSublayer(sourceLayer)
        
        startAnimation(delay: 0.1, replicates: 30)
        */
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
