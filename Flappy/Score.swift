//
//  Score.swift
//  Flappy
//
//  Created by liusy182 on 23/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//

import SpriteKit

class Score {
    private let score = SKLabelNode(text: "0")
    var currentScore = 0
    
    func addTo(parentNode: SKSpriteNode) -> Score {
        score.fontName = "MarkerFelt-Wide"
        score.fontSize = 30
        score.position = CGPoint(x: parentNode.size.width/2, y: parentNode.size.height - 40)
        parentNode.addChild(score)
        return self
    }
    
    func increase() {
        currentScore += 1
        score.text = "\(currentScore)"
    }
}