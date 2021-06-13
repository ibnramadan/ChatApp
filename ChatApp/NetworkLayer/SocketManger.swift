//
//  SocketManger.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//

//
import UIKit
import Foundation
import SocketIO
import ObjectMapper

let Host = "https://task-ksa.herokuapp.com"


final class SocketManger: NSObject {
    
    static let shared = SocketManger()
    private var manager: SocketManager?
    private var socket: SocketIOClient?
    
    override init() {
        super.init()
        configureSocketClient()
    }
    
    private func configureSocketClient() {
        
        guard let url = URL(string:Host) else {
            return
        }
        
        let myID = LoginData.loadSavedLoginData()?.user?.id ?? 0
        manager = SocketManager(socketURL: url, config: [
                                    .connectParams(["id": myID]),
                                    .secure(true),
                                    .forceWebsockets(true),
                                    .reconnects(true),
                                    .compress,
                                    .log(true)])
        
        guard let manager = manager else {
            return
        }
        
        socket = manager.socket(forNamespace: "/chat")
    }
    
    func establishConnection() {
        
        guard let socket = manager?.socket(forNamespace: "/chat") else{
            return
        }
                
        socket.on(clientEvent: .connect) { (data, ackm) in
            print(data)
        }
        socket.on(clientEvent: .error) { (data, ackm) in
            print(data)
        }
        socket.on(clientEvent: .disconnect) { (data, ackm) in
            print(data)
        }
        
        socket.on("addFriend") { (dataArray, socketAck) in
            print(dataArray)
        }
        
        socket.connect()
    }
    
    func closeConnection() {
        
        guard let socket = manager?.socket(forNamespace: "/chat") else{
            return
        }
        
        socket.disconnect()
    }
    
    func addNewFriend(friendId: Int, completion: () -> Void) {
        
        guard let socket = manager?.socket(forNamespace: "/chat") else {
            return
        }
        
        let myID = LoginData.loadSavedLoginData()?.user?.id ?? 0
        let jsonDict: [String : Any] = [
            "myId": myID,
            "friendId": friendId]
        
        socket.emit("addFriend", jsonDict)
        completion()
    }
    
    func sendNewMessage(friendId: Int, content: String?, messageType: String? = "txt", completion: () -> Void) {
        
        guard let socket = manager?.socket(forNamespace: "/chat") else{
            return
        }
        
        let myId = LoginData.loadSavedLoginData()?.user?.id ?? 0
        
        let user: [String: Any] = [
            "_id" : myId
        ]
        
        let msgData: [String: Any] = [
            "msgType": messageType ?? "txt",
            "user": user,
            "content"  : content ?? ""
        ]
        
        let json : [String : Any] = [
            "toId": friendId,
            "data": msgData]
        
        socket.emit("newMessage", json)
        completion()
    }
    
    
    func getNewMessages(completion: @escaping (_ messageData: chatMessage?) -> Void) {
        
        guard let socket = manager?.socket(forNamespace: "/chat") else {
            return
        }
        
        socket.on("newMessage") { (data, socketAck) in
            
            
            guard let msgItem = data[0] as? [String: Any] else{
                return
            }
                let messageModel =  Mapper<chatMessage>().map(JSON: msgItem )
                completion(messageModel)
           
        }
    }
    
    func seeMessage(friendId: Int, completion: () -> Void) {
        
        guard let socket = manager?.socket(forNamespace: "/chat") else {
            return
        }
        
        let myID = LoginData.loadSavedLoginData()?.user?.id ?? 0
        let jsonDict: [String : Any] = [
            "myId": myID,
            "toId": friendId]
        
        socket.emit("seen", jsonDict)
        completion()
    }
    
    func getSeenMessage(completion: @escaping (_ messageData: chatMessage?) -> Void) {
        
        guard let socket = manager?.socket(forNamespace: "/chat") else {
            return
        }
        
        socket.on("seen") { (data, socketAck) in
            
            
            guard let msgItem = data[0] as? [String: Any] else{
                return
            }
                let messageModel =  Mapper<chatMessage>().map(JSON: msgItem )
                completion(messageModel)
           
        }
    }

    
}
