//
//  ViewController.swift
//  LittleMonster
//
//  Created by Ronald Hernandez on 1/15/16.
//  Copyright © 2016 HardCoders. All rights reserved.
//

import UIKit
import AVFoundation

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

    var monsterHappy = false

    var currentItem: UInt32 = 0

    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.penalty1.alpha = DIM_ALPHA
        self.penalty2.alpha = DIM_ALPHA
        self.penalty3.alpha = DIM_ALPHA


        food.dropTarget = monsterImage
        heart.dropTarget = monsterImage

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onTargetDroppedOnCharacter:", name: "onTargetDropped", object: nil)

        starTimer()

        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try  sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
           try  sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))

            musicPlayer.prepareToPlay()
            musicPlayer.play()

            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()


        }catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func onTargetDroppedOnCharacter(notification: AnyObject){
      monsterHappy = true
      starTimer()
      food.alpha = DIM_ALPHA
        heart.alpha = DIM_ALPHA
        food.userInteractionEnabled = false
        heart.userInteractionEnabled = false

        if currentItem == 0 {
            sfxHeart.play()
        }else{
            sfxBite.play()
        }

    }

    func starTimer(){
        if timer != nil {
            timer.invalidate()
        }

        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }

    func changeGameState(){

        if !monsterHappy {

        penalty++
            sfxSkull.play()
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
        }else{

            let random = arc4random_uniform(2) // you get a 0 or 1

            if random == 0 {
                food.alpha = DIM_ALPHA
                food.userInteractionEnabled = false
                heart.alpha = OPAQUE
                heart.userInteractionEnabled = true

            }else{

                heart.alpha = DIM_ALPHA
                heart.userInteractionEnabled = false

                food.alpha = OPAQUE
                food.userInteractionEnabled = true

            }
             currentItem = random

            monsterHappy = false
        }

    }

    func gameOver(){
        timer.invalidate()
        sfxDeath.play()
        monsterImage.playDeathAnimation()
    }

}

