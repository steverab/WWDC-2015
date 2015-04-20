//
//  OutlineView.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 17/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit

enum OutlineViewType {
    case Default
    case First
    case Last
    case NoCircle
}

@IBDesignable
class OutlineView: UIView {
    
    var type: OutlineViewType = .Default {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var contentType: TimelineEntryType = .Personal {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Drawing
    
    override func drawRect(rect: CGRect)
    {
        let ctx = UIGraphicsGetCurrentContext()
        
        let lineWidth: CGFloat = 1.0
        let circleRad: CGFloat = 6.0
        let innerCircleRad: CGFloat = circleRad - 2.0
        let topDist: CGFloat = 15.0
        
        CGContextSetLineWidth(ctx, lineWidth)
        CGContextSetStrokeColorWithColor(ctx, UIColor.outlineColor().CGColor)
        
        if type == .NoCircle {
            CGContextMoveToPoint(ctx, CGRectGetWidth(rect) - circleRad - lineWidth, 0)
            CGContextAddLineToPoint(ctx, CGRectGetWidth(rect) - circleRad - lineWidth, CGRectGetMaxY(rect))
        } else {
            let x: CGFloat = CGRectGetWidth(rect) - circleRad - lineWidth
            let y: CGFloat = topDist + circleRad/2 + lineWidth
            let startAngle: CGFloat = 0.0
            let endAngle: CGFloat = CGFloat(M_PI) * 2
            
            if contentType == TimelineEntryType.Personal {
                CGContextSetFillColorWithColor(ctx, UIColor.personalColor().CGColor)
            } else if contentType == TimelineEntryType.Education {
                CGContextSetFillColorWithColor(ctx, UIColor.educationColor().CGColor)
            } else if contentType == TimelineEntryType.Development {
                CGContextSetFillColorWithColor(ctx, UIColor.developmentColor().CGColor)
            } else {
                CGContextSetFillColorWithColor(ctx, UIColor.outlineColor().CGColor)
            }
            
            CGContextAddArc(ctx,x,y,innerCircleRad,startAngle,endAngle,1)
            CGContextFillPath(ctx)
            
            CGContextAddArc(ctx,x,y,circleRad,startAngle,endAngle,1)
            
            CGContextMoveToPoint(ctx, CGRectGetWidth(rect) - circleRad - lineWidth, 0.0)
            CGContextAddLineToPoint(ctx, CGRectGetWidth(rect) - circleRad - lineWidth, topDist - 2 * lineWidth)
            
            CGContextMoveToPoint(ctx, 0.0, topDist + circleRad/2 + lineWidth)
            CGContextAddLineToPoint(ctx, CGRectGetWidth(rect) - 2 * circleRad - lineWidth, topDist + circleRad/2 + lineWidth)
            
            if type != .Last {
                CGContextMoveToPoint(ctx, CGRectGetWidth(rect) - circleRad - lineWidth, CGRectGetMaxY(rect))
                CGContextAddLineToPoint(ctx, CGRectGetWidth(rect) - circleRad - lineWidth, topDist - 2 * lineWidth + 2 * circleRad)
            }
        }
        
        CGContextStrokePath(ctx)
    }
    
}
