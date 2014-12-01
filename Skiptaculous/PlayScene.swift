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
    let block1 = SKSpriteNode(imageNamed:"block1")
    let block2 = SKSpriteNode(imageNamed:"block2")
    let heroScale = CGFloat(0.15)

    var origRunningBarPosition = CGFloat(0)
    var repeatPixels = CGFloat(286)
    var groundSpeed = CGFloat(5)
    var heroBaseline = CGFloat(0)
    var xFramePos =  CGFloat(0)
    var onGround = true
    var velocityY = CGFloat(0)
    var horizontalBarSliding = CGFloat(0)
    var gravity = CGFloat(0.6)
    
    
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.whiteColor()
        self.xFramePos = CGRectGetMinX(self.frame)
        
        // position running bar
        self.runningBar.anchorPoint =  CGPointMake(0,0);
        self.runningBar.position = CGPointMake(
            self.xFramePos,
            CGRectGetMinY(self.frame) - 0.7*self.runningBar.size.height)
        
        self.origRunningBarPosition = self.runningBar.position.x
        self.repeatPixels *= -1
        
        
        // scale objects
        scaleObject(self.hero, scale: heroScale)
        scaleObject(self.block1, scale: heroScale)
        scaleObject(self.block2, scale: heroScale)

        
        // position hero
        self.heroBaseline = CGRectGetMaxY(self.runningBar.frame)
        self.hero.position = CGPointMake(self.xFramePos + self.hero.size.width/2,
            self.heroBaseline + self.hero.size.height/2)

        // position blocks
        self.block1.position = CGPointMake(
            CGRectGetMaxX(self.frame),
            getGroundPositionY(block1))
        
        self.addChild(self.runningBar)
        self.addChild(self.hero)
        self.addChild(self.block1)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
            if (objectTouchesGround(self.hero)) {
                self.velocityY = -19.0
            }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if self.velocityY < -9.0 {
            self.velocityY = -9.0
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        // shifts the ground
        horizontalBarSliding += CGFloat(self.groundSpeed)
        horizontalBarSliding = horizontalBarSliding%repeatPixels
        runningBar.position.x = self.origRunningBarPosition - horizontalBarSliding
        
        
        // rotate the ball
        self.hero.zRotation -= 2*self.groundSpeed/(self.hero.size.height)
        
        // jumps
        self.velocityY += self.gravity
        self.hero.position.y -= self.velocityY
        
        if (objectTouchesGround(self.hero)) {
            self.hero.position.y = getGroundPositionY(self.hero)
            self.velocityY = 0
        }
        
    }
    
    func objectTouchesGround(myblob: SKSpriteNode) -> Bool {
        if (myblob.position.y - myblob.size.height/2) < self.heroBaseline {
            return true
        } else {
            return false
        }
    }
    
    func getGroundPositionY(myblob: SKSpriteNode) -> CGFloat {
        return self.heroBaseline + myblob.size.height/2
    }
    
    func scaleObject(myblob: SKSpriteNode, scale: CGFloat) -> Void {
        myblob.xScale = scale
        myblob.yScale = myblob.xScale
    }
}
