//
//  WebSocketHandler.swift
//  SoftLight
//
//  Created by Ben Groß on 11/12/21.
//

import Foundation
import SwiftUI



class WebSocketHandler: ObservableObject{
    var websockets = [WebSocketConnection]()
    
    init(devices: Array<Device>){
        for device in devices {
            if let ip = device.ip {
                websockets.append(WebSocketConnection(ip: ip))
            }
        }
    }
    
    func connectAll(){
        for websocket in websockets {
            websocket.connect()
        }
    }
    
    func disconnectAll(){
        for websocket in websockets {
            websocket.disconnect()
        }
    }
    
    func broadcastMessage(message: PackedMessage){
        for websocket in websockets {
            websocket.sendMessage(message: message)
        }
    }
    
    func getWebSocketConnection(ip: String) -> WebSocketConnection?{
        websockets.first(where: { $0.ip == ip})
    }
    
}


class WebSocketConnection {
    var ip: String
    
    init(ip: String){
        self.ip = ip
    }
    
    func connect(){
        
    }
    
    func disconnect(){
        
    }
    
    func sendMessage(message: PackedMessage){
        
    }
    
    func requestStatus() -> PackedMessage{
        return PackedMessage(hue: 0, sat: 0, val: 0, white: 0)
    }
    
}

protocol SoftLightMessage {
    var hue: Int { get set }
    var sat: Int { get set }
    var val: Int { get set }
    var white: Int { get set }
    func generateStringMessage() -> String
}

class PackedMessage: SoftLightMessage {
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
    
    func generateStringMessage() -> String {
        var message = "#"
        message += String(format:"%02X", hue)
        message += String(format:"%02X", sat)
        message += String(format:"%02X", val)
        message += String(format:"%02X", white)
        
        return message
    }
}
