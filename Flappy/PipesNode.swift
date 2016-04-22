//
//  PipesNode.swift
//  Flappy
//
//  Created by liusy182 on 21/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//
import SpriteKit

class PipesNode {
    class var kind : String { get {return "PIPES"} }
    private let gapSize: CGFloat = 50
    
    private let pipesNode: SKNode
    private let finalOffset: CGFloat!
    private let startingOffset: CGFloat!
    
    init(topPipeTexture: String, bottomPipeTexture: String, centerY: CGFloat){
        pipesNode = SKNode()
        pipesNode.name = PipesNode.kind
        
        let pipeTop = PipesNode.createPipe(topPipeTexture)
        let pipeTopPosition = CGPoint(x: 0, y: centerY + pipeTop.size.height/2 + gapSize)
        pipeTop.position = pipeTopPosition
        pipesNode.addChild(pipeTop)
        
        let pipeBottom = PipesNode.createPipe(bottomPipeTexture)
        let pipeBottomPosition = CGPoint(x: 0, y: centerY - pipeBottom.size.height/2 - gapSize)
        pipeBottom.position = pipeBottomPosition
        pipesNode.addChild(pipeBottom)
        
        let gapNode = PipesNode.createGap(size: CGSize(
            width: pipeBottom.size.width,
            height: gapSize*2))
        gapNode.position = CGPoint(x: 0, y: centerY)
        pipesNode.addChild(gapNode)
        
        finalOffset = -pipeBottom.size.width
        startingOffset = -finalOffset
    }
    
    private class func createPipe(imageNamed: String) -> SKSpriteNode {
        let pipeNode = SKSpriteNode(imageNamed: imageNamed)
        
        let size = CGSize(width: pipeNode.size.width, height: pipeNode.size.height)
        let physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody.dynamic = false
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = BodyType.pipe.rawValue
        physicsBody.collisionBitMask = BodyType.pipe.rawValue
        pipeNode.physicsBody = physicsBody
        
        return pipeNode
    }
    
    private class func createGap(size size: CGSize)-> SKSpriteNode {
        let gapNode = SKSpriteNode(
            color: UIColor.clearColor(),
            size: size)
        gapNode.zPosition = 6
        
        let physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody.dynamic = false
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = BodyType.gap.rawValue
        physicsBody.collisionBitMask = BodyType.gap.rawValue
        gapNode.physicsBody = physicsBody
        
        return gapNode
    }
    
    func addTo(parentNode: SKSpriteNode) -> PipesNode {
        let pipePosition = CGPoint(x: parentNode.size.width + startingOffset, y: 0)
        pipesNode.position = pipePosition
        pipesNode.zPosition = 4
        
        parentNode.addChild(pipesNode)
        return self
    }
    
    func start() {
        pipesNode.runAction(SKAction.sequence(
            [
                SKAction.moveToX(finalOffset, duration: 6.0),
                SKAction.removeFromParent()
            ]
            ))
    }
    
}