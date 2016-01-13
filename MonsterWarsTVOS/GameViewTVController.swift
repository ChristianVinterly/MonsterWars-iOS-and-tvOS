//
//  GameViewController.swift
//  MonsterWarsTVOS
//
//  Created by Christian Lysne on 13/01/16.
//  Copyright (c) 2016 Razeware LLC. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewTVController: UIViewController {
    
    @IBOutlet weak var quirkButton: FocusButton!
    @IBOutlet weak var zapButton: FocusButton!
    @IBOutlet weak var munchButton: FocusButton!
    
    var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleButton(quirkButton)
        styleButton(zapButton)
        styleButton(munchButton)
        
        let aspectRatio = view.bounds.size.width / view.bounds.size.height
        
        self.scene =
        GameScene(size:CGSize(width: 640 * aspectRatio, height: 640))
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        self.scene.scaleMode = .AspectFill
        skView.presentScene(self.scene)
    }
    
    func styleButton(button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blackColor().CGColor
        button.layer.cornerRadius = 10
    }

    @IBAction func quirkButtonTapped(sender: AnyObject) {
        self.scene.quirkPressed()
    }
    
    @IBAction func zapButtonTapped(sender: AnyObject) {
        self.scene.zapPressed()
    }
    
    @IBAction func munchButtonTapped(sender: AnyObject) {
        self.scene.munchPressed()
    }
}
