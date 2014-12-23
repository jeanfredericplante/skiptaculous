//
//  BlockComponent.swift
//  Skiptaculous
//
//  Created by Jean Frederic Plante on 12/1/14.
//  Copyright (c) 2014 Jean Frederic Plante. All rights reserved.
//

import Foundation
import SpriteKit

class BlockComponent {
    var isRunning = false
    var blockNode: SKSpriteNode
    
    init(currentPosition: CGFloat, node: SKSpriteNode) {
        self.blockNode = node
        self.blockNode.position.x = currentPosition
        
    }
    
    func getBlockPosition() -> CGFloat {
        return self.blockNode.position.x
        
    }
    
    func setBlockPosition(position: CGFloat) -> Void {
         self.blockNode.position.x = position
        
    }
    
    func moveBlockBy(delta: CGFloat) -> Void {
        self.blockNode.position.x += delta
    }
    
    func isWithinFrame(scene: SKScene) -> Bool {
        var blobMaxX = CGRectGetMaxX(self.blockNode.frame)
        var blobMinX = CGRectGetMinX(self.blockNode.frame)
        var sceneMinX = CGRectGetMinX(scene.frame)
        var sceneMaxX = CGRectGetMaxX(scene.frame)
        var leftSideRightofView: Bool =  (blobMinX > sceneMaxX)
        var rightSideLeftofView: Bool =  (blobMaxX < sceneMinX)
        return !(leftSideRightofView || rightSideLeftofView)
    }
    
    func shouldBeReset(scene: SKScene) -> Bool {
        var blobMaxX = CGRectGetMaxX(self.blockNode.frame)
        var sceneMinX = CGRectGetMinX(scene.frame)
        var rightSideLeftofView: Bool =  (blobMaxX < sceneMinX)
        return rightSideLeftofView
    }
    
    func resetPosition(scene: SKScene, range: UInt32) -> Void {
        var posRange = UInt32(0)...UInt32(range)
        var sceneMaxX = CGRectGetMaxX(scene.frame)
        var newPosition = CGFloat(posRange.startIndex +
            arc4random_uniform(posRange.endIndex-posRange.startIndex + 1))
        newPosition += sceneMaxX + self.blockNode.size.width
        self.setBlockPosition(CGFloat(newPosition))
    }
    
}