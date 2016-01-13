/*
 * Copyright (c) 2015 Razeware LLC
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var quirkButton: UIButton!
    @IBOutlet weak var zapButton: UIButton!
    @IBOutlet weak var munchButton: UIButton!
    
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
