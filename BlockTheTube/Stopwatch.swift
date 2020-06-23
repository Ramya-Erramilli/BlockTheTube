//
//  Stopwatch.swift
//  BlockTheTube
//
//  Created by Ramya Seshagiri on 23/06/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import Foundation
class Stopwatch{
    
    private var startTime : NSDate?
    
    var elapsedTime: TimeInterval{
        if let startTime = self.startTime{
            return -startTime.timeIntervalSinceNow
        }else{
            return 0
        }
    }
    
    var isRunning:Bool{
        return startTime != nil
    }
    
    func start(){
        startTime = NSDate()
    }
    func stop() {
        startTime = nil
    }
    
    
}
