//
//  GameScene.swift
//  Flappy
//
//  Created by liusy182 on 19/4/16.
//  Copyright (c) 2016 liusy182. All rights reserved.
//

import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

extension SKPhysicsBody {
    typealias BodyBuilderClosure = (SKPhysicsBody) -> ()
    
    class func rectSize(
        size: CGSize,
        builderClosure: BodyBuilderClosure) -> SKPhysicsBody {
        
        let body = SKPhysicsBody(rectangleOfSize: size)
        builderClosure(body)
        return body
    }
}


class GameScene: SKScene {
    private var screenNode: SKSpriteNode!
    private var actors: [Startable]!
    private var bird: Bird!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        
        screenNode = SKSpriteNode(color: UIColor.clearColor(), size: self.size)
        screenNode.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(screenNode)
        let sky = Background(textureNamed: "sky", duration:60.0).addTo(screenNode, zPosition: 0)
        let city = Background(textureNamed: "city", duration:20.0).addTo(screenNode, zPosition: 1)
        let ground = Background(textureNamed: "ground", duration:5.0).addTo(screenNode, zPosition: 5)
        
        bird = Bird(textureNames: ["bird1.png", "bird2.png"]).addTo(screenNode)
        bird.position = CGPointMake(30.0, 400.0)
        
        let pipes = Pipes(topPipeTexture: "topPipe.png", bottomPipeTexture: "bottomPipe").addTo(screenNode)
        
        actors = [sky, city, ground, bird, pipes]
        
        
        for actor in actors {
            actor.start()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        bird.flap()
    }
    
    override func update(currentTime: CFTimeInterval) {
        bird.update()
    }
}
