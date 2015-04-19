//
//  AvatarView.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 19/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
class AvatarView: UIView {
    
    @IBInspectable var image: UIImage?
    
    var action: dispatch_block_t?
    
    let scaleAnimationDuration = 0.5
    let scaleAnimationSpringDamping: CGFloat = 0.3
    let scaleAnimationSpringVelocity: CGFloat = 0.5
    let scaleAnimationOptions = UIViewAnimationOptions.CurveEaseInOut | UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.AllowAnimatedContent
    
    // MARK: - Touch handling
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        executeInScaleAnimation()
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        executeOutScaleAnimation()
        if let action = action {
            action()
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        executeOutScaleAnimation()
    }
    
    func executeInScaleAnimation() {
        UIView.animateWithDuration(scaleAnimationDuration, delay: 0.0, usingSpringWithDamping: scaleAnimationSpringDamping, initialSpringVelocity: scaleAnimationSpringVelocity, options: scaleAnimationOptions, animations: ({
            self.transform = CGAffineTransformMakeScale(0.9, 0.9)
        }), completion: nil)
    }
    
    func executeOutScaleAnimation() {
        UIView.animateWithDuration(scaleAnimationDuration, delay: 0.0, usingSpringWithDamping: scaleAnimationSpringDamping, initialSpringVelocity: scaleAnimationSpringVelocity, options: scaleAnimationOptions, animations: ({
            self.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }), completion: nil)
    }
    
    // MARK: - Drawing
    
    override func drawRect(rect: CGRect) {
        let lineWidth: CGFloat = 2.0
        
        let circlePath = UIBezierPath(roundedRect: CGRectMake(lineWidth, lineWidth, rect.size.width - 2 * lineWidth, rect.size.height - 2 * lineWidth), cornerRadius: rect.width/2.0)
        circlePath.lineWidth = lineWidth
        UIColor.outlineColor().setStroke()
        circlePath.stroke()
        circlePath.addClip()
        image?.drawInRect(CGRectMake(lineWidth, lineWidth, rect.size.width - 2 * lineWidth, rect.size.height - 2 * lineWidth))
    }
}