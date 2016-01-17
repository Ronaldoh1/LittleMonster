//
//  MonsterImage.swift
//  LittleMonster
//
//  Created by Ronald Hernandez on 1/16/16.
//  Copyright © 2016 HardCoders. All rights reserved.
//

import UIKit

class MonsterImage: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        playIdleAnimation()
    }

    func playIdleAnimation(){

        //when it's not animating

        self.image = UIImage(named: "idle1.png")

        var imageArray = [UIImage]()

        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "idle\(x).png")

            imageArray.append(img!)
        }

        self.animationImages = imageArray

        self.animationDuration = 0.8

        self.animationRepeatCount = 0
        
        self.startAnimating()
    }

    func playDeathAnimation(){

        self.image = UIImage(named: "dead5.png")

        self.animationImages = nil

        var imageArray = [UIImage]()

        for var x = 1; x <= 5; x++ {
            let img = UIImage(named: "dead\(x).png")

            imageArray.append(img!)
        }

        self.animationImages = imageArray

        self.animationDuration = 0.8

        self.animationRepeatCount = 1
        
        self.startAnimating()
    }

}
