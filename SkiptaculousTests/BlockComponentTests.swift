//
//  BlockComponentTests.swift
//  Skiptaculous
//
//  Created by Jean Frederic Plante on 12/2/14.
//  Copyright (c) 2014 Jean Frederic Plante. All rights reserved.
//

import UIKit
import XCTest
import SpriteKit

class BlockComponentTests: XCTestCase {
    
    let scene = SKScene(size: CGSize(width: 130, height: 300))
    var bc = BlockComponent(isRunning: false, node: SKSpriteNode(imageNamed:"block1"))

    override func setUp() {
       super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewIsLoading() {
        // This is an example of a functional test case.

    }
    
    func testBlockIsNotInView() {
        bc.blockNode.position = CGPointMake(CGRectGetMaxX(scene.frame)+bc.blockNode.size.width,0)
        XCTAssertFalse(bc.isWithinFrame(scene), "block should not be in view")
    }
    
    func testBlockIsInView() {
        bc.blockNode.position = CGPointMake(CGRectGetMaxX(scene.frame)-1,0)
        XCTAssertTrue(bc.isWithinFrame(scene), "block should be in view")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}