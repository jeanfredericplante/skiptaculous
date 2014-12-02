//
//  BlockStatus.swift
//  Skiptaculous
//
//  Created by Jean Frederic Plante on 12/1/14.
//  Copyright (c) 2014 Jean Frederic Plante. All rights reserved.
//

import Foundation

class BlockStatus {
    var isRunning: Bool
    var currentInterval = UInt32(0)
    var timeGapForNextRun = UInt32(0)
    
    init(isRunning: Bool, currentInterval: UInt32, timeGapForNextRun: UInt32) {
        self.isRunning = isRunning
        self.currentInterval = currentInterval
        self.timeGapForNextRun = timeGapForNextRun
    }
    
    func shouldRunBlock()->Bool {
        return currentInterval > timeGapForNextRun
    }
    
}