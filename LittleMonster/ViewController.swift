//
//  ViewController.swift
//  LittleMonster
//
//  Created by Ronald Hernandez on 1/15/16.
//  Copyright © 2016 HardCoders. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var monsterImage: UIImageView!

    @IBOutlet weak var heart: DragImage!

    @IBOutlet weak var food: DragImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        var imageArray = [UIImage]()

        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "idle\(x).png")

            imageArray.append(img!)
        }

        monsterImage.animationImages = imageArray

        monsterImage.animationDuration = 0.8

        monsterImage.animationRepeatCount = 0

        monsterImage.startAnimating()

    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
    }



}

