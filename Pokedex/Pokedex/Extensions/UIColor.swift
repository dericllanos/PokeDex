//
//  TypeColours.swift
//  Pokedex
//
//  Created by Frederic Rey Llanos on 09/05/2022.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    // MARK: - Type Colours
    //  Bug, Dragon, Electric, Fighting, Fire, Flying, Ghost, Grass, Ground, Ice, Normal, Poison, Psychic, Rock, and Water (Gen 1) + Fairy, Steel
    
    static func fairy() -> UIColor {
        return UIColor.rgb(red: 240, green: 182, blue: 188)
    }
    
    static func steel() -> UIColor {
        return UIColor.rgb(red: 184, green: 184, blue: 208)
    }
    
    static func normal() -> UIColor {
        return UIColor.rgb(red: 170, green: 170, blue: 153)
    }
    
    static func bug() -> UIColor {
        return UIColor.rgb(red: 170, green: 188, blue: 37)
    }
    
    static func dragon() -> UIColor {
        return UIColor.rgb(red: 117, green: 100, blue: 236)
    }
    
    static func electric() -> UIColor {
        return UIColor.rgb(red: 255, green: 204, blue: 51)
    }
    
    static func fighting() -> UIColor {
        return UIColor.rgb(red: 187, green: 85, blue: 69)
    }
    
    static func fire() -> UIColor {
        return UIColor.rgb(red: 255, green: 68, blue: 36)
    }
    
    static func water() -> UIColor {
        return UIColor.rgb(red: 51, green: 153, blue: 255)
    }
    
    static func grass() -> UIColor {
        return UIColor.rgb(red: 119, green: 204, blue: 87)
    }
    
    static func ghost() -> UIColor {
        return UIColor.rgb(red: 102, green: 102, blue: 187)
    }
    
    static func flying() -> UIColor {
        return UIColor.rgb(red: 136, green: 154, blue: 255)
    }
    
    static func poison() -> UIColor {
        return UIColor.rgb(red: 170, green: 86, blue: 153)
    }
    
    static func rock() -> UIColor {
        return UIColor.rgb(red: 187, green: 170, blue: 102)
    }
    
    static func ice() -> UIColor {
        return UIColor.rgb(red: 102, green: 204, blue: 255)
    }
    
    static func ground() -> UIColor {
        return UIColor.rgb(red: 222, green: 187, blue: 85)
    }
    
    static func psychic() -> UIColor {
        return UIColor.rgb(red: 255, green: 86, blue: 154)
    }
}
