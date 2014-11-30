//
//  PlayScene.swift
//  Skiptaculous
//
//  Created by Jean Frederic Plante on 11/29/14.
//  Copyright (c) 2014 Jean Frederic Plante. All rights reserved.
//

import SpriteKit

class PlayScene: SKScene {
    
    let runningBar = SKSpriteNode(imageNamed:"ground")
    var origRunningBarPosition = CGFloat(0)
    var maxBarX = CGFloat(286)
    var groundSpeed = 5
    
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.whiteColor()
        self.runningBar.anchorPoint =  CGPointMake(0,0);
        self.runningBar.position = CGPointMake(
            CGRectGetMinX(self.frame),
            CGRectGetMinY(self.frame) - 0.7*self.runningBar.size.height)
        self.addChild(self.runningBar)
        self.origRunningBarPosition = self.runningBar.position.x
        self.maxBarX *= -1
    }
    
    override func update(currentTime: NSTimeInterval) {
        if self.runningBar.position.x <= maxBarX {
            self.runningBar.position.x = self.origRunningBarPosition
        }
        runningBar.position.x -= CGFloat(self.groundSpeed)
    }
}
