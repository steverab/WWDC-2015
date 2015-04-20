//
//  BorderedButton.swift
//  Stephan Rabanser
//
//  Created by Stephan Rabanser on 20/04/15.
//  Copyright (c) 2015 Stephan Rabanser. All rights reserved.
//

import UIKit

@IBDesignable class BorderedButton: UIView {
    
    typealias buttonTouched = (sender: UIButton) -> ()
    var action: buttonTouched!
    
    var button : UIButton = UIButton(frame: CGRectZero)
    let animationDuration = 0.15

    @IBInspectable var borderColor: UIColor = UIColor.redColor() {
        didSet {
            self.layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.5 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderCornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = borderCornerRadius
        }
    }
    
    @IBInspectable var labelColor: UIColor = UIColor.redColor() {
        didSet {
            self.button.setTitleColor(labelColor, forState: .Normal)
        }
    }
    
    @IBInspectable var labelText: String = "Default" {
        didSet {
            self.button.setTitle(labelText, forState: .Normal)
        }
    }
    
    @IBInspectable var labelFontSize: CGFloat = 11.0 {
        didSet {
            self.button.titleLabel?.font = UIFont.systemFontOfSize(labelFontSize)
        }
    }
    
    required init(coder aDecoder: NSCoder)  {
        super.init(coder: aDecoder)
        self.setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    func setup() {
        userInteractionEnabled = true
        
        button.addTarget(self, action: "onPress:", forControlEvents: .TouchDown)
        button.addTarget(self, action: "onRealPress:", forControlEvents: .TouchUpInside)
        button.addTarget(self, action: "onReset:", forControlEvents: .TouchUpInside)
        button.addTarget(self, action: "onReset:", forControlEvents: .TouchUpOutside)
        button.addTarget(self, action: "onReset:", forControlEvents: .TouchDragExit)
        button.addTarget(self, action: "onReset:", forControlEvents: .TouchCancel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        borderWidth = 0.5
        borderCornerRadius = 5.0
        labelFontSize = 11.0
        
        button.frame = bounds
        button.titleLabel?.textAlignment = .Center
        button.titleLabel?.font =  UIFont(name: "AvenirNext-Medium", size: 15)
        button.backgroundColor = UIColor.clearColor()
        
        addSubview(button)
    }
    
    // MARK: Actions
    
    func onPress(sender: AnyObject) {
        UIView.animateWithDuration(self.animationDuration, animations: {
            self.labelColor = UIColor.whiteColor()
            self.backgroundColor = self.borderColor
        })
    }
    
    func onReset(sender: AnyObject) {
        UIView.animateWithDuration(self.animationDuration, animations: {
            self.labelColor = self.borderColor
            self.backgroundColor = UIColor.clearColor()
        })
    }
    
    func onRealPress(sender: AnyObject) {
        action(sender: sender as! UIButton)
    }
    
}