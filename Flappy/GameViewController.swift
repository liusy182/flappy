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
        
        createScene()
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
    
    private func createScene() {
        let scene = GameScene.unarchiveFromFile("GameScene")
        if let scene = scene as? GameScene {
            scene.size = skView.frame.size
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFill
            
            scene.onPlayAgainPressed = {[weak self] in
                self?.createScene()
            }
            
            scene.onCancelPressed = {[weak self] in
                self?.dismissViewControllerAnimated(true, completion: nil)
            }
            skView.presentScene(scene)
        }
    }
}
