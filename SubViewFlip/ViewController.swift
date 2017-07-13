//
//  ViewController.swift
//  SubViewFlip
//
//  Created by ju on 2017/7/13.
//  Copyright © 2017年 ju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var naviView: UIView = {
        let nview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
        nview.backgroundColor = UIColor.white
        nview.alpha = 0.5
        return nview
    }()
    
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var redView: UIView!
    
    @IBAction func tapForRedView(_ sender: UITapGestureRecognizer) {
        print("red view")
        
        getFlipDirection(withGesture: sender)
        transitionAction(self)
    }
    
    @IBAction func tapForYellowView(_ sender: UITapGestureRecognizer) {
        print("yellow view")
        
        getFlipDirection(withGesture: sender)
        transitionAction(self)
    }
    
    private func getFlipDirection(withGesture gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view)
        let leftRealm = gesture.view!.bounds.width/2
        direction = point.x < leftRealm ? .transitionFlipFromRight : .transitionFlipFromLeft
    }
    
    private var transition = false
    private let duration: TimeInterval = 0.7
    private var direction: UIViewAnimationOptions = .transitionFlipFromLeft
    
    @IBAction func transitionAction(_ sender: Any) {
        transition = !transition
        
        let firstView: UIView! = transition ? redView : yellowView
        let secondView: UIView! = firstView == yellowView ? redView : yellowView
        
        UIView.transition(with: firstView,
                          duration: duration,
                          options: direction,
                          animations: {
                            firstView.alpha = 0.0
        }, completion: nil)
        
        UIView.transition(with: secondView,
                          duration: duration,
                          options: direction,
                          animations: {
                            secondView.alpha = 1.0
        }, completion: nil)
    }
}



@IBDesignable
class CornerShadowView: UIView {
    @IBInspectable
    var cornerRadius: CGFloat = 15 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat = 1 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float = 0.9 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor = UIColor.black {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable
    var fillColor: UIColor = UIColor.black {
        didSet {
            layoutIfNeeded()
        }
    }
    
    private var shadowLayer: CAShapeLayer!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.cornerRadius = cornerRadius
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            layer.insertSublayer(shadowLayer, at: 0)
        }
        
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = shadowOffset
        shadowLayer.shadowRadius = shadowRadius
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.shadowPath = shadowLayer.path
    }
}
