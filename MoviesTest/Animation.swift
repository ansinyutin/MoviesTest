//
//  Animation.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 18.05.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

struct KeyFrame {
    var time:CGFloat = 0
    var value:CGFloat = 0
}

class Animation {
    
    static func getValue(frames: [KeyFrame], time:CGFloat) -> CGFloat {
        
        var value:CGFloat = 0
        
        if frames.count >= 2 {
            
            guard let lastFrame = frames.last,
                let firstFrame = frames.first else {
                return value
            }
            
            if time <= firstFrame.time {
                
                value = firstFrame.value
                
            } else if time >= lastFrame.time {
                
                value = lastFrame.value
            } else {
                
                for (index, frame) in frames.enumerated() {
                    
                    if index == 0 {
                        continue
                    }
                    
                    let prevFrame = frames[index - 1];
                    
                    if time >= prevFrame.time && time <= frame.time {
                        
                        let timeDiff = frame.time - prevFrame.time
                        let valueDiff = frame.value - prevFrame.value
                        
                        let ratio = valueDiff / timeDiff
                        
                        let timeMid = time - prevFrame.time
                        
                        value = timeMid * ratio + prevFrame.value
                    }
                }
            }
        }
        
        return value
    }
}
