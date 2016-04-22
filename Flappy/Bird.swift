//
//  Bird.swift
//  Flappy
//
//  Created by liusy182 on 20/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//


import SpriteKit

class Bird : Startable {
    private var node: SKSpriteNode!
    private let textureNames: [String]
    
    var position : CGPoint {
        set { node.position = newValue }
        get { return node.position }
    }
    
    init(textureNames: [String]) {
        self.textureNames = textureNames
        node = createNode()
    }
    
    func addTo(scene: SKSpriteNode) -> Bird{
        scene.addChild(node)
        return self
    }
    
    func start() {
        animate()
    }
    
    func stop() {
        node.physicsBody!.dynamic = false
        node.removeAllActions()
    }
    
    func update() {
        guard let physicsBody = node.physicsBody else { return }
        switch physicsBody.velocity.dy {
        case let dy where dy > 30.0:
            node.zRotation = (3.14/6.0)
        case let dy where dy < -100.0:
            node.zRotation = -1*(3.14/4.0)
        default:
            node.zRotation = 0.0
        }
    }
    
    func flap() {
        node.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        node.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 8))
    }
}

// private
private extension Bird {
    func createNode() -> SKSpriteNode {
        let birdNode = SKSpriteNode(imageNamed: textureNames.first!)
        birdNode.zPosition = 2.0
        
        let birdSize = CGSize(
            width: birdNode.size.width * 0.8,
            height: birdNode.size.height * 0.8)
        
        let physicsBody = SKPhysicsBody(rectangleOfSize: birdSize)
        physicsBody.dynamic = true
        physicsBody.dynamic = true
        physicsBody.categoryBitMask = BodyType.bird.rawValue
        
        physicsBody.collisionBitMask = BodyType.bird.rawValue
        
        physicsBody.contactTestBitMask =
            BodyType.ground.rawValue |
            BodyType.pipe.rawValue |
            BodyType.gap.rawValue
        
        birdNode.physicsBody = physicsBody
        return birdNode
    }
    
    func animate(){
        let animationFrames = textureNames.map { texName in
            SKTexture(imageNamed: texName)
        }
        
        node.runAction(
            SKAction.repeatActionForever(
                SKAction.animateWithTextures(animationFrames, timePerFrame: 0.5)
            ))
    }
}