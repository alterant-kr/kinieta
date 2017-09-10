//
//  Group.swift
//  Kinieta
//
//  Created by Michael Michailidis on 10/09/2017.
//  Copyright © 2017 Michael Michailidis. All rights reserved.
//

import UIKit

class Group: Action {
    
    let actions: [Action]
    
    init?(_ actions: [Action]) {
        guard let first = actions.first else { return nil }
        self.actions = actions
        super.init(first.view)
    }
    
    override func execute(_ frame: Engine.Frame) -> Bool {
        
        let results:[Bool] = actions.map {
            
            let completed = $0.update(frame)
            
            if completed {
                $0.onComplete()
                return true
            }
            
            return false
        }
        
        
        return !results.contains(false)
    }
    
    override func group() -> Action? {
        return self // cannot group a group
    }
    
    override func delay(by time: TimeInterval) -> Action {
        applyToAll { $0.delay(by: time) }
        return self
    }
    override func ease(_ curve: Bezier) -> Action {
        applyToAll { $0.ease(curve) }
        return self
    }
    
    private func applyToAll(_ f: (Action)->Void) {
        for action in actions { f(action) }
    }
}