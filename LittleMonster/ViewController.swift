//
//  ViewController.swift
//  LittleMonster
//
//  Created by Ronald Hernandez on 1/15/16.
//  Copyright © 2016 HardCoders. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var monsterImage: MonsterImage!

    @IBOutlet weak var heart: DragImage!

    @IBOutlet weak var food: DragImage!

    @IBOutlet weak var penalty1: UIImageView!

    @IBOutlet weak var penalty2: UIImageView!

    @IBOutlet weak var penalty3: UIImageView!

    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3

    var penalty = 0

    var timer: NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.penalty1.alpha = DIM_ALPHA
        self.penalty2.alpha = DIM_ALPHA
        self.penalty3.alpha = DIM_ALPHA


        food.dropTarget = monsterImage
        heart.dropTarget = monsterImage

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onTargetDroppedOnCharacter:", name: "onTargetDropped", object: nil)

        starTimer()
    }

    func onTargetDroppedOnCharacter(notification: AnyObject){
        print("Item dropped on character")

    }

    func starTimer(){
        if timer != nil {
            timer.invalidate()
        }

        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }

    func changeGameState(){
        penalty++
        if penalty == 1 {

            penalty1.alpha = OPAQUE
            penalty2.alpha = DIM_ALPHA

        }else if penalty == 2 {
            penalty2.alpha = OPAQUE
            penalty3.alpha = DIM_ALPHA
        }else if penalty >= 3 {
            penalty3.alpha = OPAQUE
        }else {
            penalty1.alpha = DIM_ALPHA
            penalty2.alpha = DIM_ALPHA
            penalty3.alpha = DIM_ALPHA
        }


        if penalty >= MAX_PENALTIES {
            gameOver()
        }
    }

    func gameOver(){
        timer.invalidate()
        monsterImage.playDeathAnimation()
    }

}

