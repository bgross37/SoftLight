//
//  WebSocketHandler.swift
//  SoftLight
//
//  Created by Ben Groß on 11/12/21.
//

import Foundation
import SwiftUI



/*class WebSocketHandler: ObservableObject{
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
*/
