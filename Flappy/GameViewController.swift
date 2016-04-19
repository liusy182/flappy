//
//  GameViewController.swift
//  Flappy
//
//  Created by liusy182 on 19/4/16.
//  Copyright (c) 2016 liusy182. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    private let skView = SKView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skView.frame = view.bounds
        view.addSubview(skView)
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            scene.size = skView.frame.size
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
