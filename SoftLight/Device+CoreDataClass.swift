//
//  Device+CoreDataClass.swift
//  SoftLight
//
//  Created by Ben Groß on 11/17/21.
//

import Foundation
import CoreData
import Starscream

@objc(Device)
public class Device: NSManagedObject {
    
    @Published var hue: Double = 0
    @Published var sat: Double = 0
    @Published var val: Double = 0
    @Published var white: Double = 0
    
    private let session: URLSession = URLSession(configuration: .default)
    var socket: URLSessionWebSocketTask!
    
    /*
    init(context: NSManagedObjectContext){
        super.init(entity: NSEntityDescription.entity(forEntityName: "Device", in: context)!, insertInto: context)
    }
    
    init(context: NSManagedObjectContext, ip: String, friendlyname: String){
        super.init(entity: NSEntityDescription.entity(forEntityName: "Device", in: context)!, insertInto: context)
        self.ip = ip
        self.friendlyName = friendlyname
    }
    */
    
    func connect(){
        self.socket = session.webSocketTask(with: URL(string: "ws://\(self.ip)")!)
        self.socket.resume()
        self.listen()
        self.requestStatus()
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
                        print("Received Data: \(data)")
                    case .string(let str):
                        print("Received Message: \(str)")
                        let message: PackedMessage = PackedMessage(hexString: str)
                        
                        self.hue = Double(message.hue)
                        self.sat = Double(message.sat)
                        self.val = Double(message.val)
                        self.white = Double(message.white)
                    @unknown default:
                        break
                }
            }
            self.listen()
        }
    }
    
    func sendState(){
        Task {
            do {
                let message: PackedMessage = PackedMessage(hue: Int(self.hue), sat: Int(self.sat), val: Int(self.val), white: Int(self.white))
                try await self.socket.send(.string(message.generateStringMessage()))
            }
            catch {
                print("Error in sendStat: \(error)")
            }
        }
    }
    
    func requestStatus(){
        Task {
            do {
                try await self.socket.send(.string("$"))
            }
            catch {
                print("Error in requestState: \(error)")
            }
        }
    }
    
    func disconnect(){
        self.socket.cancel(with: URLSessionWebSocketTask.CloseCode.normalClosure, reason: nil)
    }
}
