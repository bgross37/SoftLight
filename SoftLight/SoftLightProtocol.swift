//
//  SoftLightProtocol.swift
//  SoftLight
//
//  Created by Ben Groß on 11/17/21.
//

import Foundation

protocol SoftLightMessage {
    var hue: Int { get set }
    var sat: Int { get set }
    var val: Int { get set }
    var white: Int { get set }
    func generateStringMessage() -> String
}

class PackedMessage: SoftLightMessage, Equatable {
    static func == (lhs: PackedMessage, rhs: PackedMessage) -> Bool {
        if(lhs.hue == rhs.hue && lhs.sat == rhs.sat && lhs.val == rhs.val && lhs.white == rhs.white) {
            return true
        }
        else{
            return false
        }
    }
    
    var hue: Int
    var sat: Int
    var val: Int
    var white: Int
    
    init(hue: Int, sat: Int, val: Int, white: Int){
        self.hue = hue
        self.sat = sat
        self.val = val
        self.white = white
    }
    
    init(hexString: String){
        self.hue = Int(hexString[hexString.index(hexString.startIndex, offsetBy: 1)...hexString.index(hexString.startIndex, offsetBy: 2)], radix: 16) ?? 0
        self.sat = Int(hexString[hexString.index(hexString.startIndex, offsetBy: 3)...hexString.index(hexString.startIndex, offsetBy: 4)], radix: 16) ?? 0
        self.val = Int(hexString[hexString.index(hexString.startIndex, offsetBy: 5)...hexString.index(hexString.startIndex, offsetBy: 6)], radix: 16) ?? 0
        self.white = Int(hexString[hexString.index(hexString.startIndex, offsetBy: 7)...hexString.index(hexString.startIndex, offsetBy: 8)], radix: 16) ?? 0
    }
    
    func setHex(hexString: String){
        self.hue = Int(hexString[hexString.index(hexString.startIndex, offsetBy: 1)...hexString.index(hexString.startIndex, offsetBy: 2)], radix: 16) ?? 0
        self.sat = Int(hexString[hexString.index(hexString.startIndex, offsetBy: 3)...hexString.index(hexString.startIndex, offsetBy: 4)], radix: 16) ?? 0
        self.val = Int(hexString[hexString.index(hexString.startIndex, offsetBy: 5)...hexString.index(hexString.startIndex, offsetBy: 6)], radix: 16) ?? 0
        self.white = Int(hexString[hexString.index(hexString.startIndex, offsetBy: 7)...hexString.index(hexString.startIndex, offsetBy: 8)], radix: 16) ?? 0
    }
    
    func generateStringMessage() -> String {
        var message = "#"
        message += String(format:"%02X", hue)
        message += String(format:"%02X", sat)
        message += String(format:"%02X", val)
        message += String(format:"%02X", white)
        
        return message
    }
}
