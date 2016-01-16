//
//  DragImage.swift
//  LittleMonster
//
//  Created by Ronald Hernandez on 1/16/16.
//  Copyright © 2016 HardCoders. All rights reserved.
//

import UIKit

class DragImage: UIImageView {

    var originalPosition: CGPoint!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //set the original position.
    //passes a set of touches

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center


    }

    //get the first object of the touches set.
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        if let touch = touches.first {
            //grab the position of the touch in the super view.
            //move the center to the wherever you're dragging the object. 
            let position = touch.locationInView(self.superview)
            self.center = CGPointMake(position.x, position.y)
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

        self.center = originalPosition
        
    }
}
