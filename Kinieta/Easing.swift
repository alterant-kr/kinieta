/*
 * Easing.swift
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

import Foundation

// Easing curves are from https://github.com/ai/easings.net/

struct Easing {
    
    enum Types {
        case Sine
        case Quad
        case Cubic
        case Quart
        case Quint
        case Expo
        case Back
        case Custom(Bezier)
        var string: String {
            switch self {
            case .Sine:      return "sine"
            case .Quad:      return "quad"
            case .Cubic:     return "cubic"
            case .Quart:     return "quart"
            case .Quint:     return "quint"
            case .Expo:      return "expo"
            case .Back:      return "back"
            case .Custom:    return "Custom"
            }
        }
    }
    
    static let Linear = Bezier(0.250, 0.250,  0.750,  0.750)
    
    static private let curves: [String: Bezier] = [
        
        "sineIn":       Bezier(0.47,  0,      0.745,  0.715),
        "sineOut":      Bezier(0.39,  0.575,  0.565,  1.0),
        "sineInOut":    Bezier(0.455, 0.03,   0.515,  0.955),
        
        "quadIn":       Bezier(0.55,  0.085,  0.68,   0.53),
        "quadOut":      Bezier(0.25,  0.46,   0.45,   0.94),
        "quadInOut":    Bezier(0.455, 0.03,   0.515,  0.955),
        
        "cubicIn":      Bezier(0.55,  0.055,  0.675,  0.19),
        "cubicOut":     Bezier(0.215, 0.61,   0.355,  1.0),
        "cubicInOut":   Bezier(0.645, 0.045,  0.355,  1.0),
        
        "quartIn":      Bezier(0.895, 0.03,   0.685,  0.22),
        "quartOut":     Bezier(0.165, 0.84,   0.44,   1.0),
        "quartInOut":   Bezier(0.77,  0,      0.175,  1.0),
        
        "quintIn":      Bezier(0.755, 0.05,   0.855,  0.06),
        "quintOut":     Bezier(0.23,  1.0,    0.32,   1.0),
        "quintInOut":   Bezier(0.86,  0,      0.07,   1.0),
        
        "expoIn":       Bezier(0.95,  0.05,   0.795,  0.035),
        "expoOut":      Bezier(0.19,  1.0,    0.22,   1.0),
        "expoInOut":    Bezier(1.0,   0,      0,      1.0),
        
        "backIn":       Bezier(0.6,  -0.28,   0.735,  0.045),
        "backOut":      Bezier(0.175, 0.885,  0.32,   1.275),
        "backInOut":    Bezier(0.68, -0.55,   0.265,  1.55),
    ]
    
    static func Get(_ type: Types, _ place: String) -> Bezier? {
        
        switch type {
        case .Custom(let bezier):
            return bezier
        default:
            return self.curves[(type.string+place)]
        }
    }
}






