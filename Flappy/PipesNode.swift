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
        
        finalOffset = -pipeBottom.size.width
        startingOffset = -finalOffset
    }
    
    class func createPipe(imageNamed: String) -> SKSpriteNode {
        let pipeNode = SKSpriteNode(imageNamed: imageNamed)
        return pipeNode
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