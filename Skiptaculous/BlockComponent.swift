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
    
    init(isRunning: Bool, node: SKSpriteNode) {
        self.isRunning = isRunning
        self.blockNode = node
    }
    
    func moveBlockBy(delta: CGFloat) -> Void {
        self.blockNode.position.x += delta
    }
    
    func isWithinFrame(scene: SKScene) -> Bool {
        var blobMaxX = CGRectGetMaxX(blockNode.frame)
        var blobMinX = CGRectGetMinX(blockNode.frame)
        var atLeastRightSideInView =  (blobMaxX > CGRectGetMinX(scene.frame)) && (blobMaxX <  CGRectGetMaxX(scene.frame))
        var atLeastLeftSideInView =  (blobMinX > CGRectGetMinX(scene.frame)) && (blobMinX <  CGRectGetMaxX(scene.frame))
        return atLeastRightSideInView || atLeastLeftSideInView
    }
    
}