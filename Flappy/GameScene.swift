//
//  GameScene.swift
//  Flappy
//
//  Created by liusy182 on 19/4/16.
//  Copyright (c) 2016 liusy182. All rights reserved.
//

import SpriteKit
import SIAlertView

enum BodyType : UInt32 {
    case bird = 0b0001
    case ground = 0b0010
    case pipe = 0b0100
    // need to detect that bird pass the hole so that to increase the score
    case gap = 0b1000
}

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

//extension SKPhysicsBody {
//    typealias BodyBuilderClosure = (SKPhysicsBody) -> ()
//    
//    class func rectSize(
//        size: CGSize,
//        builderClosure: BodyBuilderClosure) -> SKPhysicsBody {
//        
//        let body = SKPhysicsBody(rectangleOfSize: size)
//        builderClosure(body)
//        return body
//    }
//}


class GameScene: SKScene {
    private var screenNode: SKSpriteNode!
    private var actors: [Startable]!
    private var bird: Bird!
    private var score = Score()
    
    var onPlayAgainPressed:(()->Void)!
    var onCancelPressed:(()->Void)!
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        /* Setup your scene here */
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        
        screenNode = SKSpriteNode(color: UIColor.clearColor(), size: self.size)
        screenNode.addChild(bodyTextureName("ground"))
        
        screenNode.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(screenNode)
        
        score.addTo(screenNode)
        
        let sky = Background(textureNamed: "sky", duration:60.0).addTo(screenNode, zPosition: 0)
        let city = Background(textureNamed: "city", duration:20.0).addTo(screenNode, zPosition: 1)
        let ground = Background(textureNamed: "ground", duration:5.0).addTo(screenNode, zPosition: 5)
        
        bird = Bird(textureNames: ["bird1.png", "bird2.png"]).addTo(screenNode)
        bird.position = CGPointMake(30.0, size.height / 2)
        
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

// Contacts
extension GameScene: SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch (contactMask) {
        case BodyType.pipe.rawValue | BodyType.bird.rawValue:
            print("Contact with a pipe")
            bird.pushDown()
        case BodyType.ground.rawValue | BodyType.bird.rawValue:
            print("Contact with ground")
            for actor in actors {
                actor.stop()
            }
            askToPlayAgain()
        default:
            print("unknown contact")
            return
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch (contactMask) {
        case BodyType.gap.rawValue | BodyType.bird.rawValue:
            print("Contact with gap")
            score.increase()
        default:
            return
        }
    }
}

private extension GameScene{
    func bodyTextureName(textureName: String) -> SKNode{
        let image = UIImage(named: textureName)
        let width = image!.size.width
        let height = image!.size.height
        let groundBody = SKNode()
        groundBody.position = CGPoint(x: width/2, y: height/2)
        
        let body = SKPhysicsBody(rectangleOfSize: image!.size)
        body.dynamic = false
        body.affectedByGravity = false
        body.categoryBitMask = BodyType.ground.rawValue
        body.collisionBitMask = BodyType.ground.rawValue
        body.contactTestBitMask = BodyType.bird.rawValue
        groundBody.physicsBody = body
        
        return groundBody
    }
    
    func askToPlayAgain() {
        let alertView = SIAlertView(title: "Ouch!!", andMessage: "Congratulations! Your score is \(score.currentScore). Play again?")
        
        alertView.addButtonWithTitle("OK", type: .Default) { _ in self.onPlayAgainPressed() }
        alertView.addButtonWithTitle("Cancel", type: .Default) { _ in self.onCancelPressed() }
        alertView.show()
    }
}

