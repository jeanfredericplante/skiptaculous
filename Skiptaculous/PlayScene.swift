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
    let hero = SKSpriteNode(imageNamed:"hero")
    let heroScale = CGFloat(0.15)

    var origRunningBarPosition = CGFloat(0)
    var repeatPixels = CGFloat(286)
    var groundSpeed = CGFloat(5)
    var heroBaseline = CGFloat(0)
    var xFramePos =  CGFloat(0)
    
    
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.whiteColor()
        self.xFramePos = CGRectGetMinX(self.frame)
        self.runningBar.anchorPoint =  CGPointMake(0,0);
        self.runningBar.position = CGPointMake(
            self.xFramePos,
            CGRectGetMinY(self.frame) - 0.7*self.runningBar.size.height)
        
        self.origRunningBarPosition = self.runningBar.position.x
        self.repeatPixels *= -1
        
        self.heroBaseline = CGRectGetMaxY(self.runningBar.frame)
        self.hero.xScale = heroScale
        self.hero.yScale = self.hero.xScale
        self.hero.position = CGPointMake(self.xFramePos + self.hero.size.width/2,
            self.heroBaseline + self.hero.size.height/2)

        
        
        self.addChild(self.runningBar)
        self.addChild(self.hero)
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        // shifts the ground
        if self.runningBar.position.x <= repeatPixels {
            self.runningBar.position.x = self.origRunningBarPosition
        }
        runningBar.position.x -= CGFloat(self.groundSpeed)
        
        
        // rotate the ball
        self.hero.zRotation -= 2*self.groundSpeed/(self.hero.size.height)
    }
}
