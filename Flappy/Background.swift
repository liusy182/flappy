//
//  Background.swift
//  Flappy
//
//  Created by liusy182 on 19/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//

import SpriteKit

class Background {
    private let parallaxNode: ParallaxNode
    private let duration: Double
    
    init(textureNamed textureName: String, duration: Double) {
        parallaxNode = ParallaxNode(textureNamed: textureName)
        self.duration = duration
    }
    
    func addTo(parentNode: SKSpriteNode, zPosition: CGFloat) -> Self {
        parallaxNode.addTo(parentNode, zPosition: zPosition)
        return self
    }
    
    func zPosition(pos: CGFloat) {
        parallaxNode.zPosition(pos)
    }
}

// Startable
extension Background : Startable {
    func start() {
        parallaxNode.start(duration: duration)
    }
    
    func stop() {
        parallaxNode.stop()
    }
}