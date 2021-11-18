//
//  WebSocketHandler.swift
//  SoftLight
//
//  Created by Ben Groß on 11/12/21.
//

import Foundation
import SwiftUI



class WebSocketHandler: ObservableObject{
    @Published var websockets = [WebSocketConnection]()
    
    init(){
        
    }
    
    func createWebsockets(devices: Array<String>){
        for device in devices {
            //if let ip = device.ip {
                websockets.append(WebSocketConnection(ip: device))
            //}
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
            //websocket.sendMessage(message: message)
        }
    }
    
    func getWebSocketConnection(ip: String) -> WebSocketConnection?{
        websockets.first(where: { $0.ip == ip})
    }
    
}


class WebSocketConnection: ObservableObject {
    var ip: String
    private var id:
    UUID!
    private let session: URLSession
    var socket: URLSessionWebSocketTask!
    
    init(ip: String){
        self.ip = ip
        self.session = URLSession(configuration: .default)
        self.connect()
    }
    
    func connect(){
        self.socket = session.webSocketTask(with: URL(string: "ws://" + self.ip)!)
        self.listen()
        self.socket.resume()
    }
    
    func disconnect(){
        self.socket.cancel(with: URLSessionWebSocketTask.CloseCode.normalClosure, reason: nil)
    }
    
    func listen() {
        self.socket.receive { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                case .failure(_):
                /*case .failure(let error):
                  print(error)
                  let alert = Alert(
                      title: Text("Unable to connect to server!"),
                      dismissButton: .default(Text("Retry")) {
                        self.socket.cancel(with: .goingAway, reason: nil)
                        self.connect()
                      }
                  )
                */
                    return
                case .success(let message):
                switch message {
                    case .data(let data):
                        print(data)
                    case .string(let str):
                        self.handle(str)
                    @unknown default:
                        break
                }
            }
            self.listen()
        }
    }
    
    func handle(_ data: String) {
        print(data)
    }
    
    func sendMessage(message: PackedMessage) async{
        do {
            try await self.socket.send(.string(message.generateStringMessage()))
        }
        catch {
            print(error)
        }
    }
    
    func requestStatus() -> PackedMessage{
        let message: String = "#123456FF"

        
        return PackedMessage(hexString: message)
    }
    
}

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
