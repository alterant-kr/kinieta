/*
 * View.swift
 * Created by Michael Michailidis on 16/10/2017.
 * http://blog.karmadust.com/
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import UIKit

extension UIView {
    @discardableResult
    func move(to dict: [String:Any], during duration: TimeInterval = 0.0) -> Kinieta {
        let kinieta = Kinieta(for: self)
        kinieta.move(to: dict, during: duration)
        Engine.shared.add(kinieta.mainSequence)
        return kinieta
    }
    @discardableResult
    func wait(for time: TimeInterval) -> Kinieta {
        let kinieta = Kinieta(for: self)
        kinieta.wait(for: time)
        Engine.shared.add(kinieta.mainSequence)
        return kinieta
    }
}

extension UIView {
    var x: CGFloat {
        get {
           return self.frame.origin.x
        }
        set {
            let oFrame = self.frame
            self.frame = CGRect(
                x: newValue, y: oFrame.origin.y, width: oFrame.size.width, height: oFrame.size.height
            )
        }
    }
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            let oFrame = self.frame
            self.frame = CGRect(
                x: oFrame.origin.x, y: newValue, width: oFrame.size.width, height: oFrame.size.height
            )
        }
    }
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            let oFrame = self.frame
            self.frame = CGRect(
                x: oFrame.origin.x, y: oFrame.origin.y, width: newValue, height: oFrame.size.height
            )
        }
    }
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            let oFrame = self.frame
            self.frame = CGRect(
                x: oFrame.origin.x, y: oFrame.origin.y, width: oFrame.size.width, height: newValue
            )
        }
    }
    var rotation:CGFloat {
        get {
            return atan2(self.transform.b, self.transform.a).radiansToDegrees
        }
        set {
            let rads = newValue.degreesToRadians
            var tr_p = self.transform
            tr_p.a =  cos(rads)
            tr_p.b =  sin(rads)
            tr_p.c = -sin(rads)
            tr_p.d =  cos(rads)
            self.transform = tr_p

        }
    }
    
    var backgroundColorOrClear: UIColor {
        return self.backgroundColor ?? UIColor.clear
    }
    var borderColorOrClear: UIColor {
        if let bc = self.layer.borderColor {
            return UIColor(cgColor: bc)
        }
        return UIColor.clear
    }
}


func >>(lhs: Range<TimeInterval>, rhs: TimeInterval) -> Range<TimeInterval> {
    return (lhs.lowerBound+rhs)..<(lhs.upperBound+rhs)
}

extension UIView {
    var properties: [String: Any] {
        get {
            var dict = [String: Any]()
            
            dict["x"] = self.frame.origin.x
            dict["y"] = self.frame.origin.y
            dict["w"] = self.frame.size.width
            dict["h"] = self.frame.size.height
            dict["r"] = self.rotation
            dict["a"] = self.alpha
            
            if let bg = self.backgroundColor {
                dict["bg"] = bg
            }
            
            if let brc = self.layer.borderColor {
                dict["brc"] = UIColor(cgColor: brc)
            }
            dict["brw"] = self.layer.borderWidth
            dict["crd"] = self.layer.cornerRadius
            
            return dict
        }
    }
}

