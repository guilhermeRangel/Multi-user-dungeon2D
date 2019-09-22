//
//  Servidor.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 16/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation
import Network
import SpriteKit

class UDPServer {

    var listener : NWListener
    var queue : DispatchQueue
    var connected : Bool = false
    
    init?() {
        queue = DispatchQueue(label: "UDP Server Queue")
        
        //create the listener
        listener = try! NWListener(using: .udp, on: .http)
        listener.service = NWListener.Service(name: "serverMUD", type: "_http._udp", domain: "local", txtRecord: nil)
        listener.serviceRegistrationUpdateHandler = { (serviceChange) in
            
            print("registrando serviços \(serviceChange)")
            switch (serviceChange) {
            case .add(let endpoint):
                switch endpoint {
                    case let .service(name, _, _, _):
                        print("Servidor aberto com o nome - \(name)")
                @unknown default:
                    break
                }
            default:
                break
            }
            
        }
        
        
        //handle incoming connections
        listener.newConnectionHandler = { [weak self] (newConnection) in
            print("novo player se conectou com o servidor ")
            if let strongSelf = self {
                newConnection.start(queue: strongSelf.queue)
                strongSelf.receive(on: newConnection)
                
                
            }
            print("o jogador\(newConnection.debugDescription) conectou-se")
        }
        
        //handle listener state changes,
        //verifica as mudancas de estados
        
        //1
        listener.stateUpdateHandler = { [weak self] (newState) in
            switch (newState) {
            case .ready:
                print("Servidor conectado na porta : \(self!.listener.port!)")
            case .failed(let error):
                print("Listener failed with error: \(error)")
            default:
                break
            }
        }
        
        //start the listener
        listener.start(queue: queue)
        
        
    }
    
    struct sendAndReceiveMsgsCodable : Codable {
        var msgObj: String?
        var points : CGPoint?
    
    }

    
    //receive packets from the other side and push to scren as videos
    func receive(on connection: NWConnection){
        connection.receiveMessage { (content, context, isComplete, error) in
            // Extract your message type from the received context.
            if let frame = content {
                if !self.connected {
                    connection.send(content: frame, completion: .idempotent)
                    
                     let decoder = JSONDecoder()
                    
                    if let dataReceived = try? decoder.decode(sendAndReceiveMsgsCodable.self, from: frame) {
                        if let Obj = dataReceived.msgObj {
                            print("----------")
                            print("msg recebida : \(Obj)")
                               
                            print("----------")
                        }
                        if let ObjPosition = dataReceived.points {
                               print("msg recebida : \(ObjPosition)")
                        }
                    }
                    
                    
                    print("echoed initial content: \(frame)")
                    self.connected = true
                }else {
                    print("nao deu")
                }
                
                if error == nil {
                    self.receive(on: connection)
                }
            }
            
        }
    }
    
    
}

