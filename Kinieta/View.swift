//
//  Extensions.swift
//  Kinieta
//
//  Created by Michael Michailidis on 06/09/2017.
//  Copyright © 2017 Michael Michailidis. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    func move(_ dict: [String:Any], during duration: TimeInterval = 0.0) -> Sequence {
        let sequence = Sequence(view: self)
        sequence.move(dict, during: duration)
        Engine.shared.add(sequence: sequence)
        return sequence
    }
    @discardableResult
    func wait(time: TimeInterval) -> Sequence {
        let sequence = Sequence(view: self)
        sequence.wait(for: time)
        Engine.shared.add(sequence: sequence)
        return sequence
    }
}

extension UIView {
    var rotation:CGFloat {
        get {
            return atan2(self.transform.b, self.transform.a);
        }
        set {
            let rads = radians(newValue)
            var tr_p = self.transform
            tr_p.a =  cos(rads)
            tr_p.b =  sin(rads)
            tr_p.c = -sin(rads)
            tr_p.d =  cos(rads)
            self.transform = tr_p
        }
    }
}

func >>(lhs: Range<TimeInterval>, rhs: TimeInterval) -> Range<TimeInterval> {
    return (lhs.lowerBound+rhs)..<(lhs.upperBound+rhs)
}
