//
//  Pipes.swift
//  Flappy
//
//  Created by liusy182 on 21/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//

import SpriteKit

class Pipes {
    private class var createActionKey : String { get {return "createActionKey"} }
    private var parentNode: SKSpriteNode!
    private let topPipeTexture: String
    private let bottomPipeTexture: String
    
    init(topPipeTexture: String, bottomPipeTexture: String) {
        self.topPipeTexture = topPipeTexture
        self.bottomPipeTexture = bottomPipeTexture
    }
    
    func addTo(parentNode: SKSpriteNode) -> Pipes {
        self.parentNode = parentNode
        return self
    }
}

//MARK: Startable
extension Pipes : Startable {
    func start() {
        let createAction = SKAction.repeatActionForever(
            SKAction.sequence(
                [
                    SKAction.runBlock {
                        self.createNewPipesNode()
                    },
                    SKAction.waitForDuration(3)
                ]
            ) )
        parentNode.runAction(createAction, withKey: Pipes.createActionKey)
    }
    
    func stop() {
        print ("pipes stop")
        parentNode.removeActionForKey(Pipes.createActionKey)
        
        let pipeNodes = parentNode.children.filter {
            $0.name == PipesNode.kind
        }
        for pipe in pipeNodes {
            pipe.removeAllActions()
        }
    }
}

//MARK: Private
private extension Pipes {
    func createNewPipesNode() {
        PipesNode(topPipeTexture: topPipeTexture, bottomPipeTexture:bottomPipeTexture, centerY: centerPipes()).addTo(parentNode).start()
    }
    
    func centerPipes() -> CGFloat {
        return parentNode.size.height/2 - 100 + 20 * CGFloat(arc4random_uniform(10))
    }
}