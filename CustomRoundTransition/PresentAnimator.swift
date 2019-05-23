//
//  PresentAnimator.swift
//  CustomRoundTransition
//
//  Created by Stephen Bassett on 5/23/19.
//  Copyright © 2019 Stephen Bassett. All rights reserved.
//

import UIKit

class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var buttonFrame: CGRect
//    var transitionContext: UIViewControllerContextTransitioning?
    
    init(buttonFrame: CGRect) {
        self.buttonFrame = buttonFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: .from) as! ViewController
        guard let destinationController = transitionContext.viewController(forKey: .to),
            let destinationView = destinationController.view else { return }
        
        transitionContext.containerView.addSubview(fromViewController.view)
        transitionContext.containerView.addSubview(destinationView)
//        self.transitionContext = transitionContext
        
        let maskPath = UIBezierPath(ovalIn: buttonFrame)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = destinationView.frame
        maskLayer.path = maskPath.cgPath
        destinationController.view.layer.mask = maskLayer
        
        let screenHeight = UIScreen.main.bounds.height
        let screenYHeight = screenHeight - buttonFrame.midX
        let buttonYHeight = buttonFrame.height / 2
        let scaleFactor = screenYHeight / buttonYHeight
        let endFrameWidth = scaleFactor * buttonFrame.width
        let endFrameHeight = endFrameWidth
        let endFrameXPosition = destinationView.frame.midX - (endFrameWidth / 2)
        let endFrameYPosition = CGFloat(0)
        let endFrame = CGRect(x: endFrameXPosition, y: endFrameYPosition, width: endFrameWidth, height: endFrameHeight)
        let bigCirclePath = UIBezierPath(ovalIn: endFrame)
        let pathAnimation = CABasicAnimation(keyPath: "path")
        
        pathAnimation.setValue(transitionContext, forKey: "transitionContext")
        pathAnimation.setValue(destinationController, forKey: "destinationVC")
        pathAnimation.delegate = self
        pathAnimation.fromValue = maskPath.cgPath
        pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        pathAnimation.toValue = bigCirclePath.cgPath
        
        maskLayer.path = bigCirclePath.cgPath
        maskLayer.add(pathAnimation, forKey: nil)
        
    }
    
}

extension PresentAnimator: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let transitionContext = anim.value(forKey: "transitionContext") as? UIViewControllerContextTransitioning,
            let destinationVC = anim.value(forKey: "destinationVC") as? NewViewController,
            flag {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            destinationVC.view.layer.mask?.removeFromSuperlayer()
        }
//        if let _transitionContext = self.transitionContext, flag {
//            _transitionContext.completeTransition(!_transitionContext.transitionWasCancelled)
//        }
    }
    
}
